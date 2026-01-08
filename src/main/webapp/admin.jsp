<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.*, model.*, java.util.*"%>
<%
    // GATE KEAMANAN
    Users userAdmin = (Users) session.getAttribute("user");
    if (userAdmin == null || !"admin".equals(userAdmin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Inisialisasi DAO
    MoviesDAO mDao = new MoviesDAO();
    CinemaDAO cDao = new CinemaDAO();
    UserDAO uDao = new UserDAO();
    ScheduleDAO sDao = new ScheduleDAO();

    // AMBIL PARAMETER HALAMAN
    String currentPage = request.getParameter("page");
    if (currentPage == null) currentPage = "dashboard";

    // DATA UNTUK DASHBOARD
    int totalMovies = mDao.getTotalMovies();
    int totalUsers = uDao.getTotalUsers();
    int totalCinemas = cDao.getTotalCinemas();
    int totalSchedules = sDao.getTotalSchedules();
%>

<!doctype html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AdminKlik — <%= currentPage.substring(0, 1).toUpperCase() + currentPage.substring(1) %></title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet" />
  <style>
    body { font-family: 'Plus Jakarta Sans', sans-serif; }
  </style>
</head>

<body class="bg-slate-50 antialiased">

  <aside class="fixed top-0 left-0 z-40 w-64 h-screen transition-transform -translate-x-full sm:translate-x-0 border-r border-slate-200 bg-white">
    <div class="h-full px-4 py-8 overflow-y-auto">
      <div class="flex items-center px-2 mb-10 space-x-3">
        <div class="relative w-12 h-12 flex items-center justify-center border-blue-600/30 border-2 rounded-xl group-hover:rotate-12 transition-all duration-300 shadow-lg shadow-blue-500/40 overflow-hidden">
            <img src="${pageContext.request.contextPath}/images/logo.png" 
                 class="w-full h-full p-2 object-contain" 
                 alt="LayarKlik Logo">
        </div>
        <span class="text-xl font-bold tracking-tight text-slate-800">Admin<span class="text-blue-600">Klik</span></span>
      </div>
      
      <ul class="space-y-2 font-medium">
        <li>
          <a href="admin.jsp?page=dashboard" class="flex items-center p-3 rounded-xl transition-all duration-200 <%= currentPage.equals("dashboard") ? "bg-blue-600 text-white shadow-lg shadow-blue-200" : "text-slate-600 hover:bg-slate-50" %>">
            <i class="fas fa-th-large w-5"></i> <span class="ml-3">Dashboard</span>
          </a>
        </li>
        <li>
          <a href="admin.jsp?page=movies" class="flex items-center p-3 rounded-xl transition-all duration-200 <%= currentPage.equals("movies") ? "bg-blue-600 text-white shadow-lg shadow-blue-200" : "text-slate-600 hover:bg-slate-50" %>">
            <i class="fas fa-video w-5"></i> <span class="ml-3">Kelola Film</span>
          </a>
        </li>
        <li>
          <a href="admin.jsp?page=schedules" class="flex items-center p-3 rounded-xl transition-all duration-200 <%= currentPage.equals("schedules") ? "bg-blue-600 text-white shadow-lg shadow-blue-200" : "text-slate-600 hover:bg-slate-50" %>">
            <i class="fas fa-clock w-5"></i> <span class="ml-3">Jam Tayang</span>
          </a>
        </li>
        <li>
          <a href="admin.jsp?page=cinemas" class="flex items-center p-3 rounded-xl transition-all duration-200 <%= currentPage.equals("cinemas") ? "bg-blue-600 text-white shadow-lg shadow-blue-200" : "text-slate-600 hover:bg-slate-50" %>">
            <i class="fas fa-building w-5"></i> <span class="ml-3">Bioskop</span>
          </a>
        </li>
        <li>
          <a href="admin.jsp?page=users" class="flex items-center p-3 rounded-xl transition-all duration-200 <%= currentPage.equals("users") ? "bg-blue-600 text-white shadow-lg shadow-blue-200" : "text-slate-600 hover:bg-slate-50" %>">
            <i class="fas fa-users w-5"></i> <span class="ml-3">Pengguna</span>
          </a>
        </li>
        
        <li class="pt-4 mt-4 border-t border-slate-100">
          <a href="${pageContext.request.contextPath}/LogoutServlet" class="flex items-center p-3 text-red-500 hover:bg-red-50 rounded-xl transition group">
            <i class="fas fa-sign-out-alt w-5"></i>
            <span class="ml-3">Keluar ke Web</span>
          </a>
        </li>
      </ul>
    </div>
  </aside>

  <div class="sm:ml-64 min-h-screen">
    <div class="p-8">
      
      <%-- HEADER KONTEKSTUAL --%>
      <div class="mb-8">
          <h1 class="text-2xl font-extrabold text-slate-800 capitalize"><%= currentPage %></h1>
          <p class="text-slate-500 text-sm">Selamat datang kembali, <%= userAdmin.getNama() %>.</p>
      </div>

      <%-- ======================== TAB 1: DASHBOARD ======================== --%>
        <% if (currentPage.equals("dashboard")) { %>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">

                <div class="group p-6 bg-white border border-slate-200 rounded-3xl shadow-sm hover:shadow-xl hover:border-blue-200 transition-all duration-300">
                    <div class="flex items-center justify-between mb-4">
                        <div class="w-12 h-12 bg-blue-50 text-blue-600 rounded-2xl flex items-center justify-center group-hover:bg-blue-600 group-hover:text-white transition-colors duration-300">
                            <i class="fas fa-video text-xl"></i>
                        </div>
                        <span class="text-[10px] font-bold text-blue-500 bg-blue-50 px-2 py-1 rounded-lg uppercase">Movies</span>
                    </div>
                    <p class="text-slate-500 text-xs font-bold uppercase tracking-widest">Total Film</p>
                    <h3 class="text-3xl font-black mt-1 text-slate-800"><%= totalMovies %></h3>
                </div>

                <div class="group p-6 bg-white border border-slate-200 rounded-3xl shadow-sm hover:shadow-xl hover:border-emerald-200 transition-all duration-300">
                    <div class="flex items-center justify-between mb-4">
                        <div class="w-12 h-12 bg-emerald-50 text-emerald-600 rounded-2xl flex items-center justify-center group-hover:bg-emerald-600 group-hover:text-white transition-colors duration-300">
                            <i class="fas fa-building text-xl"></i>
                        </div>
                        <span class="text-[10px] font-bold text-emerald-500 bg-emerald-50 px-2 py-1 rounded-lg uppercase">Cinemas</span>
                    </div>
                    <p class="text-slate-500 text-xs font-bold uppercase tracking-widest">Total Bioskop</p>
                    <h3 class="text-3xl font-black mt-1 text-slate-800"><%= totalCinemas %></h3>
                </div>

                <div class="group p-6 bg-white border border-slate-200 rounded-3xl shadow-sm hover:shadow-xl hover:border-amber-200 transition-all duration-300">
                    <div class="flex items-center justify-between mb-4">
                        <div class="w-12 h-12 bg-amber-50 text-amber-600 rounded-2xl flex items-center justify-center group-hover:bg-amber-600 group-hover:text-white transition-colors duration-300">
                            <i class="fas fa-clock text-xl"></i>
                        </div>
                        <span class="text-[10px] font-bold text-amber-500 bg-amber-50 px-2 py-1 rounded-lg uppercase">Schedules</span>
                    </div>
                    <p class="text-slate-500 text-xs font-bold uppercase tracking-widest">Jam Tayang</p>
                    <h3 class="text-3xl font-black mt-1 text-slate-800"><%= totalSchedules %></h3>
                </div>

                <div class="group p-6 bg-white border border-slate-200 rounded-3xl shadow-sm hover:shadow-xl hover:border-indigo-200 transition-all duration-300">
                    <div class="flex items-center justify-between mb-4">
                        <div class="w-12 h-12 bg-indigo-50 text-indigo-600 rounded-2xl flex items-center justify-center group-hover:bg-indigo-600 group-hover:text-white transition-colors duration-300">
                            <i class="fas fa-users text-xl"></i>
                        </div>
                        <span class="text-[10px] font-bold text-indigo-500 bg-indigo-50 px-2 py-1 rounded-lg uppercase">Users</span>
                    </div>
                    <p class="text-slate-500 text-xs font-bold uppercase tracking-widest">Pengguna</p>
                    <h3 class="text-3xl font-black mt-1 text-slate-800"><%= totalUsers %></h3>
                </div>
            </div>

            <div class="p-8 bg-gradient-to-r from-slate-800 to-slate-900 rounded-3xl shadow-2xl relative overflow-hidden">
                <div class="relative z-10">
                    <h2 class="text-2xl font-bold text-white mb-2">Ringkasan Sistem</h2>
                    <p class="text-slate-400 max-w-lg text-sm leading-relaxed">
                        Halo <span class="text-blue-400 font-bold"><%= userAdmin.getNama() %></span>, saat ini terdapat 
                        <strong><%= totalSchedules %> jadwal aktif</strong> yang sedang berjalan di sistem LayarKlik. 
                        Semua sistem terpantau stabil.
                    </p>
                </div>
                <i class="fas fa-chart-line absolute -right-4 -bottom-4 text-9xl text-white/5 -rotate-12"></i>
            </div>
        <% } %>

      <%-- ======================== TAB 2: KELOLA FILM ======================== --%>
      <% if (currentPage.equals("movies")) { %>
          <div class="flex justify-end mb-6">
              <button data-modal-target="addMovieModal" data-modal-toggle="addMovieModal" class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2.5 rounded-xl font-bold shadow-lg shadow-blue-200 transition-all active:scale-95">
                  <i class="fas fa-plus mr-2"></i> Tambah Film
              </button>
          </div>
          <div class="bg-white border border-slate-200 rounded-2xl shadow-sm overflow-hidden">
              <table class="w-full text-sm text-left">
                  <thead class="bg-slate-50 text-xs uppercase font-bold text-slate-600 border-b">
                      <tr>
                          <th class="px-6 py-4">Judul Film</th>
                          <th class="px-6 py-4">Genre</th>
                          <th class="px-6 py-4">Sinopsis</th>
                          <th class="px-6 py-4">Durasi</th>
                          <th class="px-6 py-4 text-center">Rating</th>
                          <th class="px-6 py-4 text-center">Harga</th>
                          <th class="px-6 py-4 text-right">Aksi</th>
                      </tr>
                  </thead>
                  <tbody class="divide-y divide-slate-100">
                      <% for (Movies m : mDao.getAll()) { %>
                      <tr class="hover:bg-slate-50/80 transition-colors">
                          <td class="px-6 py-4 font-bold text-slate-800"><%= m.getTitle() %></td>
                          <td class="px-6 py-4 font-medium text-slate-500"><%= m.getGenre() %></td>
                          <td class="px-6 py-4 text-slate-500"><%= m.getSynopsis() %></td>
                          <td class="px-6 py-4 font-medium text-slate-500"><%= m.getDurationMinutes() %> Menit</td>
                          <td class="px-6 py-4 text-center">
                              <span class="text-yellow-500 font-bold"><i class="fas fa-star mr-1"></i><%= m.getRatingScore() %></span>
                          </td>
                          <td class="px-6 py-4 font-medium text-slate-500">Rp.<%= m.getBasePrice() %></td>
                          <td class="px-6 py-4 text-right space-x-2">
                              <button data-modal-target="editModal<%= m.getId() %>" data-modal-toggle="editModal<%= m.getId() %>" class="text-blue-600 hover:bg-blue-50 w-8 h-8 rounded-lg">
                                  <i class="fas fa-edit"></i>
                              </button>
                              <a href="MovieServlet?action=delete&id=<%= m.getId() %>" onclick="return confirm('Yakin ingin menghapus film ini?')" class="inline-flex items-center justify-center text-red-500 hover:bg-red-50 w-8 h-8 rounded-lg transition-colors">
                                  <i class="fas fa-trash"></i>
                              </a>
                          </td>
                      </tr>
                      
                      <div id="editModal<%= m.getId() %>" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
                        <div class="relative p-4 w-full max-w-2xl max-h-full">
                            <div class="relative bg-white rounded-3xl shadow-2xl p-8 border border-slate-100">
                                <%-- Header Modal --%>
                                <div class="flex items-center justify-between mb-6 border-b border-slate-50 pb-4">
                                    <h3 class="text-2xl font-bold text-slate-800">
                                        <i class="fas fa-edit text-blue-600 mr-2"></i> Edit Film
                                    </h3>
                                    <button type="button" class="text-slate-400 bg-transparent hover:bg-slate-100 hover:text-slate-900 rounded-lg text-sm w-8 h-8 inline-flex justify-center items-center" data-modal-toggle="editModal<%= m.getId() %>">
                                        <i class="fas fa-times text-lg"></i>
                                    </button>
                                </div>

                                <form action="MovieServlet" method="POST" class="space-y-5">
                                    <input type="hidden" name="action" value="edit">
                                    <input type="hidden" name="id" value="<%= m.getId() %>">

                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                        <%-- Judul Film --%>
                                        <div class="md:col-span-2">
                                            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Judul Film</label>
                                            <input type="text" name="title" value="<%= m.getTitle() %>" required 
                                                class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:bg-white outline-none transition-all">
                                        </div>

                                        <%-- Genre --%>
                                        <div>
                                            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Genre</label>
                                            <input type="text" name="genre" value="<%= m.getGenre() %>" required 
                                                class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:bg-white outline-none transition-all">
                                        </div>

                                        <%-- Durasi --%>
                                        <div>
                                            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Durasi (Menit)</label>
                                            <input type="number" name="duration" value="<%= m.getDurationMinutes() %>" required 
                                                class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:bg-white outline-none transition-all">
                                        </div>

                                        <%-- Tanggal Rilis --%>
                                        <div>
                                            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Tanggal Rilis</label>
                                            <input type="date" name="release_date" value="<%= m.getReleaseDate() %>" required 
                                                class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:bg-white outline-none transition-all">
                                        </div>

                                        <%-- Harga Dasar --%>
                                        <div>
                                            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Harga Dasar (Rp)</label>
                                            <input type="number" name="base_price" value="<%= m.getBasePrice() %>" required 
                                                class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:bg-white outline-none transition-all">
                                        </div>
                                                
                                    </div>

                                    <%-- Sinopsis --%>
                                    <div>
                                        <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Sinopsis</label>
                                        <textarea name="synopsis" rows="4" 
                                            class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:bg-white outline-none transition-all"><%= m.getSynopsis() %></textarea>
                                    </div>
                                    
                                    <%-- Poster --%>
                                    <div class="md:col-span-2">
                                        <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Nama File Poster</label>
                                        <input type="text" name="poster" required 
                                            class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none"
                                            placeholder="Contoh: poster-spiderman.jpg">
                                        <p class="text-[10px] text-gray-400 mt-1">*Pastikan file sudah ada di folder images/poster/</p>
                                    </div>

                                    <%-- Tombol Aksi --%>
                                    <div class="flex gap-4 mt-8">
                                        <button type="button" data-modal-toggle="editModal<%= m.getId() %>" 
                                            class="flex-1 py-3.5 bg-slate-100 text-slate-600 font-bold rounded-xl hover:bg-slate-200 transition-all">
                                            Batal
                                        </button>
                                        <button type="submit" 
                                            class="flex-2 px-10 py-3.5 bg-blue-600 text-white font-bold rounded-xl shadow-lg shadow-blue-200 hover:bg-blue-700 active:scale-95 transition-all">
                                            Simpan Perubahan
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                      </div>
                      <% } %>
                  </tbody>
              </table>
          </div>
      <% } %>
      <div id="addMovieModal" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
        <div class="relative p-4 w-full max-w-2xl max-h-full">
            <div class="relative bg-white rounded-3xl shadow-2xl p-8 border border-slate-100">
                <div class="flex items-center justify-between mb-6 border-b border-slate-50 pb-4">
                    <h3 class="text-2xl font-bold text-slate-800">
                        <i class="fas fa-plus-circle text-blue-600 mr-2"></i> Tambah Film Baru
                    </h3>
                    <button type="button" class="text-slate-400 bg-transparent hover:bg-slate-100 hover:text-slate-900 rounded-lg text-sm w-8 h-8 inline-flex justify-center items-center" data-modal-toggle="addMovieModal">
                        <i class="fas fa-times text-lg"></i>
                    </button>
                </div>

                <form action="MovieServlet" method="POST" class="space-y-5">
                    <input type="hidden" name="action" value="add">

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="md:col-span-2">
                            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Judul Film</label>
                            <input type="text" name="title" required 
                                class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:bg-white outline-none transition-all"
                                placeholder="Contoh: Spider-Man: No Way Home">
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Genre</label>
                            <input type="text" name="genre" required 
                                class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:bg-white outline-none transition-all"
                                placeholder="Action, Sci-Fi">
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Durasi (Menit)</label>
                            <input type="number" name="duration" required 
                                class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:bg-white outline-none transition-all"
                                placeholder="120">
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Tanggal Rilis</label>
                            <input type="date" name="release_date" required 
                                class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:bg-white outline-none transition-all">
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Harga Dasar (Rp)</label>
                            <input type="number" name="base_price" required 
                                class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:bg-white outline-none transition-all"
                                placeholder="45000">
                        </div>
                    </div>

                    <div>
                        <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Sinopsis</label>
                        <textarea name="synopsis" rows="4" 
                            class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:bg-white outline-none transition-all"
                            placeholder="Tuliskan ringkasan cerita film di sini..."></textarea>
                    </div>
                    
                    <div class="space-y-1 text-center">
                        <svg class="mx-auto h-12 w-12 text-slate-400 group-hover:text-blue-500 transition-colors" stroke="currentColor" fill="none" viewBox="0 0 48 48" aria-hidden="true">
                            <path d="M28 8H12a4 4 0 00-4 4v20m32-12v8m0 0v8a4 4 0 01-4 4H12a4 4 0 01-4-4v-4m32-4l-3.172-3.172a4 4 0 00-5.656 0L28 28M8 32l9.172-9.172a4 4 0 015.656 0L28 28m0 0l4 4m4-24h8m-4-4v8m-12 4h.02" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>

                        <div class="flex text-sm text-slate-600">
                            <label for="foto" class="relative cursor-pointer bg-transparent rounded-md font-bold text-blue-600 hover:text-blue-500 focus-within:outline-none">
                                <span>Upload file</span>
                                <input id="foto" name="poster" type="file" class="sr-only" accept="image/*" required>
                            </label>
                            <p class="pl-1">atau drag and drop</p>
                        </div>
                        <p class="text-xs text-slate-500 italic">
                            Format: PNG, JPG (Maks. 2MB)
                        </p>
                    </div>

                    <div class="flex gap-4 mt-8">
                        <button type="button" data-modal-toggle="addMovieModal" 
                            class="flex-1 py-3.5 bg-slate-100 text-slate-600 font-bold rounded-xl hover:bg-slate-200 transition-all">
                            Batal
                        </button>
                        <button type="submit" 
                            class="flex-2 px-10 py-3.5 bg-blue-600 text-white font-bold rounded-xl shadow-lg shadow-blue-200 hover:bg-blue-700 active:scale-95 transition-all">
                            Simpan Film
                        </button>
                    </div>
                </form>
            </div>
        </div>
      </div>

      <%-- ======================== TAB 3: KELOLA BIOSKOP ======================== --%>
      <% if (currentPage.equals("cinemas")) { %>
          <div class="flex justify-end mb-6">
              <button data-modal-target="addCinemaModal" data-modal-toggle="addCinemaModal" class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2.5 rounded-xl font-bold shadow-lg shadow-blue-200 transition-all active:scale-95">
                  <i class="fas fa-plus mr-2"></i> Tambah Cinema
              </button>
          </div>
          <div class="bg-white border border-slate-200 rounded-2xl shadow-sm overflow-hidden">
              <table class="w-full text-sm text-left">
                  <thead class="bg-slate-50 text-xs uppercase font-bold text-slate-600 border-b">
                      <tr>
                          <th class="px-6 py-4">Nama Bioskop</th>
                          <th class="px-6 py-4">Alamat</th>
                          <th class="px-6 py-4">Kota</th>
                          <th class="px-6 py-4 text-center">Tipe</th>
                      </tr>
                  </thead>
                  <tbody class="divide-y divide-slate-100">
                      <% for (Cinemas c : cDao.getAll()) { %>
                      <tr class="hover:bg-slate-50/80 transition-colors">
                          <td class="px-6 py-4 font-bold text-slate-800"><%= c.getName() %></td>
                          <td class="px-6 py-4 text-slate-500"><%= c.getAddress() %></td>
                          <td class="px-6 py-4 text-slate-500"><%= c.getCity() %></td>
                          <td class="px-6 py-4 text-center">
                              <span class="px-3 py-1 bg-blue-50 text-blue-600 rounded-lg text-[10px] font-black uppercase tracking-widest border border-blue-100">
                                  <%= c.getCinemaType() %>
                              </span>
                          </td>
                          <td class="px-6 py-4 text-right space-x-2">
                              <button data-modal-target="editCinemaModal<%= c.getCinemaId() %>" data-modal-toggle="editCinemaModal<%= c.getCinemaId() %>" class="text-blue-600 hover:bg-blue-50 w-8 h-8 rounded-lg">
                                  <i class="fas fa-edit"></i>
                              </button>
                              <a href="CinemaServlet?action=delete&id=<%= c.getCinemaId() %>" onclick="return confirm('Yakin ingin menghapus film ini?')" class="inline-flex items-center justify-center text-red-500 hover:bg-red-50 w-8 h-8 rounded-lg transition-colors">
                                  <i class="fas fa-trash"></i>
                              </a>
                          </td>
                      </tr>
                      
                      <div id="editCinemaModal<%= c.getCinemaId() %>" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
                        <div class="relative p-4 w-full max-w-md max-h-full">
                            <div class="relative bg-white rounded-3xl shadow-xl p-8 border border-slate-100">
                                <div class="flex items-center justify-between mb-6 border-b border-slate-50 pb-4">
                                    <h3 class="text-xl font-bold text-slate-800">
                                        <i class="fas fa-edit text-blue-600 mr-2"></i> Edit Bioskop
                                    </h3>
                                    <button type="button" class="text-slate-400 bg-transparent hover:bg-slate-100 hover:text-slate-900 rounded-lg text-sm w-8 h-8 inline-flex justify-center items-center" data-modal-toggle="editCinemaModal<%= c.getCinemaId() %>">
                                        <i class="fas fa-times text-lg"></i>
                                    </button>
                                </div>

                                <form action="CinemaServlet" method="POST" class="space-y-4">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="id" value="<%= c.getCinemaId() %>">

                                    <div>
                                        <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Nama Bioskop</label>
                                        <input type="text" name="name" value="<%= c.getName() %>" required 
                                               class="w-full px-4 py-2 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-blue-500">
                                    </div>
                                    <div>
                                        <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Alamat</label>
                                        <input type="text" name="address" value="<%= c.getAddress() %>" required 
                                               class="w-full px-4 py-2 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-blue-500">
                                    </div>
                                    <div>
                                        <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Kota</label>
                                        <input type="text" name="city" value="<%= c.getCity() %>" required 
                                               class="w-full px-4 py-2 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-blue-500">
                                    </div>
                                    <div>
                                        <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Tipe (XXI/CGV/PREMIUM)</label>
                                        <input type="text" name="type" value="<%= c.getCinemaType() %>" 
                                               class="w-full px-4 py-2 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-blue-500">
                                    </div>

                                    <div class="flex gap-3 mt-6">
                                        <button type="button" data-modal-toggle="editCinemaModal<%= c.getCinemaId() %>" 
                                                class="flex-1 py-3 bg-slate-100 text-slate-600 font-bold rounded-xl hover:bg-slate-200 transition-all">
                                            Batal
                                        </button>
                                        <button type="submit" 
                                                class="flex-1 py-3 bg-blue-600 text-white font-bold rounded-xl shadow-lg hover:bg-blue-700 transition-all">
                                            Simpan Perubahan
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                      <% } %>
                  </tbody>
              </table>
          </div>
      <% } %>
      
      <div id="addCinemaModal" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
        <div class="relative p-4 w-full max-w-md max-h-full">
            <div class="relative bg-white rounded-3xl shadow-xl p-8">
                <h3 class="text-xl font-bold text-slate-800 mb-6">Tambah Bioskop Baru</h3>
                <form action="CinemaServlet" method="POST" class="space-y-4">
                    <input type="hidden" name="action" value="add">
                    <div>
                        <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Nama Bioskop</label>
                        <input type="text" name="name" required class="w-full px-4 py-2 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div>
                        <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Alamat</label>
                        <input type="text" name="address" required class="w-full px-4 py-2 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div>
                        <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Kota</label>
                        <input type="text" name="city" required class="w-full px-4 py-2 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div>
                        <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Tipe (XXI/CGV/etc)</label>
                        <input type="text" name="type" class="w-full px-4 py-2 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <button type="submit" class="w-full py-3 bg-blue-600 text-white font-bold rounded-xl shadow-lg hover:bg-blue-700 transition-all mt-4">Simpan Bioskop</button>
                </form>
            </div>
        </div>
      </div>

      <%-- ======================== TAB 4: KELOLA PENGGUNA ======================== --%>
      <% if (currentPage.equals("users")) { %>
          <div class="flex justify-end mb-6">
              <button data-modal-target="addUserModal" data-modal-toggle="addUserModal" class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2.5 rounded-xl font-bold shadow-lg shadow-blue-200 transition-all active:scale-95">
                  <i class="fas fa-plus mr-2"></i> Tambah User
              </button>
          </div>
          <div class="bg-white border border-slate-200 rounded-2xl shadow-sm overflow-hidden">
              <table class="w-full text-sm text-left">
                  <thead class="bg-slate-50 text-xs uppercase font-bold text-slate-600 border-b">
                      <tr>
                          <th class="px-6 py-4">Nama Lengkap</th>
                          <th class="px-6 py-4">Username</th>
                          <th class="px-6 py-4">Email</th>
                          <th class="px-6 py-4">Password</th>
                          <th class="px-6 py-4 text-center">Role</th>
                      </tr>
                  </thead>
                  <tbody class="divide-y divide-slate-100">
                      <% for (Users u : uDao.getAll()) { %>
                      <tr class="hover:bg-slate-50/80 transition-colors">
                          <td class="px-6 py-4 font-bold text-slate-800"><%= u.getNama() %></td>
                          <td class="px-6 py-4 text-sm font-medium text-slate-900"><%= u.getUsername() %></td>
                          <td class="px-6 py-4 text-sm font-medium text-slate-900"><%= u.getEmail() %></td>
                          <td class="px-6 py-4 text-sm font-medium text-slate-900"><%= u.getPassword() %></td>
                          <td class="px-6 py-4 text-center">
                              <span class="px-2.5 py-1 rounded-md text-[10px] font-black uppercase tracking-wider <%= u.getRole().equals("admin") ? "bg-amber-100 text-amber-700 border border-amber-200" : "bg-slate-100 text-slate-600 border border-slate-200" %>">
                                  <%= u.getRole() %>
                              </span>
                          </td>
                      </tr>
                      <% } %>
                  </tbody>
              </table>
          </div>
      <% } %>
      <div id="addUserModal" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
        <div class="relative p-4 w-full max-w-md max-h-full">
            <div class="relative bg-white rounded-3xl shadow-xl p-8">
                <h3 class="text-xl font-bold text-slate-800 mb-6">Tambah User Baru</h3>
                <form action="RegisterProcessServlet" method="POST" class="space-y-4">
                    <div>
                        <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Nama Lengkap</label>
                        <input type="text" name="nama" required class="w-full px-4 py-2 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Username</label>
                            <input type="text" name="username" required class="w-full px-4 py-2 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Role</label>
                            <select name="role" class="w-full px-4 py-2 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="user">User</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                    </div>
                    <div>
                        <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Email</label>
                        <input type="email" name="email" required class="w-full px-4 py-2 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div>
                        <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Password</label>
                        <input type="password" name="password" required class="w-full px-4 py-2 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <button type="submit" class="w-full py-3 bg-indigo-600 text-white font-bold rounded-xl shadow-lg hover:bg-indigo-700 transition-all mt-4">Daftarkan Pengguna</button>
                </form>
            </div>
        </div>
      </div>
      
      <%-- ======================== TAB 5: JAM TAYANG ======================== --%>
        <% if (currentPage.equals("schedules")) { %>
            <div class="flex justify-between items-center mb-8">
                <h1 class="text-2xl font-bold text-slate-800">Atur Jadwal Tayang</h1>
                <button data-modal-target="addScheduleModal" data-modal-toggle="addScheduleModal" class="bg-blue-600 text-white px-5 py-2.5 rounded-xl font-bold shadow-lg shadow-blue-200 hover:bg-blue-700 transition-all">
                    + Tambah Jadwal
                </button>
            </div>

            <div class="bg-white border border-slate-200 rounded-2xl shadow-sm overflow-hidden">
                <table class="w-full text-sm text-left">
                    <thead class="bg-slate-50 text-xs uppercase font-bold text-slate-600 border-b">
                        <tr>
                            <th class="px-6 py-4">Film</th>
                            <th class="px-6 py-4">Bioskop</th>
                            <th class="px-6 py-4">Tanggal & Jam</th>
                            <th class="px-6 py-4 text-right">Aksi</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100">
                        <% 
                            for (Map<String, Object> s : sDao.getAllSchedules()) {
                        %>
                        <tr class="hover:bg-slate-50 transition-colors">
                            <td class="px-6 py-4 font-bold text-slate-800"><%= s.get("movie_title") %></td>
                            <td class="px-6 py-4 text-slate-500"><%= s.get("cinema_name") %></td>
                            <td class="px-6 py-4">
                                <span class="font-medium"><%= s.get("date") %></span>
                                <span class="ml-2 text-blue-600 font-bold"><%= s.get("time") %></span>
                            </td>
                            <td class="px-6 py-4 text-right">
                                <a href="ScheduleServlet?action=delete&id=<%= s.get("id") %>" class="text-red-500"><i class="fas fa-trash"></i></a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
        <div id="addScheduleModal" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
            <div class="relative p-4 w-full max-w-md max-h-full">
                <div class="relative bg-white rounded-3xl shadow-2xl p-8">
                    <h3 class="text-xl font-bold text-slate-800 mb-6">Tambah Jam Tayang</h3>
                    <form action="ScheduleServlet" method="POST" class="space-y-4">
                        <input type="hidden" name="action" value="add">

                        <div>
                            <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Pilih Film</label>
                            <select name="movie_id" class="w-full px-4 py-2 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-blue-500">
                                <% for (Movies m : mDao.getAll()) { %>
                                    <option value="<%= m.getId() %>"><%= m.getTitle() %></option>
                                <% } %>
                            </select>
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Pilih Bioskop</label>
                            <select name="studio_id" class="w-full px-4 py-2 border border-slate-200 rounded-xl outline-none focus:ring-2 focus:ring-blue-500">
                                <% for (Cinemas c : cDao.getAll()) { %>
                                    <option value="<%= c.getCinemaId() %>"><%= c.getName() %> (<%= c.getCity() %>)</option>
                                <% } %>
                            </select>
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Tanggal</label>
                                <input type="date" name="show_date" required class="w-full px-4 py-2 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Jam Tayang</label>
                                <input type="time" name="show_time" required class="w-full px-4 py-2 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500">
                            </div>
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-500 uppercase mb-1">Harga Tiket (Rp)</label>
                            <input type="number" name="price" required placeholder="Contoh: 50000" class="w-full px-4 py-2 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500">
                        </div>

                        <button type="submit" class="w-full py-3.5 bg-blue-600 text-white font-bold rounded-xl shadow-lg mt-4 hover:bg-blue-700 transition-all">Simpan Jadwal</button>
                    </form>
                </div>
            </div>
        </div>

    </div>
  </div>

  <%-- MODAL TAMBAH FILM TETAP SAMA --%>
  <div id="addMovieModal" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
      <%-- ... konten modal ... --%>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
</body>
</html>