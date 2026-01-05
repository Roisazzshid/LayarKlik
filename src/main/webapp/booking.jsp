<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.*, model.*, java.util.*"%>
<%
    // Mengecek apakah session "user" kosong (berarti belum login)
    if (session.getAttribute("user") == null) {
        // Simpan URL asal agar setelah login bisa langsung balik lagi ke sini (Optional)
        String targetUrl = request.getRequestURI() + "?" + request.getQueryString();
        session.setAttribute("redirectAfterLogin", targetUrl);
        
        // Alihkan ke halaman login
        response.sendRedirect("login.jsp?msg=Login");
        return; 
    }
    
    // Ambil ID Film dari parameter URL
    String idParam = request.getParameter("movie_id");
    if (idParam == null) { 
        System.out.println("DEBUG: movie_id null!"); // Cek di console NetBeans
        response.sendRedirect("index.jsp?error=id_null"); 
        return; 
    }
    
    int movieId = Integer.parseInt(idParam);
    MoviesDAO mDao = new MoviesDAO();
    Movies movie = mDao.getById(movieId);
    
    if (movie == null) { 
        System.out.println("DEBUG: Film ID " + movieId + " tidak ada di DB!"); 
        response.sendRedirect("index.jsp?error=movie_not_found"); 
        return; 
    }
    
//    int movieId = Integer.parseInt(idParam);
//    
//    // Ambil data film dan daftar bioskop
//    MoviesDAO mDao = new MoviesDAO();
//    Movies movie = mDao.getById(movieId);
    
    ScheduleDAO sDao = new ScheduleDAO();
    List<Map<String, Object>> schedules = sDao.getAllSchedulesByMovie(movieId);
    
    CinemaDAO cDao = new CinemaDAO();
    List<Cinemas> cinemas = cDao.getAll();
    
