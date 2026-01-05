<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.BookingDAO, model.Users, java.util.*"%>
<%
    Users user = (Users) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Map<String, Object>> myOrders = new BookingDAO().getByUserId(user.getId());
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Pesanan Saya — LayarKlik</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #020617; color: white; font-family: 'Plus Jakarta Sans', sans-serif; }
        .glass-card { background: rgba(15, 23, 42, 0.6); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.05); }
    </style>
</head>
<body class="p-8">
    <%
        String msg = request.getParameter("msg");
        if("deleted".equals(msg)) {
    %>
        <div class="mb-6 p-4 bg-red-500/20 border border-red-500/50 text-red-500 text-xs font-bold rounded-2xl text-center">
            Pesanan berhasil dihapus/dibatalkan.
        </div>
    <% } %>
    <div class="max-w-5xl mx-auto">
        <div class="flex justify-between items-center mb-12">
            <h1 class="text-3xl font-black uppercase italic tracking-tighter">Riwayat <span class="text-blue-500">Tiket</span></h1>
            <a href="index.jsp" class="text-xs font-bold text-gray-500 hover:text-white transition">KEMBALI KE BERANDA</a>
        </div>

        <% if (myOrders.isEmpty()) { %>
            <div class="glass-card rounded-[2rem] p-20 text-center">
                <i class="fas fa-ticket-alt text-6xl text-gray-700 mb-6 block"></i>
                <p class="text-gray-500 font-bold">Belum ada tiket yang dipesan.</p>
                <a href="index.jsp" class="mt-6 inline-block text-blue-500 font-bold hover:underline">Cari Film Sekarang</a>
            </div>
        <% } else { %>
            <div class="grid gap-6">
                <% for (Map<String, Object> order : myOrders) { %>
                    <div class="glass-card rounded-3xl p-8 flex flex-col md:flex-row justify-between items-center gap-6 border-l-4 border-l-blue-600">
                        <div class="flex-1">
                            <span class="text-[10px] font-black text-blue-500 uppercase tracking-widest">
                                <%= order.get("cinema_name") %> — <%= order.get("studio_name") %>
                            </span>
                            <h3 class="text-xl font-black mt-1 uppercase italic"><%= order.get("movie_title") %></h3>

                            <%-- INFO JADWAL TAYANG --%>
                            <div class="flex gap-4 mt-3">
                                <div class="text-xs text-gray-400">
                                    <i class="far fa-calendar-alt text-blue-500 mr-2"></i>
                                    <%= (order.get("show_date") != null) ? order.get("show_date") : "Tanggal tidak tersedia" %>
                                </div>
                                <div class="text-xs text-gray-400">
                                    <i class="far fa-clock text-blue-500 mr-2"></i>
                                    <% 
                                        Object timeObj = order.get("show_time");
                                        if (timeObj != null) {
                                            out.print(timeObj.toString().substring(0, 5));
                                        } else {
                                            out.print("--:--");
                                        }
                                    %>
                                </div>
                            </div>

                            <p class="text-xs text-gray-500 mt-4"><i class="fas fa-couch mr-2"></i> Kursi: <span class="text-white font-bold"><%= order.get("seat_numbers") %></span></p>
                        </div>

                        <div class="text-center px-8 border-x border-white/5">
                            <p class="text-[10px] text-gray-500 uppercase font-black mb-1">Total Bayar</p>
                            <p class="font-bold text-blue-400 text-lg">Rp <%= String.format("%,.0f", (Double)order.get("total_price")) %></p>
                        </div>

                        <div class="text-right">
                            <span class="px-4 py-2 bg-emerald-500/10 text-emerald-500 rounded-xl text-[10px] font-black uppercase tracking-widest border border-emerald-500/20">
                                <%= order.get("status") %>
                            </span>
                            <div class="mt-4 flex justify-end gap-3">
                                <%-- TOMBOL CETAK/QR (Opsional) --%>
                                <button class="w-10 h-10 flex items-center justify-center bg-blue-500/10 text-blue-500 rounded-xl border border-blue-500/20">
                                    <i class="fas fa-qrcode"></i>
                                </button>
                                <a href="DeleteBookingServlet?id=<%= order.get("booking_id") %>" 
                                   onclick="return confirm('Apakah Anda yakin ingin membatalkan pesanan ini?')"
                                   class="w-10 h-10 flex items-center justify-center bg-red-500/10 text-red-500 hover:bg-red-500 hover:text-white rounded-xl transition-all border border-red-500/20">
                                    <i class="fas fa-trash-alt text-xs"></i>
                                </a>
                            </div>
                            <p class="text-[8px] text-gray-600 mt-4 uppercase tracking-tighter">Dipesan pada: <%= order.get("created_at") %></p>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>
</body>
</html>