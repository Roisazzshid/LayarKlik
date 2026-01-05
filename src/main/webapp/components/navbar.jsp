<!-- Navbar -->
<nav id="navbar" class="w-full sticky top-0 z-50 shadow-md bg-[#0C2B4E]">
  <div class="max-w-7xl mx-auto px-4 py-4">
    <div class="flex justify-between items-center">
      <div class="flex items-center space-x-2">
        <i class="fas fa-film text-2xl text-white"></i>
        <span id="site-name" class="text-2xl text-white font-bold">LayarKlik</span>
      </div>
      <div class="hidden md:flex space-x-6 text-white">
        <a href="#home" class="hover:opacity-80 transition">Beranda</a>
        <a href="#movies" class="hover:opacity-80 transition">Film</a>
        <a href="#promo" class="hover:opacity-80 transition">Promo</a>
        <a href="#about" class="hover:opacity-80 transition">Tentang</a>
      </div>
      <div class="">
        <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 opacity-50"></i>
        <input id="search-input" type="text" placeholder="Cari film favorit Anda..."
               class="w-80 rounded-lg py-2 px-2 border-2 focus:outline-none focus:ring-2">
        <button id="search-btn" class="px-4 py-2 rounded-lg text-white font-semibold transition hover:opacity-90 whitespace-nowrap">
         <i class="fas fa-search"></i>
        </button>
        <a href="login.jsp" class="px-6 py-2 text-white rounded-lg font-semibold transition hover:opacity-90">
         <i class="fas fa-user mr-2"></i>
        </a>
      </div>
      
    </div>
  </div>
</nav>