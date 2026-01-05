<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.*, model.*, java.util.*"%>
<%
    // Mengecek apakah session "user" kosong (berarti belum login)
    if (session.getAttribute("user") == null) {
        // Simpan URL asal agar setelah login bisa langsung balik lagi ke sini (Optional)
        String targetUrl = request.getRequestURI() + "?" + request.getQueryString();
        session.setAttribute("redirectAfterLogin", targetUrl);
        
        // Alihkan ke halaman login
        response.sendRedirect("login.jsp?msg=Harus login terlebih dahulu");
        return; 
    }
    
    // Ambil parameter dari booking.jsp
    String movieIdStr = request.getParameter("movie_id");
    String scheduleIdStr = request.getParameter("schedule_id"); // GANTI dari cinema_id

    if (movieIdStr == null || scheduleIdStr == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    int movieId = Integer.parseInt(movieIdStr);
    int scheduleId = Integer.parseInt(scheduleIdStr);

    Movies movie = new MoviesDAO().getById(movieId);
    
    // Ambil detail jadwal (untuk harga dan info studio)
    ScheduleDAO sDao = new ScheduleDAO();
    BookingDAO bDao = new BookingDAO();
    
    List<String> takenSeats = sDao.getTakenSeats(scheduleId);
    // Kita gunakan method getScheduleById (pastikan sudah ada di DAO kamu)
    Map<String, Object> scheduleDetails = sDao.getScheduleById(scheduleId);
    
    if (movie == null || scheduleDetails == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // Ambil harga asli dari jadwal (bukan basePrice dari movie)
    double pricePerSeat = (Double) scheduleDetails.get("price");
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pilih Kursi: <%= movie.getTitle() %> — LayarKlik</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { background-color: #020617; color: #f8fafc; font-family: 'Plus Jakarta Sans', sans-serif; }
        .glass-card { background: rgba(15, 23, 42, 0.6); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.05); }
        .screen-glow { 
            height: 8px; width: 80%; margin: 0 auto;
            background: #2563eb; border-radius: 100%;
            filter: blur(20px); box-shadow: 0 0 40px #2563eb;
        }
        .seat-checkbox:checked + .seat-label { background-color: #2563eb; border-color: #60a5fa; color: white; transform: scale(1.1); }
        .seat-checkbox:disabled + .seat-label { background-color: #1e293b; color: #475569; cursor: not-allowed; opacity: 0.5; }
    </style>
</head>
<body class="antialiased">

    <main class="max-w-4xl mx-auto px-6 py-12">
        <div class="flex flex-col md:flex-row justify-between items-center mb-12 gap-6">
            <div>
                <a href="javascript:history.back()" class="text-gray-500 hover:text-white transition text-sm mb-2 inline-block">
                    <i class="fas fa-chevron-left mr-2"></i> Ganti Bioskop
                </a>
                <h1 class="text-3xl font-black italic tracking-tighter uppercase"><%= movie.getTitle() %></h1>
            </div>
            <div class="text-right flex gap-4">
                <div class="flex items-center gap-2"><div class="w-3 h-3 bg-slate-700 rounded-sm"></div> <span class="text-[10px] font-bold uppercase text-gray-500">Tersedia</span></div>
                <div class="flex items-center gap-2"><div class="w-3 h-3 bg-blue-600 rounded-sm"></div> <span class="text-[10px] font-bold uppercase text-gray-500">Pilihanmu</span></div>
            </div>
        </div>

        <div class="glass-card rounded-[3rem] p-12 mb-12">
            <div class="mb-20 text-center">
                <div class="screen-glow mb-4"></div>
                <p class="text-[10px] font-black tracking-[0.5em] text-gray-600 uppercase">Layar Bioskop</p>
            </div>

            <form action="paymentProcess.jsp" method="POST" id="seatForm">
                <input type="hidden" name="cinema_id" value="<%= scheduleDetails.get("cinema_id") %>">
                <input type="hidden" name="movie_id" value="<%= movieId %>">
                <input type="hidden" name="schedule_id" value="<%= scheduleId %>">
                <input type="hidden" name="total_price_input" id="total_price_input" value="0">

                <div class="flex flex-col gap-4 items-center">
                    <% 
                        String[] rows = {"A", "B", "C", "D", "E"};
                        for (String row : rows) {
                    %>
                    <div class="flex gap-3">
                        <span class="w-6 text-gray-600 font-bold text-sm flex items-center justify-center"><%= row %></span>
                        <div class="flex gap-2">
                            <% for (int i = 1; i <= 10; i++) { 
                                String seatId = row + i; 
                                boolean isTaken = takenSeats.contains(seatId);
                            %>
                                <div class="relative">
                                    <input type="checkbox" name="selected_seats" value="<%= seatId %>" 
                                            id="seat-<%= seatId %>" class="seat-checkbox hidden" 
                                            <%= isTaken ? "disabled" : "" %> 
                                            onchange="calculateTotal(<%= pricePerSeat %>)">
                                    <label for="seat-<%= seatId %>" 
                                            class="seat-label w-8 h-8 md:w-10 md:h-10 rounded-lg border border-white/5 
                                                   <%= isTaken ? "bg-red-900/50 border-red-500/50 cursor-not-allowed opacity-50" : "bg-white/5 cursor-pointer hover:border-blue-500/50" %> 
                                                   flex items-center justify-center text-[10px] font-bold transition-all">
                                         <%= isTaken ? "X" : i %>
                                     </label>
                                </div>
                                <% if (i == 5) { %> <div class="w-8"></div> <% } // Gang tengah %>
                            <% } %>
                        </div>
                    </div>
                    <% } %>
                </div>
            </form>
        </div>

        <div class="sticky bottom-8 glass-card rounded-3xl p-6 flex flex-col md:flex-row justify-between items-center shadow-2xl border border-blue-500/20">
            <div class="mb-4 md:mb-0">
                <p class="text-xs text-gray-500 uppercase font-bold tracking-widest">Kursi Terpilih</p>
                <p id="display-seats" class="text-lg font-black text-white italic">-</p>
            </div>
            <div class="flex items-center gap-8">
                <div class="text-right">
                    <p class="text-xs text-gray-500 uppercase font-bold tracking-widest">Total Harga</p>
                    <p id="display-total" class="text-2xl font-black text-blue-500">Rp 0</p>
                </div>
                <button type="button" onclick="submitForm()" class="bg-blue-600 hover:bg-blue-700 text-white px-10 py-4 rounded-2xl font-black uppercase tracking-widest shadow-lg shadow-blue-600/30 transition-all active:scale-95">
                    Konfirmasi
                </button>
            </div>
        </div>
    </main>

    <script>
        function calculateTotal(pricePerSeat) {
            const checkboxes = document.querySelectorAll('input[name="selected_seats"]:checked');
            const selectedCount = checkboxes.length;
            const total = selectedCount * pricePerSeat;
            
            // Update Teks Kursi
            let seats = [];
            checkboxes.forEach(cb => seats.push(cb.value));
            document.getElementById('display-seats').innerText = seats.length > 0 ? seats.join(', ') : '-';
            
            // Update Harga
            document.getElementById('display-total').innerText = 'Rp ' + total.toLocaleString('id-ID');
            document.getElementById('total_price_input').value = total;
        }

        function submitForm() {
            const checkboxes = document.querySelectorAll('input[name="selected_seats"]:checked');
            if (checkboxes.length === 0) {
                alert('Silakan pilih minimal satu kursi!');
                return;
            }
            document.getElementById('seatForm').submit();
        }
    </script>

</body>
</html>