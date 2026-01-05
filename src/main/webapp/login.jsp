<%-- 
    Document   : login
    Created on : Dec 31, 2025, 12:38:52 PM
    Author     : USER
--%>
<% if("reg_success".equals(request.getParameter("status"))) { %>
    <div class="bg-emerald-500/10 border border-emerald-500/50 text-emerald-500 text-[10px] p-3 rounded-xl mb-6 text-center font-bold uppercase tracking-widest">
        Akun berhasil dibuat! Silakan login.
    </div>
<% } %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.tailwindcss.com"></script>
        <title>LayarKlik - Login</title>
    </head>
    <body>
        <div class="min-h-screen flex items-center justify-center p-6 relative" 
            style="background-image: url('images/bg-login.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">

           <div class="absolute inset-0 bg-slate-950/30 backdrop-blur-sm"></div>

           <div class="relative w-full max-w-md z-10">
               <div class="absolute -top-10 -left-10 w-32 h-32 bg-blue-500 rounded-full mix-blend-screen filter blur-3xl opacity-10 animate-blob"></div>
               <div class="absolute -bottom-10 -right-10 w-32 h-32 bg-indigo-500 rounded-full mix-blend-screen filter blur-3xl opacity-10 animate-blob animation-delay-2000"></div>

               <div class="relative bg-slate-900/90 backdrop-blur-2xl border border-white/10 p-8 rounded-3xl shadow-2xl">

                   <div class="text-center mb-8">
                       <div class="inline-flex items-center justify-center w-16 h-16 border-blue-600/30 border-2 rounded-2xl shadow-lg mb-4">
                           <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                           <img src="images/logo.png" 
                            class="w-full h-full p-2 object-contain" 
                            alt="LayarKlik Logo">
                       </div>
                       <h2 class="text-3xl font-bold text-white tracking-tight">LayarKlik</h2>
                       <p class="text-slate-400 mt-2 text-sm">Masuk untuk memesan tiket bioskop favoritmu</p>
                   </div>
                   
                   <% if(request.getParameter("error") != null) { %>
                        <div class="bg-red-500/10 border border-red-500/50 text-red-500 text-xs p-4 rounded-2xl mb-6 text-center">
                            Username atau Password salah!
                        </div>
                    <% } %>

                   <form action="LoginProcessServlet" method="POST" class="space-y-6">
                       <div>
                           <label class="block text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2">Email / Username</label>
                           <div class="relative group">
                               <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-slate-500 group-focus-within:text-blue-500 transition-colors">
                                   <i class="fas fa-user"></i>
                               </span>
                               <input type="text" name="username" placeholder="nama@email.com" required
                                   class="block w-full pl-11 pr-4 py-3.5 bg-slate-800/50 border border-slate-700 rounded-xl text-white placeholder-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:bg-slate-800 transition-all"
                                   placeholder="nama@email.com">
                           </div>
                       </div>

                       <div>
                           <label class="block text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2">Password</label>
                           <div class="relative group">
                               <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-slate-500 group-focus-within:text-blue-500 transition-colors">
                                   <i class="fas fa-lock"></i>
                               </span>
                               <input type="password" name="password" placeholder="••••••••" required
                                   class="block w-full pl-11 pr-4 py-3.5 bg-slate-800/50 border border-slate-700 rounded-xl text-white placeholder-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:bg-slate-800 transition-all"
                                   placeholder="••••••••">
                           </div>
                       </div>

                       <div class="flex items-center justify-between text-xs text-slate-400">
                           <label class="flex items-center cursor-pointer hover:text-white transition-colors">
                               <input type="checkbox" class="rounded bg-slate-800 border-slate-700 text-blue-600 focus:ring-0 focus:ring-offset-0 mr-2">
                               Ingat saya
                           </label>
                           <a href="#" class="hover:text-blue-400 transition-colors">Lupa Password?</a>
                       </div>

                       <button type="submit" 
                           class="w-full py-4 px-4 bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 text-white font-bold rounded-xl shadow-blue-900/20 shadow-xl transform active:scale-[0.98] transition-all">
                           LOG IN
                       </button>
                   </form>

                   <div class="mt-8 text-center text-sm">
                       <p class="text-slate-400">
                           Belum punya akun? 
                           <a href="register.jsp" class="text-blue-400 font-bold hover:text-blue-300 transition-colors">Daftar Sekarang</a>
                       </p>
                       <a href="index.jsp" 
                            class="absolute top-8 left-8 z-20 w-10 h-10 flex items-center justify-center bg-slate-900/50 backdrop-blur-xl border border-white/10 rounded-full text-white hover:bg-blue-600 hover:border-blue-500 transition-all shadow-lg"
                            title="Kembali ke Utama">
                             <i class="fas fa-home"></i>
                         </a>
                   </div>
               </div>
           </div>
       </div>
    </body>
</html>
