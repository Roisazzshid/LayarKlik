<%-- 
    Document   : detailMovie
    Created on : Jan 1, 2026, 6:16:45 PM
    Author     : USER
--%>

<%@page import="dao.*, model.*, java.util.*"%>
<%
    String idParam = request.getParameter("id");
    if (idParam == null) { response.sendRedirect("index.jsp"); return; }
    
    int movieId = Integer.parseInt(idParam);
    Movies movie = new MoviesDAO().getById(movieId);
    List<Cinemas> cinemas = new CinemaDAO().getAll();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= movie.getTitle() %> - Detail</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body class="bg-[#020617] text-white font-sans">
        <div class="max-w-5xl mx-auto px-6 py-12">
            <a href="index.jsp" class="text-blue-500 mb-8 inline-block hover:underline"><i class="fas fa-arrow-left mr-2"></i> Kembali</a>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-12">
                <div class="aspect-[2/3] bg-slate-800 rounded-[2rem] shadow-2xl flex items-center justify-center">
                    <i class="fas fa-film text-6xl opacity-20"></i>
                </div>

                <div class="md:col-span-2">
                    <h1 class="text-5xl font-black italic tracking-tighter uppercase"><%= movie.getTitle() %></h1>
                    <div class="flex gap-4 mt-4 text-sm font-bold text-blue-500 uppercase tracking-widest">
                        <span><%= movie.getGenre() %></span>
                        <span>•</span>
                        <span><%= movie.getDurationMinutes() %> Menit</span>
                    </div>
                    <p class="mt-8 text-gray-400 leading-relaxed text-lg"><%= movie.getSynopsis() %></p>

                    <form action="select_seat.jsp" method="GET" class="mt-12">
                        <input type="hidden" name="movie_id" value="<%= movieId %>">
                        <h3 class="text-xl font-bold mb-6 flex items-center gap-3">
                            <span class="w-1.5 h-6 bg-blue-600 rounded-full"></span> Pilih Lokasi Bioskop
                        </h3>

                        <div class="grid grid-cols-1 gap-4">
                            <% for(Cinemas c : cinemas) { %>
                            <label class="group relative p-6 rounded-2xl border border-white/5 bg-white/5 hover:bg-blue-600/10 hover:border-blue-500 transition-all cursor-pointer block">
                                <input type="radio" name="cinema_id" value="<%= c.getCinemaId() %>" required class="absolute right-6 top-1/2 -translate-y-1/2 w-5 h-5 accent-blue-600">
                                <div class="pr-12">
                                    <span class="text-[10px] font-black text-blue-500 uppercase tracking-widest"><%= c.getCinemaType() %></span>
                                    <h4 class="text-lg font-bold mt-1"><%= c.getName() %></h4>
                                    <p class="text-xs text-gray-500"><%= c.getCity() %></p>
                                </div>
                            </label>
                            <% } %>
                        </div>

                        <button type="submit" class="w-full mt-10 py-5 bg-blue-600 hover:bg-blue-700 text-white font-black uppercase tracking-widest rounded-2xl shadow-xl shadow-blue-600/20 transition-all">
                            Lanjut Pilih Kursi
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
