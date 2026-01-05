<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, util.KoneksiDB, java.util.*"%>
<%
    // 1. Tangkap Data dari seats.jsp
    String movieId = request.getParameter("movie_id");
    String scheduleId = request.getParameter("schedule_id");
    String cinemaId = request.getParameter("cinema_id"); // Pastikan ini dikirim dari seats.jsp
    String[] selectedSeats = request.getParameterValues("selected_seats");
    String totalPrice = request.getParameter("total_price_input");
    
    // Ambil user_id dari session login
    model.Users userSession = (model.Users) session.getAttribute("user");
    int userId = (userSession != null) ? userSession.getId() : 1; 

    if (selectedSeats == null || scheduleId == null) {
        response.sendRedirect("seats.jsp?movie_id=" + movieId);
        return;
    }

    String seatsBooked = String.join(", ", selectedSeats);
    boolean isSuccess = false;

    // 2. Simpan ke Database
    try (Connection conn = KoneksiDB.getConnection()) {
        // Query disesuaikan dengan nama kolom: seat_numbers, movie_id, cinema_id
        String sql = "INSERT INTO bookings (user_id, schedule_id, movie_id, cinema_id, total_price, status, seat_numbers) " +
                     "VALUES (?, ?, ?, ?, ?, 'PAID', ?)";
        
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ps.setInt(2, Integer.parseInt(scheduleId));
        ps.setInt(3, Integer.parseInt(movieId));
        ps.setInt(4, Integer.parseInt(cinemaId)); // Ambil cinema_id
        ps.setDouble(5, Double.parseDouble(totalPrice));
        ps.setString(6, seatsBooked); // Nama kolom di DB adalah seat_numbers
        
        int rows = ps.executeUpdate();
        if (rows > 0) isSuccess = true;
    } catch (Exception e) {
        // Cetak error ke console NetBeans untuk debugging
        e.printStackTrace(); 
    }
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Konfirmasi Pembayaran — LayarKlik</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-[#020617] text-white flex items-center justify-center min-h-screen">

    <div class="max-w-md w-full p-8 bg-slate-900 border border-white/10 rounded-[3rem] text-center shadow-2xl">
        <% if (isSuccess) { %>
            <div class="w-20 h-20 bg-emerald-500/20 text-emerald-500 rounded-full flex items-center justify-center mx-auto mb-6 text-3xl">
                <i class="fas fa-check"></i>
            </div>
            <h1 class="text-3xl font-black italic uppercase tracking-tighter">Pembayaran Berhasil!</h1>
            <p class="text-gray-400 mt-4 text-sm">Tiket Anda telah dikonfirmasi. Silakan tunjukkan QR Code di bawah saat masuk bioskop.</p>
            
            <div class="mt-8 p-6 bg-white text-black rounded-3xl text-left relative overflow-hidden">
                <div class="absolute -right-4 top-1/2 -translate-y-1/2 w-8 h-8 bg-[#020617] rounded-full"></div>
                <div class="absolute -left-4 top-1/2 -translate-y-1/2 w-8 h-8 bg-[#020617] rounded-full"></div>
                
                <p class="text-[10px] font-bold text-gray-400 uppercase tracking-widest">Nomor Kursi</p>
                <p class="text-2xl font-black text-blue-600 mb-4"><%= seatsBooked %></p>
                
                <div class="flex justify-between border-t border-dashed border-gray-200 pt-4">
                    <div>
                        <p class="text-[8px] font-bold text-gray-400 uppercase">Total Bayar</p>
                        <p class="font-bold text-sm">
                            Rp <%= String.format("%,.0f", Double.parseDouble(totalPrice)) %>
                        </p>
                    </div>
                    <div class="text-right">
                        <i class="fas fa-qrcode text-4xl"></i>
                    </div>
                </div>
            </div>

            <a href="index.jsp" class="block mt-10 text-blue-500 font-bold hover:underline">Kembali ke Beranda</a>
        <% } else { %>
            <div class="w-20 h-20 bg-red-500/20 text-red-500 rounded-full flex items-center justify-center mx-auto mb-6 text-3xl">
                <i class="fas fa-times"></i>
            </div>
            <h1 class="text-2xl font-bold">Gagal Memproses!</h1>
            <p class="text-gray-400 mt-2">Terjadi kesalahan pada sistem database.</p>
            <a href="javascript:history.back()" class="block mt-6 text-blue-500 font-bold">Coba Lagi</a>
        <% } %>
    </div>

</body>
</html>