<div class="relative group">
  <div id="slider" class="flex overflow-x-auto snap-x snap-mandatory scroll-smooth no-scrollbar">
    
    <div class="flex-none w-full snap-center relative">
      <img src="${pageContext.request.contextPath}/images/1.jpg" class="w-full h-auto" alt="Slide 1">
    </div>

    <div class="flex-none w-full snap-center relative">
      <img src="${pageContext.request.contextPath}/images/2.png" class="w-full h-auto object-cover" alt="Slide 2">
      <div class="absolute inset-0 bg-black/30 flex items-center px-12 md:px-24">
      </div>
    </div>

    <div class="flex-none w-full snap-center relative">
      <img src="${pageContext.request.contextPath}/images/3.jpg" class="w-full h-auto object-cover" alt="Slide 3">
    </div>

  </div>

  <button onclick="prevSlide()" class="absolute left-4 top-1/2 -translate-y-1/2 bg-white/20 hover:bg-white/40 backdrop-blur-md text-white p-4 rounded-full transition-all opacity-0 group-hover:opacity-100 focus:outline-none">
    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2.5" stroke="currentColor" class="w-6 h-6">
      <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5L8.25 12l7.5-7.5" />
    </svg>
  </button>

  <button onclick="nextSlide()" class="absolute right-4 top-1/2 -translate-y-1/2 bg-white/20 hover:bg-white/40 backdrop-blur-md text-white p-4 rounded-full transition-all opacity-0 group-hover:opacity-100 focus:outline-none">
    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2.5" stroke="currentColor" class="w-6 h-6">
      <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
    </svg>
  </button>
</div>

<script>
  const slider = document.getElementById('slider');

  function nextSlide() {
    // Menggeser ke kanan selebar satu layar
    slider.scrollLeft += slider.offsetWidth;
  }

  function prevSlide() {
    // Menggeser ke kiri selebar satu layar
    slider.scrollLeft -= slider.offsetWidth;
  }
</script>