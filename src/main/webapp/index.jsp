<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.MoviesDAO"%>
<%@page import="dao.CinemaDAO"%>
<%@page import="model.Movies"%>
<%@page import="model.Cinemas"%>
<%@page import="model.Users"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*, util.KoneksiDB"%>

<%
    String searchKeyword = request.getParameter("search");
    MoviesDAO mDao = new MoviesDAO();
    List<Movies> listFilm;

    if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
        listFilm = mDao.searchMovies(searchKeyword);
    } else {
        listFilm = mDao.getAll();
    }
%>

<!doctype html>
<html lang="id" class="scroll-smooth">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>LayarKlik — Cinema Experience</title>

  <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css" rel="stylesheet" />

  <script>
    tailwind.config = {
      theme: {
        extend: {
          fontFamily: { sans: ['Plus Jakarta Sans', 'sans-serif'] },
          colors: { brand: { dark: '#020617', card: '#0f172a', blue: '#2563eb' } }
        }
      }
    }
  </script>

  <style>
    body { background-color: #020617; color: #f8fafc; overflow-x: hidden; }
    .no-scrollbar::-webkit-scrollbar { display: none; }
    .bg-glow {
      position: fixed; top: 0; left: 0; width: 100%; height: 100%;
      background: radial-gradient(circle at 15% 15%, rgba(37, 99, 235, 0.15) 0%, transparent 50%),
                  radial-gradient(circle at 85% 85%, rgba(79, 70, 229, 0.15) 0%, transparent 50%);
      z-index: -1;
    }
    .glass-nav { background: rgba(2, 6, 23, 0.8); backdrop-filter: blur(12px); border-bottom: 1px solid rgba(255, 255, 255, 0.05); }
  </style>
</head>

<body class="antialiased">
  <div class="bg-glow"></div>

  <div id="app" class="relative w-full">
    
    <header class="sticky top-0 z-[60] glass-nav">
        <%@include file="/components/navbar.jsp" %>
    </header>

    <main>
      <section id="hero" class="relative group">
        <div id="slider" class="flex overflow-x-auto snap-x snap-mandatory no-scrollbar scroll-smooth">
          <div class="flex-none w-full snap-center relative aspect-[21/9] min-h-[450px]">
            <img src="images/1.jpg" class="w-full h-full object-cover" alt="Banner 1">
            <div class="absolute inset-0 bg-gradient-to-t from-[#020617] via-[#020617]/20 to-transparent"></div>
          </div>
          <div class="flex-none w-full snap-center relative aspect-[21/9] min-h-[450px]">
            <img src="images/3.jpg" class="w-full h-full object-cover" alt="Banner 2">
            <div class="absolute inset-0 bg-gradient-to-t from-[#020617] via-transparent to-transparent"></div>
          </div>
        </div>
        
        <button onclick="prevSlide()" class="absolute left-8 top-1/2 -translate-y-1/2 bg-white/10 hover:bg-blue-600 backdrop-blur-xl text-white w-14 h-14 rounded-full flex items-center justify-center opacity-0 group-hover:opacity-100 transition-all z-30 border border-white/20">
          <i class="fas fa-chevron-left"></i>
        </button>
        <button onclick="nextSlide()" class="absolute right-8 top-1/2 -translate-y-1/2 bg-white/10 hover:bg-blue-600 backdrop-blur-xl text-white w-14 h-14 rounded-full flex items-center justify-center opacity-0 group-hover:opacity-100 transition-all z-30 border border-white/20">
          <i class="fas fa-chevron-right"></i>
        </button>
      </section>
        
      <section id="promo" class="max-w-7xl mx-auto px-6 py-12">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="relative overflow-hidden rounded-3xl h-48 group cursor-pointer shadow-2xl shadow-blue-500/10">
                <img src="images/3.jpg" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" alt="Promo 1">
                <div class="absolute inset-0 bg-gradient-to-r from-blue-900/80 to-transparent flex flex-col justify-center px-8">
                    <span class="bg-yellow-400 text-black text-[10px] font-black px-2 py-1 rounded w-fit mb-2">HOT PROMO</span>
                    <h3 class="text-xl font-bold">Diskon 50% Tiket Pertama</h3>
                    <p class="text-xs text-gray-300 mt-1 italic">Gunakan kode: LAYARBARU</p>
                </div>
            </div>
            <div class="relative overflow-hidden rounded-3xl h-48 group cursor-pointer shadow-2xl shadow-purple-500/10">
                <div class="absolute inset-0 bg-gradient-to-br from-indigo-600 to-purple-800"></div>
                <div class="absolute inset-0 flex flex-col justify-center px-8">
                    <h3 class="text-2xl font-black italic">BELI 1 GRATIS 1</h3>
                    <p class="text-sm text-white/80 mt-1">Khusus film Horror hari ini!</p>
                    <button class="mt-4 px-4 py-2 bg-white text-indigo-900 font-bold text-xs rounded-xl w-fit">Cek Sekarang</button>
                </div>
                <i class="fas fa-ticket-alt absolute -right-4 -bottom-4 text-9xl text-white/10 -rotate-12"></i>
            </div>
        </div>
      </section>

      <section id="movies" class="max-w-7xl mx-auto px-6 py-12">
        <% if (searchKeyword != null && !searchKeyword.trim().isEmpty()) { %>
            <div class="mb-10 p-6 bg-blue-600/10 border border-blue-500/20 rounded-3xl">
                <h2 class="text-xl font-bold">
                    <i class="fas fa-search mr-2 text-blue-500"></i>
                    Hasil pencarian untuk: <span class="text-blue-500">"<%= searchKeyword %>"</span>
                </h2>
                <a href="index.jsp" class="text-medium text-red-400 hover:text-white mt-2 inline-block">
                    <i class="fas fa-times mr-1"></i> Hapus Pencarian / Tampilkan Semua
                </a>
            </div>
        <% } %>

        <h2 class="text-3xl font-extrabold mb-10 flex items-center gap-3">
            <span class="w-2 h-8 bg-blue-600 rounded-full"></span> 
            <%= (searchKeyword != null) ? "Hasil Pencarian" : "Sedang Tayang" %>
        </h2>

        <div class="flex overflow-x-auto snap-x snap-mandatory no-scrollbar scroll-smooth gap-8">
            <% if (listFilm.isEmpty()) { %>
                <div class="w-full py-20 text-center glass-card rounded-[3rem]">
                    <i class="fas fa-film text-5xl text-gray-700 mb-4 block"></i>
                    <p class="text-gray-500 italic">Film "<%= searchKeyword %>" tidak ditemukan.</p>
                    <a href="index.jsp" class="text-blue-500 font-bold mt-4 inline-block">Lihat Semua Film</a>
                </div>
            <% } else { 
                for (Movies m : listFilm) { %>
                    <div class="flex-none w-52 snap-start group/card cursor-pointer">
                        </div>
                <% } 
            } %>
        </div>
        <div class="flex overflow-x-auto snap-x snap-mandatory no-scrollbar scroll-smooth gap-8">
          <% 
            for (Movies m : listFilm) { 
          %>
          <div class="flex-none w-52 snap-start group/card cursor-pointer">
            <div class="relative aspect-[2/3] rounded-[2rem] overflow-hidden shadow-2xl glass-card transition-all duration-500 group-hover/card:-translate-y-4 group-hover/card:shadow-blue-500/30">
              <div class="w-full h-full bg-slate-800 flex items-center justify-center text-slate-600">
                <% if (m.getPoster() != null && !m.getPoster().isEmpty()) { %>
                    <img src="${pageContext.request.contextPath}/images/poster/<%= m.getPoster() %>" 
                         alt="<%= m.getTitle() %>" 
                         class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                <% } else { %>
                    <div class="w-full h-full flex items-center justify-center bg-slate-700">
                        <i class="fas fa-image text-4xl text-slate-500"></i>
                    </div>
                <% } %>
              </div>
              <div class="absolute inset-0 bg-gradient-to-t from-blue-900/90 via-transparent to-transparent opacity-0 group-hover/card:opacity-100 transition-all flex flex-col justify-end p-5">
                <a href="booking.jsp?movie_id=<%= m.getId() %>" 
                    class="bg-white text-blue-900 text-xs font-black py-3 rounded-2xl text-center">
                    BOOK NOW
                 </a>
              </div>
            </div>
            <h4 class="mt-5 font-bold text-sm text-gray-100 group-hover/card:text-blue-400 transition-colors line-clamp-1 italic lowercase"><%= m.getTitle() %></h4>
          </div>
          <% } %>
        </div>
      </section>
        
      <section id="partners" class="py-24 bg-brand-card/30 border-y border-white/5 my-20 relative overflow-hidden">
        <div class="max-w-7xl mx-auto px-6 text-center">
          <span class="text-blue-500 font-black text-xs uppercase tracking-[0.3em] mb-4 block">Official Network</span>
          <h3 class="text-4xl font-black mb-16 tracking-tighter">Jaringan Bioskop Terluas</h3>

          <div class="flex flex-wrap justify-center gap-12 md:gap-24 items-center mb-20">
             <div class="group cursor-default transition-all duration-500 hover:scale-110">
                <span class="text-5xl font-black italic text-white/20 group-hover:text-white transition-colors">XXI</span>
             </div>
             <div class="group cursor-default transition-all duration-500 hover:scale-110">
                <span class="text-5xl font-black text-white/20 group-hover:text-white transition-colors">CGV</span>
             </div>
             <div class="group cursor-default transition-all duration-500 hover:scale-110">
                <span class="text-5xl font-black text-white/20 group-hover:text-white tracking-tighter transition-colors">Cinépolis</span>
             </div>
          </div>

          <div class="flex justify-center">
            <button data-modal-target="cinema-modal" data-modal-toggle="cinema-modal" 
                    class="group relative px-10 py-4 bg-blue-600 rounded-2xl overflow-hidden shadow-2xl shadow-blue-600/30 transition-all hover:scale-105 active:scale-95">
                <div class="absolute inset-0 bg-gradient-to-r from-white/0 via-white/20 to-white/0 -translate-x-full group-hover:animate-[shimmer_1.5s_infinite]"></div>
                <span class="relative flex items-center font-black text-white text-sm uppercase tracking-widest">
                  <i class="fas fa-map-marker-alt mr-3 text-blue-200"></i>
                  Lihat Semua Lokasi
                </span>
            </button>
          </div>
        </div>
      </section>

      <div id="cinema-modal" tabindex="-1" aria-hidden="true" class="hidden fixed top-0 left-0 right-0 z-[100] w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full">
          <div class="relative w-full max-w-4xl max-h-full">
              <div class="relative bg-slate-900/90 border border-white/10 rounded-[2.5rem] shadow-2xl backdrop-blur-2xl overflow-hidden">

                  <div class="relative p-8 border-b border-white/5 bg-white/5">
                      <div class="flex items-center justify-between">
                          <div>
                              <h3 class="text-2xl font-black text-white flex items-center gap-3">
                                  <span class="bg-blue-600 w-2 h-8 rounded-full"></span>
                                  Cinema <span class="text-blue-500">Network</span>
                              </h3>
                              <p class="text-gray-400 text-xs mt-2 font-medium tracking-wide">Menampilkan seluruh mitra bioskop yang terintegrasi dengan sistem kami.</p>
                          </div>
                          <button type="button" class="group bg-white/5 hover:bg-red-500/20 text-gray-400 hover:text-red-500 rounded-2xl text-sm w-12 h-12 flex justify-center items-center transition-all" data-modal-hide="cinema-modal">
                              <i class="fas fa-times text-xl"></i>
                          </button>
                      </div>
                  </div>

                  <div class="p-8">
                      <div class="overflow-hidden rounded-3xl border border-white/10 bg-black/20">
                          <table class="w-full text-left text-sm">
                              <thead class="bg-white/5 text-[10px] font-black uppercase tracking-[0.2em] text-blue-400">
                                  <tr>
                                      <th class="px-8 py-5">Nama Bioskop</th>
                                      <th class="px-8 py-5">Lokasi Kota</th>
                                      <th class="px-8 py-5 text-center">Tipe</th>
                                  </tr>
                              </thead>
                              <tbody class="divide-y divide-white/5">
                                    <%
                                        try {
                                            CinemaDAO cinDao = new CinemaDAO();
                                            List<Cinemas> daftarCinema = cinDao.getAll();

                                            if (daftarCinema == null || daftarCinema.isEmpty()) {
                                    %>
                                                <tr><td colspan="3" class="p-10 text-center text-gray-500">Data Kosong (DAO mengembalikan list kosong)</td></tr>
                                    <%
                                            } else {
                                                for (Cinemas cin : daftarCinema) {
                                                    // Pastikan tidak null saat diambil
                                                    String type = (cin.getCinemaType() != null) ? cin.getCinemaType() : "N/A";

                                                    String badgeColor = "bg-blue-600/10 text-blue-400";
                                                    if("XXI".equalsIgnoreCase(type)) badgeColor = "bg-amber-600/10 text-amber-500";
                                                    else if("CGV".equalsIgnoreCase(type)) badgeColor = "bg-red-600/10 text-red-500";
                                    %>
                                                    <tr class="hover:bg-white/5 transition-colors text-white border-b border-white/5">
                                                        <td class="px-8 py-5 font-bold"><%= cin.getName() %></td>
                                                        <td class="px-8 py-5">
                                                            <div class="flex flex-col">
                                                                <span class="text-xs font-semibold text-blue-400"><%= cin.getCity() %></span>
                                                                <span class="text-[10px] text-gray-500"><%= (cin.getAddress() != null) ? cin.getAddress() : "-" %></span>
                                                            </div>
                                                        </td>
                                                        <td class="px-8 py-5 text-right">
                                                            <span class="px-3 py-1.5 <%= badgeColor %> rounded-lg font-black text-[9px] uppercase tracking-widest border border-white/5">
                                                                <%= type %>
                                                            </span>
                                                        </td>
                                                    </tr>
                                    <% 
                                                }
                                            }
                                        } catch (Exception e) {
                                    %>
                                            <tr><td colspan="3" class="p-10 text-center text-red-500 font-bold">Error JSP: <%= e.getMessage() %></td></tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                          </table>
                      </div>
                  </div>
              </div>
          </div>
      </div>

      <style>
        @keyframes shimmer {
          0% { transform: translateX(-100%); }
          100% { transform: translateX(100%); }
        }
      </style>
        
      <section id="app-promo" class="max-w-7xl mx-auto px-6 py-20">
        <div class="glass-card rounded-[3rem] p-12 flex flex-col md:flex-row items-center gap-12 overflow-hidden relative">
            <div class="md:w-1/2 relative z-10">
                <span class="text-blue-500 font-black text-xs uppercase tracking-widest">Mobile Experience</span>
                <h2 class="text-4xl md:text-5xl font-black mt-4 leading-tight">Pesan Tiket Lebih Cepat Lewat Aplikasi</h2>
                <p class="text-gray-400 mt-6 text-lg">Dapatkan notifikasi film terbaru dan promo eksklusif hanya dalam genggaman tangan Anda.</p>
                <div class="flex gap-4 mt-10">
                    <button class="bg-white text-black px-6 py-3 rounded-2xl font-bold flex items-center gap-3 hover:bg-blue-500 hover:text-white transition-all shadow-xl shadow-white/5">
                        <i class="fab fa-apple text-2xl"></i> App Store
                    </button>
                    <button class="bg-white text-black px-6 py-3 rounded-2xl font-bold flex items-center gap-3 hover:bg-blue-500 hover:text-white transition-all shadow-xl shadow-white/5">
                        <i class="fab fa-google-play text-2xl"></i> Google Play
                    </button>
                </div>
            </div>
            <div class="md:w-1/2 relative">
                <div class="w-64 h-[500px] bg-slate-800 rounded-[3rem] border-8 border-slate-700 shadow-2xl relative overflow-hidden rotate-12 group-hover:rotate-0 transition-transform duration-1000">
                    <div class="absolute inset-0 bg-[#121921] flex items-center justify-center italic font-black text-white/20 text-3xl">
                        <img src="images/app-layarklik.png" alt="alt"/>
                    </div>
                </div>
                <div class="absolute -top-10 -right-10 w-64 h-64 bg-blue-600/20 rounded-full blur-3xl"></div>
            </div>
        </div>
      </section>
    </main>

    <footer class="relative bg-brand-dark pt-20 pb-10 border-t border-white/5 overflow-hidden">
        <%@include file="/components/footer.jsp" %>
    </footer>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
  <script>
    const slider = document.getElementById('slider');
    function nextSlide() { 
        if(slider.scrollLeft + slider.offsetWidth >= slider.scrollWidth) slider.scrollLeft = 0;
        else slider.scrollLeft += slider.offsetWidth; 
    }
    function prevSlide() { slider.scrollLeft -= slider.offsetWidth; }
    setInterval(nextSlide, 6000);
  </script>
</body>
</html>