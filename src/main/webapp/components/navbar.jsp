<%@page import="model.Users"%>
<nav class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
<div class="flex items-center space-x-3 group cursor-pointer">
  <div class="relative w-12 h-12 flex items-center justify-center border-blue-600/30 border-2 rounded-xl group-hover:rotate-12 transition-all duration-300 shadow-lg shadow-blue-500/40 overflow-hidden">
        <img src="images/logo.png" 
             class="w-full h-full p-2 object-contain" 
             alt="LayarKlik Logo">
    </div>
  <span class="text-2xl font-black tracking-tighter uppercase italic">Layar<span class="text-blue-500">Klik</span></span>
</div>

<div class="hidden lg:flex items-center space-x-10 font-bold text-xs uppercase tracking-widest text-gray-400">
  <a href="${pageContext.request.contextPath}/index.jsp#hero" class="hover:text-blue-500 transition">Beranda</a>
  <a href="${pageContext.request.contextPath}/index.jsp#movies" class="hover:text-blue-500 transition">Film</a>
  <a href="${pageContext.request.contextPath}/index.jsp#app-promo" class="hover:text-blue-500 transition">Aplikasi</a>
  <a href="${pageContext.request.contextPath}/aboutUs.jsp" class="hover:text-blue-500 transition">About Us</a>
</div>

<div class="flex items-center space-x-4">
  <form action="index.jsp" method="GET" class="relative hidden md:block">
    <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 text-xs"></i>
    <input type="text" 
           name="search" 
           placeholder="Cari film..." 
           value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"
           class="bg-white/5 border border-white/10 rounded-full py-2 pl-10 pr-4 text-xs w-64 focus:ring-1 focus:ring-blue-500 transition-all outline-none">
  </form>
  <div class="flex items-center gap-6">
    <% 
        // Mengambil objek user dari session
        Users loggedUser = (Users) session.getAttribute("user");

        if (loggedUser == null) { 
    %>
        <a href="login.jsp" class="px-6 py-2.5 bg-blue-600 hover:bg-blue-700 text-white rounded-full text-xs font-black tracking-widest transition-all shadow-lg shadow-blue-600/20 active:scale-95">
            <i class="fas fa-user-circle mr-2 text-sm"></i> LOGIN
        </a>
    <% } else { %>
        <div class="flex items-center gap-5">
            <a href="myBookings.jsp" class="relative group p-2 bg-white/5 rounded-xl border border-white/10 hover:border-blue-500/50 transition-all">
                <i class="fas fa-shopping-basket text-gray-400 group-hover:text-blue-500 transition-colors"></i>
                <span class="absolute -top-1 -right-1 w-4 h-4 bg-blue-600 text-[8px] font-black flex items-center justify-center rounded-full border-2 border-[#020617]">
                    !
                </span>
            </a>

            <div class="flex items-center gap-3 pl-2 border-l border-white/10">
                <div class="text-right hidden md:block">
                    <p class="text-[10px] font-black text-blue-500 uppercase tracking-widest leading-none">Selamat Datang</p>
                    <p class="text-sm font-bold text-white tracking-tight"><%= loggedUser.getNama() %></p>
                </div>
                <div class="w-10 h-10 rounded-2xl bg-gradient-to-br from-blue-600 to-indigo-700 flex items-center justify-center border border-white/20 shadow-lg">
                    <i class="fas fa-user text-white"></i>
                </div>
            </div>

            <a href="LogoutServlet" class="p-2 text-gray-500 hover:text-red-500 transition-colors" title="Logout">
                <i class="fas fa-sign-out-alt"></i>
            </a>
        </div>
    <% } %>
</div>
</div>
</nav>