//    if (movie == null) { response.sendRedirect("index.jsp"); return; }
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking: <%= movie.getTitle() %> — LayarKlik</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    
    <style>
        body { background-color: #020617; color: #f8fafc; font-family: 'Plus Jakarta Sans', sans-serif; }
        .glass-card { background: rgba(15, 23, 42, 0.6); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.05); }
        .hero-gradient { background: linear-gradient(to bottom, transparent, #020617); }
    </style>
</head>

<body class="antialiased">

    <section class="relative h-[60vh] w-full overflow-hidden">
        <div class="absolute inset-0 z-0">
            <div class="w-full h-full bg-slate-800 flex items-center justify-center italic font-black text-white/5 text-9xl">
                <% if (movie.getPoster() != null && !movie.getPoster().isEmpty()) { %>
                    <img src="${pageContext.request.contextPath}/images/poster/<%= movie.getPoster() %>" 
                         alt="<%= movie.getTitle() %>" 
                         class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                <% } else { %>
                    <div class="w-full h-full flex items-center justify-center bg-slate-700">
                        <i class="fas fa-image text-4xl text-slate-500"></i>
                    </div>
                <% } %>
            </div>
            <a href="index.jsp" 
                class="absolute top-8 left-8 z-20 w-10 h-10 flex items-center justify-center bg-slate-900/50 backdrop-blur-xl border border-white/10 rounded-full text-white hover:bg-blue-600 hover:border-blue-500 transition-all shadow-lg"
                title="Kembali ke Utama">
                 <i class="fas fa-home"></i>
             </a>
            <div class="absolute inset-0 hero-gradient"></div>
        </div>

        <div class="relative z-10 max-w-7xl mx-auto px-6 h-full flex flex-col justify-end pb-12">
            <a href="index.jsp" class="mb-8 flex items-center gap-2 text-gray-400 hover:text-white transition w-fit">
                <i class="fas fa-arrow-left"></i> Kembali ke Beranda
            </a>
            <div class="flex flex-col md:flex-row gap-8 items-end">
                <div class="hidden md:block w-48 aspect-[2/3] rounded-3xl overflow-hidden shadow-2xl border-2 border-white/10 shrink-0">
                    <div class="w-full h-full bg-slate-700 flex items-center justify-center">
                        <% if (movie.getPoster() != null && !movie.getPoster().isEmpty()) { %>
                            <img src="${pageContext.request.contextPath}/images/poster/<%= movie.getPoster() %>" 
                                 alt="<%= movie.getTitle() %>" 
                                 class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                        <% } else { %>
                            <div class="w-full h-full flex items-center justify-center bg-slate-700">
                                <i class="fas fa-image text-4xl text-slate-500"></i>
                            </div>
                        <% } %>
                    </div>
                </div>
                <div>
                    <span class="text-blue-500 font-bold text-xs uppercase tracking-[0.3em]"><%= movie.getGenre() %></span>
                    <h1 class="text-4xl md:text-6xl font-black italic uppercase tracking-tighter mt-2 leading-tight">
                        <%= movie.getTitle() %>
                    </h1>
                    <div class="flex items-center gap-6 mt-4 text-gray-400 font-bold text-sm uppercase">
                        <span class="flex items-center gap-2"><i class="far fa-clock text-blue-500"></i> <%= movie.getDurationMinutes() %> Menit</span>
                        <span class="flex items-center gap-2"><i class="fas fa-star text-yellow-500"></i> <%= movie.getRatingScore() %> / 5.0</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <main class="max-w-7xl mx-auto px-6 py-12">
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-12">
            
            <div class="lg:col-span-2">
                <h2 class="text-2xl font-extrabold mb-8 flex items-center gap-3">
                    <span class="w-2 h-8 bg-blue-600 rounded-full"></span> Pilih Bioskop & Jadwal
                </h2>

                <form action="seats.jsp" method="GET" id="bookingForm">
                    <input type="hidden" name="movie_id" value="<%= movieId %>">

                    <div class="space-y-4">
                        <% 
                            // Kita tetap menggunakan daftar bioskop sebagai list utama
                            for(Cinemas c : cinemas) { 
                                // Ambil jadwal khusus untuk film ini DAN bioskop ini saja
                                List<Map<String, Object>> schedulesByCinema = sDao.getSchedulesByMovieAndCinema(movieId, c.getCinemaId());
                        %>
                            <div class="glass-card rounded-[2rem] overflow-hidden transition-all duration-300 border border-white/5">
                                <div onclick="toggleSchedule('<%= c.getCinemaId() %>')" class="p-6 flex items-center justify-between cursor-pointer hover:bg-white/5 transition-colors">
                                    <div class="flex items-center gap-6">
                                        <div class="w-12 h-12 rounded-xl bg-blue-600/20 flex items-center justify-center text-blue-500 font-black italic">
                                            <%= c.getCinemaType().substring(0, 1) %>
                                        </div>
                                        <div>
                                            <p class="font-extrabold text-lg tracking-tight"><%= c.getName() %></p>
                                            <p class="text-xs text-gray-500 uppercase tracking-widest font-bold"><%= c.getCity() %></p>
                                        </div>
                                    </div>
                                    <i id="icon-<%= c.getCinemaId() %>" class="fas fa-chevron-down text-gray-600 transition-transform"></i>
                                </div>

                                <div id="schedule-<%= c.getCinemaId() %>" class="hidden p-6 pt-0 border-t border-white/5 bg-white/[0.02]">
                                    <p class="text-[10px] font-black uppercase tracking-[0.2em] text-gray-500 mb-4">Pilih Jam Tayang Tersedia:</p>

                                    <div class="grid grid-cols-2 md:grid-cols-3 gap-3">
                                        <% if(schedulesByCinema.isEmpty()) { %>
                                            <p class="col-span-full text-sm text-gray-600 italic">Tidak ada jadwal tersedia di bioskop ini.</p>
                                        <% } else { %>
                                            <% for(Map<String, Object> s : schedulesByCinema) { %>
                                                <label class="group relative cursor-pointer">
                                                    <input type="radio" name="schedule_id" value="<%= s.get("id") %>" class="hidden peer">
                                                    <div class="p-4 border border-white/10 rounded-2xl text-center transition-all peer-checked:bg-blue-600 peer-checked:border-blue-600 group-hover:border-blue-500">
                                                        <p class="text-[10px] font-bold text-gray-400 group-hover:text-blue-400 peer-checked:text-blue-100 uppercase mb-1"><%= s.get("studio_name") %></p>
                                                        <p class="text-lg font-black peer-checked:text-white"><%= s.get("time").toString().substring(0, 5) %></p>
                                                        <p class="text-[10px] font-bold text-emerald-500 mt-1 italic">Rp <%= String.format("%,.0f", (Double)s.get("price")) %></p>
                                                    </div>
                                                </label>
                                            <% } %>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                        <% } %>
                    </div>

                    <%-- Cek apakah ada total jadwal dari semua bioskop --%>
                    <%
                        boolean hasAnySchedule = false;
                        for(Cinemas checkC : cinemas) {
                            if(!sDao.getSchedulesByMovieAndCinema(movieId, checkC.getCinemaId()).isEmpty()) {
                                hasAnySchedule = true;
                                break;
                            }
                        }
                    %>

                    <button type="submit" 
                        <% if(!hasAnySchedule) { %> disabled <% } %>
                        class="w-full mt-12 py-5 <%= hasAnySchedule ? "bg-blue-600 hover:bg-blue-700" : "bg-gray-800 cursor-not-allowed" %> text-white font-black uppercase tracking-widest rounded-[2rem] shadow-xl transition-all">
                        <% if(hasAnySchedule) { %>
                            Lanjut Pilih Kursi <i class="fas fa-arrow-right ml-2"></i>
                        <% } else { %>
                            Jadwal Belum Tersedia
                        <% } %>
                    </button>
                </form>
            </div>

            <div class="hidden lg:block">
                <div class="glass-card rounded-[2.5rem] p-8 sticky top-32">
                    <h3 class="text-lg font-black italic uppercase tracking-widest mb-4">Sinopsis</h3>
                    <p class="text-gray-400 text-sm leading-relaxed mb-8">
                        <%= movie.getSynopsis() != null ? movie.getSynopsis() : "Belum ada sinopsis untuk film ini." %>
                    </p>
                    <div class="pt-6 border-t border-white/5">
                        <div class="flex items-center gap-4 opacity-50">
                            <i class="fas fa-shield-alt text-2xl"></i>
                            <p class="text-[10px] font-bold uppercase tracking-widest">Transaksi Aman & Terenkripsi</p>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </main>

    <footer class="py-12 border-t border-white/5 mt-20 text-center">
        <p class="text-gray-600 text-[10px] font-bold tracking-[0.4em] uppercase">© 2025 LayarKlik Booking System</p>
    </footer>

    <script>
        function toggleSchedule(id) {
            const content = document.getElementById('schedule-' + id);
            const icon = document.getElementById('icon-' + id);

            // Sembunyikan semua jadwal lain (Optional, agar rapi)
            // document.querySelectorAll('[id^="schedule-"]').forEach(el => {
            //    if(el.id !== 'schedule-' + id) el.classList.add('hidden');
            // });

            content.classList.toggle('hidden');
            icon.classList.toggle('rotate-180');
        }
    </script>
</body>
</html>