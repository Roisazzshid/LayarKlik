<div id="login-modal" tabindex="-1" aria-hidden="true" class="fixed top-0 left-0 right-0 z-50 hidden w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full">
    <div class="relative w-full max-w-md max-h-full">
        <div class="relative bg-slate-900/95 backdrop-blur-xl border border-white/20 rounded-2xl shadow-2xl overflow-hidden">
            
            <button type="button" class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-white/10 hover:text-white rounded-lg text-sm w-8 h-8 ml-auto inline-flex justify-center items-center" data-modal-hide="login-modal">
                <i class="fas fa-times"></i>
            </button>

            <div class="p-8">
                <div class="text-center mb-8">
                    <div class="inline-flex items-center justify-center w-14 h-14 bg-blue-600 rounded-xl shadow-lg mb-4">
                        <i class="fas fa-ticket-alt text-white text-2xl"></i>
                    </div>
                    <h2 class="text-2xl font-bold text-white tracking-tight">LayarKlik Login</h2>
                </div>

                <form action="LoginServlet" method="POST" class="space-y-5">
                    <div>
                        <label class="block text-xs font-medium text-gray-400 uppercase tracking-wider mb-2">Username</label>
                        <div class="relative group">
                            <span class="absolute inset-y-0 left-0 pl-3 flex items-center text-gray-500 group-focus-within:text-blue-500 transition-colors">
                                <i class="fas fa-user"></i>
                            </span>
                            <input type="text" name="username" required
                                class="block w-full pl-10 pr-3 py-2.5 bg-white/5 border border-white/10 rounded-xl text-white text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all"
                                placeholder="Masukkan username">
                        </div>
                    </div>

                    <div>
                        <label class="block text-xs font-medium text-gray-400 uppercase tracking-wider mb-2">Password</label>
                        <div class="relative group">
                            <span class="absolute inset-y-0 left-0 pl-3 flex items-center text-gray-500 group-focus-within:text-blue-500 transition-colors">
                                <i class="fas fa-lock"></i>
                            </span>
                            <input type="password" name="password" required
                                class="block w-full pl-10 pr-3 py-2.5 bg-white/5 border border-white/10 rounded-xl text-white text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all"
                                placeholder="????????">
                        </div>
                    </div>

                    <button type="submit" 
                        class="w-full py-3 bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 text-white font-bold rounded-xl shadow-lg transform active:scale-[0.98] transition-all">
                        MASUK SEKARANG
                    </button>
                </form>

                <div class="mt-6 text-center text-xs">
                    <p class="text-gray-400">
                        Belum punya akun? 
                        <a href="#" class="text-blue-400 font-semibold hover:underline">Daftar</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>