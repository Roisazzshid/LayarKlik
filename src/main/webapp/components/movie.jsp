<%@page import="dao.MoviesDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.Movies"%>

<%
    MoviesDAO dao = new MoviesDAO();
    List<Movies> daftarMovies = dao.getAll();
%>

<div class="max-w-full mx-auto px-4 py-8">
    <h2 class="text-3xl font-bold mb-8 flex items-center gap-3">
        <span class="w-2 h-8 bg-blue-600 rounded-full"></span>
        Sedang Tayang
    </h2>
    
    <div class="relative group">
        <div id="movie-slider" class="flex overflow-hidden snap-x snap-mandatory scroll-smooth gap-4 px-2">
            <% for (Movies m : daftarMovies) { %>
                <div class="flex-none w-48 snap-center">
                    <div class="flex flex-col group cursor-pointer">
                        <div class="aspect-[2/3] w-full rounded-xl overflow-hidden shadow-sm border border-gray-100 bg-gray-50 transition-all duration-300 group-hover:shadow-md group-hover:-translate-y-1">
                            <div class="w-full h-full flex items-center justify-center text-5xl bg-gradient-to-t from-gray-100 to-white">
                                ?
                            </div>
                        </div>

                        <div class="mt-3">
                            <h4 class="text-xs md:text-sm text-black font-bold uppercase leading-tight line-clamp-2 min-h-[2rem]">
                                <%= m.getTitle() %>
                            </h4>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>

        <!-- Tombol Navigasi -->
        <button id="prev-btn" onclick="prevMovieSlide()" class="absolute left-4 top-1/2 -translate-y-1/2 bg-black/50 hover:bg-black/70 backdrop-blur-md text-white p-4 rounded-full transition-all focus:outline-none z-10">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2.5" stroke="currentColor" class="w-6 h-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5L8.25 12l7.5-7.5" />
            </svg>
        </button>

        <button id="next-btn" onclick="nextMovieSlide()" class="absolute right-4 top-1/2 -translate-y-1/2 bg-black/50 hover:bg-black/70 backdrop-blur-md text-white p-4 rounded-full transition-all focus:outline-none z-10">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2.5" stroke="currentColor" class="w-6 h-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
            </svg>
        </button>
    </div>
</div>

<script>
    const movieSlider = document.getElementById('movie-slider');
    const prevBtn = document.getElementById('prev-btn');
    const nextBtn = document.getElementById('next-btn');
    const itemWidth = 192; // Lebar item (w-48 = 192px)
    const gap = 16; // Gap antar item (gap-4 = 16px)

    function updateButtonVisibility() {
        const maxScrollLeft = movieSlider.scrollWidth - movieSlider.clientWidth;
        prevBtn.style.display = movieSlider.scrollLeft <= 0 ? 'none' : 'block';
        nextBtn.style.display = movieSlider.scrollLeft >= maxScrollLeft ? 'none' : 'block';
    }

    function nextMovieSlide() {
        movieSlider.scrollLeft += itemWidth + gap;
        setTimeout(updateButtonVisibility, 300); // Tunggu transisi selesai
    }

    function prevMovieSlide() {
        movieSlider.scrollLeft -= itemWidth + gap;
        setTimeout(updateButtonVisibility, 300); // Tunggu transisi selesai
    }

    // Update visibility saat scroll
    movieSlider.addEventListener('scroll', updateButtonVisibility);

    // Inisialisasi visibility saat load
    updateButtonVisibility();
</script>