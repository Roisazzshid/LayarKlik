<%-- 
    Document   : database
    Created on : Jan 16, 2026, 4:23:39 PM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Database — LayarKlik</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-slate-900 text-white antialiased font-[Plus_Jakarta_Sans]">

    <header class="sticky top-0 z-[60] glass-nav">
        <%@include file="/components/navbar.jsp" %>
    </header>

    <section class="relative py-24 bg-slate-800/30 border-t border-white/5">
        <div class="max-w-6xl mx-auto px-6">
            
            <div class="text-center mb-16">
                <h2 class="text-3xl md:text-4xl font-bold mb-4">Arsitektur <span class="text-blue-500">Database</span></h2>
                <p class="text-slate-400 max-w-2xl mx-auto">
                    Sistem LayarKlik dibangun di atas struktur SQL yang robust, mengintegrasikan manajemen aset bioskop, penjadwalan real-time, dan transaksi tiket yang aman.
                </p>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-start">
                
                <div class="space-y-8">
                    <div class="bg-slate-900/50 p-6 rounded-2xl border border-white/5 hover:border-blue-500/30 transition duration-300 group">
                        <div class="flex items-start space-x-4">
                            <div class="p-3 bg-blue-500/10 rounded-lg text-blue-400 group-hover:bg-blue-500 group-hover:text-white transition">
                                <i class="fas fa-film text-xl"></i>
                            </div>
                            <div>
                                <h3 class="text-xl font-bold text-white mb-2">Manajemen Aset Bioskop</h3>
                                <p class="text-slate-400 text-sm leading-relaxed">
                                    Mengelola entitas fisik bioskop secara terstruktur. Tabel <code class="text-blue-400">Cinemas</code> memiliki banyak <code class="text-blue-400">Studios</code>, dan setiap studio memetakan ribuan <code class="text-blue-400">Seats</code> secara unik. Data film disimpan terpisah di tabel <code class="text-blue-400">Movies</code> untuk fleksibilitas penayangan.
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="bg-slate-900/50 p-6 rounded-2xl border border-white/5 hover:border-purple-500/30 transition duration-300 group">
                        <div class="flex items-start space-x-4">
                            <div class="p-3 bg-purple-500/10 rounded-lg text-purple-400 group-hover:bg-purple-500 group-hover:text-white transition">
                                <i class="fas fa-calendar-alt text-xl"></i>
                            </div>
                            <div>
                                <h3 class="text-xl font-bold text-white mb-2">Logika Penjadwalan (Schedules)</h3>
                                <p class="text-slate-400 text-sm leading-relaxed">
                                    Jantung dari sistem ini adalah tabel <code class="text-purple-400">Schedules</code>. Tabel ini bertindak sebagai penghubung (pivot) yang mempertemukan Film, Studio, Tanggal, dan Harga. User memilih jadwal, bukan memilih film secara langsung.
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="bg-slate-900/50 p-6 rounded-2xl border border-white/5 hover:border-green-500/30 transition duration-300 group">
                        <div class="flex items-start space-x-4">
                            <div class="p-3 bg-green-500/10 rounded-lg text-green-400 group-hover:bg-green-500 group-hover:text-white transition">
                                <i class="fas fa-ticket-alt text-xl"></i>
                            </div>
                            <div>
                                <h3 class="text-xl font-bold text-white mb-2">Transaksi & Tiketing</h3>
                                <p class="text-slate-400 text-sm leading-relaxed">
                                    Sistem mencatat pemesanan di tabel <code class="text-green-400">Bookings</code> (Header) dan detail kursi di tabel <code class="text-green-400">Tickets</code> (Detail). Relasi ini memungkinkan satu user memesan banyak kursi dalam satu nomor invoice.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="relative group cursor-pointer" onclick="openModal()">
                    <div class="absolute -inset-1 bg-gradient-to-br from-blue-600 to-purple-600 rounded-2xl blur opacity-30 group-hover:opacity-60 transition duration-500"></div>
                    <div class="relative bg-slate-900 rounded-2xl border border-white/10 overflow-hidden shadow-2xl">
                        <div class="bg-slate-800 px-4 py-3 flex items-center space-x-2 border-b border-white/5">
                            <div class="w-3 h-3 rounded-full bg-red-500"></div>
                            <div class="w-3 h-3 rounded-full bg-yellow-500"></div>
                            <div class="w-3 h-3 rounded-full bg-green-500"></div>
                            <span class="ml-4 text-xs text-slate-500 font-mono">public.schema_visualizer — ERD</span>
                        </div>
                        
                        <div class="p-4 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')] bg-slate-900">
                            <img src="${pageContext.request.contextPath}/images/erd.png" 
                                 alt="ERD Database Bioskop" 
                                 class="w-full h-auto object-contain hover:scale-105 transition duration-500">
                        </div>

                        <div class="absolute inset-0 flex items-center justify-center bg-black/50 opacity-0 group-hover:opacity-100 transition duration-300">
                            <div class="bg-white/10 backdrop-blur-md px-6 py-3 rounded-full border border-white/20 text-white font-semibold flex items-center gap-2">
                                <i class="fas fa-search-plus"></i> Klik untuk Perbesar
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <div id="erdModal" class="fixed inset-0 z-[100] hidden">
        <div class="absolute inset-0 bg-slate-900/90 backdrop-blur-sm transition-opacity" onclick="closeModal()"></div>
        
        <div class="absolute top-4 left-1/2 transform -translate-x-1/2 z-[102] flex gap-4 bg-slate-800 p-2 rounded-full border border-white/10 shadow-2xl">
            <button onclick="zoomOut()" class="w-10 h-10 rounded-full bg-slate-700 text-white hover:bg-blue-600 transition flex items-center justify-center">
                <i class="fas fa-minus"></i>
            </button>
            <button onclick="resetZoom()" class="px-4 h-10 rounded-full bg-slate-700 text-white text-sm hover:bg-slate-600 transition flex items-center justify-center">
                Reset
            </button>
            <button onclick="zoomIn()" class="w-10 h-10 rounded-full bg-slate-700 text-white hover:bg-blue-600 transition flex items-center justify-center">
                <i class="fas fa-plus"></i>
            </button>
            <button onclick="closeModal()" class="w-10 h-10 rounded-full bg-red-500/20 text-red-500 hover:bg-red-500 hover:text-white transition flex items-center justify-center ml-2 border border-red-500/30">
                <i class="fas fa-times"></i>
            </button>
        </div>

        <div class="absolute inset-0 flex items-center justify-center overflow-hidden cursor-grab active:cursor-grabbing z-[101]" id="modalImageContainer">
            <img id="modalImage" 
                 src="${pageContext.request.contextPath}/images/erd.png" 
                 class="max-w-[90%] max-h-[90%] object-contain transition-transform duration-200 ease-out origin-center"
                 draggable="false">
        </div>
        
        <div class="absolute bottom-8 left-1/2 transform -translate-x-1/2 text-slate-400 text-sm bg-black/40 px-4 py-2 rounded-full backdrop-blur-md pointer-events-none">
            Gunakan Scroll Mouse untuk Zoom & Drag untuk Menggeser
        </div>
    </div>

    

    <footer class="relative bg-brand-dark pt-20 pb-10 border-t border-white/5 overflow-hidden">
        <%@include file="/components/footer.jsp" %>
    </footer>

    <script>
        const modal = document.getElementById('erdModal');
        const img = document.getElementById('modalImage');
        const container = document.getElementById('modalImageContainer');
        
        let scale = 1;
        let isDragging = false;
        let startX, startY, translateX = 0, translateY = 0;

        function openModal() {
            modal.classList.remove('hidden');
            document.body.style.overflow = 'hidden'; // Disable scroll page
            resetZoom();
        }

        function closeModal() {
            modal.classList.add('hidden');
            document.body.style.overflow = 'auto'; // Enable scroll page
        }

        function zoomIn() {
            scale += 0.2;
            updateTransform();
        }

        function zoomOut() {
            if (scale > 0.4) {
                scale -= 0.2;
                updateTransform();
            }
        }

        function resetZoom() {
            scale = 1;
            translateX = 0;
            translateY = 0;
            updateTransform();
        }

        function updateTransform() {
            img.style.transform = `translate(${translateX}px, ${translateY}px) scale(${scale})`;
        }

        // Mouse Wheel Zoom
        container.addEventListener('wheel', (e) => {
            e.preventDefault();
            if (e.deltaY < 0) {
                scale += 0.1;
            } else {
                if (scale > 0.4) scale -= 0.1;
            }
            updateTransform();
        });

        // Drag to Pan Logic
        container.addEventListener('mousedown', (e) => {
            if (scale > 1 || true) { // Allow drag always for better UX
                isDragging = true;
                startX = e.clientX - translateX;
                startY = e.clientY - translateY;
                container.style.cursor = 'grabbing';
            }
        });

        window.addEventListener('mouseup', () => {
            isDragging = false;
            container.style.cursor = 'grab';
        });

        window.addEventListener('mousemove', (e) => {
            if (!isDragging) return;
            e.preventDefault();
            translateX = e.clientX - startX;
            translateY = e.clientY - startY;
            updateTransform();
        });
        
        // Tutup modal dengan tombol ESC
        document.addEventListener('keydown', function(event) {
            if (event.key === "Escape") {
                closeModal();
            }
        });
    </script>
</body>
</html>
