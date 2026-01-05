
// ======================================
// DATA REFERENSI
// ======================================


const referenceCinemas = [
  { id: 'xxi-1', name: 'Cinema XXI Grand Indonesia', location: 'Jakarta Pusat', partner: 'XXI' },
  { id: 'xxi-2', name: 'Cinema XXI Pacific Place', location: 'Jakarta Selatan', partner: 'XXI' },
  { id: 'cgv-1', name: 'CGV Blitz Grand Indonesia', location: 'Jakarta Pusat', partner: 'CGV' },
  { id: 'cgv-2', name: 'CGV Paris Van Java', location: 'Bandung', partner: 'CGV' },
  { id: 'cinepolis-1', name: 'Cinépolis Plaza Senayan', location: 'Jakarta Pusat', partner: 'Cinépolis' },
  { id: 'cinepolis-2', name: 'Cinépolis Lippo Mall Puri', location: 'Jakarta Barat', partner: 'Cinépolis' }
];

const referenceShowtimes = ['10:00', '13:00', '16:00', '19:00', '21:30'];

const memberData = [
    { nama : 'Rois Azzam Shiddiq', email : 'isamiq3@gmail.com', nim : '0110224156', foto : '#'},
    { nama : 'nama', email : '@gmail.com', nim : '0110224', foto : '#'},
    { nama : 'nama', email : '@gmail.com', nim : '0110224', foto : '#'},
    { nama : 'nama', email : '@gmail.com', nim : '0110224', foto : '#'},
    { nama : 'nama', email : '@gmail.com', nim : '0110224', foto : '#'} 
];

// ======================================
// CONFIG & STATE
// ======================================

const defaultConfig = {
  background_color: '#0f172a',
  navbar_color: '#1e293b',
  accent_color: '#3b82f6',
  text_color: '#ffffff',
  card_color: '#1e293b',
  site_name: 'CinemaBook',
  tagline: 'Pesan Tiket Bioskop Favorit Anda',
  promo_title: 'DISKON 50%',
  promo_subtitle: 'Untuk Film Pilihan',
  footer_text: '© 2024 CinemaBook. All rights reserved.',
  developer_name: 'Developed by TechTeam Indonesia'
};

let currentUser = null;
let currentBooking = {
  movie: null,
  cinema: null,
  date: null,
  time: null,
  seats: [],
  step: 1
};
let allBookings = [];

// ======================================
// SDK INITIALIZATION
// ======================================

const dataHandler = {
  onDataChanged(data) {
    allBookings = data;
  }
};

async function initApp() {
  // Initialize Data SDK
  if (window.dataSdk) {
    const initResult = await window.dataSdk.init(dataHandler);
    if (!initResult.isOk) {
      console.error('Failed to initialize data SDK');
    }
  }

  // Initialize Element SDK
  if (window.elementSdk) {
    await window.elementSdk.init({
      defaultConfig,
      onConfigChange: async (config) => {
        const body = document.body;
        body.style.background = config.background_color || defaultConfig.background_color;
        body.style.color = config.text_color || defaultConfig.text_color;

        const navbar = document.getElementById('navbar');
        navbar.style.background = config.navbar_color || defaultConfig.navbar_color;

        const hero = document.getElementById('hero');
        hero.style.background = config.navbar_color || defaultConfig.navbar_color;

        const promoBanner = document.getElementById('promo-banner');
        promoBanner.querySelector('div').style.background = config.accent_color || defaultConfig.accent_color;

        const appPromo = document.getElementById('app-promo');
        appPromo.querySelector('div').style.background = config.navbar_color || defaultConfig.navbar_color;

        const footer = document.querySelector('footer');
        footer.style.background = config.navbar_color || defaultConfig.navbar_color;

        const allButtons = document.querySelectorAll('button:not(.seat)');
        allButtons.forEach(btn => {
          if (!btn.classList.contains('step-circle')) {
            btn.style.background = config.accent_color || defaultConfig.accent_color;
            btn.style.color = config.text_color || defaultConfig.text_color;
          }
        });

        const cards = document.querySelectorAll('.movie-card, section > div > div');
        cards.forEach(card => {
          card.style.background = config.card_color || defaultConfig.card_color;
        });

        const modals = document.querySelectorAll('.modal > div');
        modals.forEach(modal => {
          modal.style.background = config.card_color || defaultConfig.card_color;
        });

        const inputs = document.querySelectorAll('input, select');
        inputs.forEach(input => {
          input.style.background = config.card_color || defaultConfig.card_color;
          input.style.color = config.text_color || defaultConfig.text_color;
          input.style.borderColor = config.accent_color || defaultConfig.accent_color;
        });

        // Update text content
        document.getElementById('site-name').textContent = config.site_name || defaultConfig.site_name;
        document.getElementById('tagline').textContent = config.tagline || defaultConfig.tagline;
        document.getElementById('promo-title').textContent = config.promo_title || defaultConfig.promo_title;
        document.getElementById('promo-subtitle').textContent = config.promo_subtitle || defaultConfig.promo_subtitle;
        document.getElementById('footer-text').textContent = config.footer_text || defaultConfig.footer_text;
        document.getElementById('developer-name').textContent = config.developer_name || defaultConfig.developer_name;
      },
      mapToCapabilities: (config) => ({
        recolorables: [
          {
            get: () => config.background_color || defaultConfig.background_color,
            set: (value) => {
              if (window.elementSdk) {
                window.elementSdk.config.background_color = value;
                window.elementSdk.setConfig({ background_color: value });
              }
            }
          },
          {
            get: () => config.navbar_color || defaultConfig.navbar_color,
            set: (value) => {
              if (window.elementSdk) {
                window.elementSdk.config.navbar_color = value;
                window.elementSdk.setConfig({ navbar_color: value });
              }
            }
          },
          {
            get: () => config.text_color || defaultConfig.text_color,
            set: (value) => {
              if (window.elementSdk) {
                window.elementSdk.config.text_color = value;
                window.elementSdk.setConfig({ text_color: value });
              }
            }
          },
          {
            get: () => config.accent_color || defaultConfig.accent_color,
            set: (value) => {
              if (window.elementSdk) {
                window.elementSdk.config.accent_color = value;
                window.elementSdk.setConfig({ accent_color: value });
              }
            }
          },
          {
            get: () => config.card_color || defaultConfig.card_color,
            set: (value) => {
              if (window.elementSdk) {
                window.elementSdk.config.card_color = value;
                window.elementSdk.setConfig({ card_color: value });
              }
            }
          }
        ],
        borderables: [],
        fontEditable: undefined,
        fontSizeable: undefined
      }),
      mapToEditPanelValues: (config) => new Map([
        ['site_name', config.site_name || defaultConfig.site_name],
        ['tagline', config.tagline || defaultConfig.tagline],
        ['promo_title', config.promo_title || defaultConfig.promo_title],
        ['promo_subtitle', config.promo_subtitle || defaultConfig.promo_subtitle],
        ['footer_text', config.footer_text || defaultConfig.footer_text],
        ['developer_name', config.developer_name || defaultConfig.developer_name]
      ])
    });
  }

  // Render movies setelah SDK siap
  renderMovies(referenceMovies);
}

// ======================================
// RENDER FUNCTIONS
// ======================================

function renderMovies(movies) {
  const grid = document.getElementById('movies-grid');
  if (!grid) {
    console.error('Movies grid not found!');
    return;
  }
  
  grid.innerHTML = movies.map(movie => `
    <div class="movie-card rounded-lg overflow-hidden shadow-lg cursor-pointer bg-[#0C2B4E]" onclick="showMovieDetail('${movie.id}')">
      <div class="h-64 flex items-center justify-center text-6xl">
        🎬
      </div>
      <div class="p-4">
        <h3 class="font-bold text-lg mb-2">${movie.title}</h3>
        <p class="text-sm opacity-70 mb-2">${movie.genre}</p>
        <div class="flex items-center justify-between">
          <span class="font-semibold">
            ${movie.discount > 0 ? 
              `<span class="line-through opacity-50">Rp ${movie.price.toLocaleString()}</span> Rp ${(movie.price - movie.discount).toLocaleString()}` : 
              `Rp ${movie.price.toLocaleString()}`}
          </span>
          <span class="text-yellow-400"><i class="fas fa-star"></i> ${movie.rating}</span>
        </div>
      </div>
    </div>
  `).join('');
}

// ======================================
// MODAL & BOOKING FUNCTIONS
// ======================================

function showMovieDetail(movieId) {
  const movie = referenceMovies.find(m => m.id === movieId);
  if (!movie) return;

  const content = document.getElementById('movie-detail-content');
  if (!content) return;

 

  document.getElementById('movie-modal').classList.add('active');
}

function startBooking(movieId) {
  if (!currentUser) {
    showToast('Silakan login terlebih dahulu', 'error');
    document.getElementById('movie-modal').classList.remove('active');
    document.getElementById('auth-modal').classList.add('active');
    return;
  }

  currentBooking.movie = referenceMovies.find(m => m.id === movieId);
  currentBooking.step = 1;
  document.getElementById('movie-modal').classList.remove('active');
  showBookingStep();
}

function showBookingStep() {
  updateStepIndicator();
  const content = document.getElementById('booking-content');
  if (!content) return;

  if (currentBooking.step === 1) {
    content.innerHTML = `
      <div>
        <h4 class="text-xl font-bold mb-4">Pilih Bioskop</h4>
        <div class="grid md:grid-cols-2 gap-4">
          ${referenceCinemas.map(cinema => `
            <div class="p-4 rounded-lg border-2 cursor-pointer hover:opacity-80 transition" onclick="selectCinema('${cinema.id}')">
              <div class="font-bold text-lg mb-2">${cinema.name}</div>
              <p class="text-sm opacity-70"><i class="fas fa-map-marker-alt mr-2"></i>${cinema.location}</p>
              <p class="text-xs opacity-50 mt-2">Partner: ${cinema.partner}</p>
            </div>
          `).join('')}
        </div>
      </div>
    `;
  } else if (currentBooking.step === 2) {
    const today = new Date();
    const dates = Array.from({ length: 7 }, (_, i) => {
      const date = new Date(today);
      date.setDate(today.getDate() + i);
      return date;
    });

    content.innerHTML = `
      <div>
        <h4 class="text-xl font-bold mb-4">Pilih Tanggal & Waktu</h4>
        <div class="mb-6">
          <label class="block mb-2 font-semibold">Tanggal</label>
          <select id="date-select" class="w-full px-4 py-3 rounded-lg border-2">
            ${dates.map(date => `
              <option value="${date.toISOString().split('T')[0]}">
                ${date.toLocaleDateString('id-ID', { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' })}
              </option>
            `).join('')}
          </select>
        </div>
        <div class="mb-6">
          <label class="block mb-2 font-semibold">Waktu Tayang</label>
          <div class="grid grid-cols-3 md:grid-cols-5 gap-3">
            ${referenceShowtimes.map(time => `
              <button onclick="selectShowtime('${time}')" class="py-3 rounded-lg border-2 hover:opacity-80 transition">
                ${time}
              </button>
            `).join('')}
          </div>
        </div>
        <button onclick="currentBooking.step = 1; showBookingStep();" class="px-6 py-2 rounded-lg opacity-70 hover:opacity-100 transition">
          <i class="fas fa-arrow-left mr-2"></i>Kembali
        </button>
      </div>
    `;
  } else if (currentBooking.step === 3) {
    const rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
    const seatsPerRow = 12;
    const occupiedSeats = ['A5', 'A6', 'C7', 'D8', 'F10', 'G5'];

    content.innerHTML = `
      <div>
        <h4 class="text-xl font-bold mb-4">Pilih Kursi</h4>
        <div class="mb-6">
          <div class="screen"></div>
          <p class="text-center text-sm opacity-70 mb-6">Layar</p>
          <div class="max-w-3xl mx-auto">
            ${rows.map(row => `
              <div class="flex justify-center gap-2 mb-2">
                <span class="w-8 flex items-center justify-center font-semibold">${row}</span>
                ${Array.from({ length: seatsPerRow }, (_, i) => {
                  const seatNum = i + 1;
                  const seatId = `${row}${seatNum}`;
                  const isOccupied = occupiedSeats.includes(seatId);
                  const isSelected = currentBooking.seats.includes(seatId);
                  return `<div class="seat ${isOccupied ? 'occupied' : isSelected ? 'selected' : 'available'}" onclick="${isOccupied ? '' : `toggleSeat('${seatId}')`}"></div>`;
                }).join('')}
              </div>
            `).join('')}
          </div>
          <div class="flex justify-center gap-6 mt-6 text-sm">
            <div class="flex items-center gap-2">
              <div class="w-6 h-6 bg-gray-300 rounded"></div>
              <span>Tersedia</span>
            </div>
            <div class="flex items-center gap-2">
              <div class="w-6 h-6 rounded" style="background: #3b82f6;"></div>
              <span>Dipilih</span>
            </div>
            <div class="flex items-center gap-2">
              <div class="w-6 h-6 bg-gray-400 rounded"></div>
              <span>Terisi</span>
            </div>
          </div>
        </div>
        <div class="flex justify-between items-center mb-4">
          <div>
            <p class="font-semibold">Kursi Terpilih: <span id="selected-seats">${currentBooking.seats.join(', ') || '-'}</span></p>
            <p class="font-semibold">Total: Rp <span id="total-price">${calculateTotal().toLocaleString()}</span></p>
          </div>
          <div class="flex gap-3">
            <button onclick="currentBooking.step = 2; showBookingStep();" class="px-6 py-2 rounded-lg opacity-70 hover:opacity-100 transition">
              <i class="fas fa-arrow-left mr-2"></i>Kembali
            </button>
            <button onclick="if(currentBooking.seats.length > 0) { currentBooking.step = 4; showBookingStep(); } else { showToast('Pilih kursi terlebih dahulu', 'error'); }" class="px-6 py-3 rounded-lg font-semibold transition hover:opacity-90">
              Lanjutkan
            </button>
          </div>
        </div>
      </div>
    `;
  } else if (currentBooking.step === 4) {
    content.innerHTML = `
      <div>
        <h4 class="text-xl font-bold mb-6">Pembayaran</h4>
        <div class="grid md:grid-cols-2 gap-8">
          <div>
            <h5 class="font-bold mb-4">Detail Pemesanan</h5>
            <div class="p-4 rounded-lg mb-4">
              <p class="mb-2"><strong>Film:</strong> ${currentBooking.movie.title}</p>
              <p class="mb-2"><strong>Bioskop:</strong> ${currentBooking.cinema.name}</p>
              <p class="mb-2"><strong>Tanggal:</strong> ${new Date(currentBooking.date).toLocaleDateString('id-ID', { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' })}</p>
              <p class="mb-2"><strong>Waktu:</strong> ${currentBooking.time}</p>
              <p class="mb-2"><strong>Kursi:</strong> ${currentBooking.seats.join(', ')}</p>
              <p class="mb-2"><strong>Jumlah Tiket:</strong> ${currentBooking.seats.length}</p>
              <hr class="my-3 opacity-20">
              <p class="text-xl font-bold">Total: Rp ${calculateTotal().toLocaleString()}</p>
            </div>
          </div>
          <div>
            <h5 class="font-bold mb-4">Metode Pembayaran</h5>
            <div class="space-y-3">
              <button onclick="selectPayment('QRIS')" class="w-full p-4 rounded-lg border-2 text-left hover:opacity-80 transition">
                <i class="fas fa-qrcode mr-3"></i>QRIS
              </button>
              <button onclick="selectPayment('E-Money')" class="w-full p-4 rounded-lg border-2 text-left hover:opacity-80 transition">
                <i class="fas fa-wallet mr-3"></i>E-Money (GoPay, OVO, Dana)
              </button>
              <button onclick="selectPayment('Cash')" class="w-full p-4 rounded-lg border-2 text-left hover:opacity-80 transition">
                <i class="fas fa-money-bill-wave mr-3"></i>Cash (Bayar di Kasir)
              </button>
            </div>
            <button onclick="currentBooking.step = 3; showBookingStep();" class="w-full mt-6 px-6 py-2 rounded-lg opacity-70 hover:opacity-100 transition">
              <i class="fas fa-arrow-left mr-2"></i>Kembali
            </button>
          </div>
        </div>
      </div>
    `;
  }

  document.getElementById('booking-modal').classList.add('active');
}

function updateStepIndicator() {
  const circles = document.querySelectorAll('.step-circle');
  const accentColor = window.elementSdk?.config?.accent_color || defaultConfig.accent_color;
  const textColor = window.elementSdk?.config?.text_color || defaultConfig.text_color;

  circles.forEach((circle, index) => {
    if (index + 1 <= currentBooking.step) {
      circle.style.background = accentColor;
      circle.style.color = textColor;
    } else {
      circle.style.background = 'transparent';
      circle.style.border = `2px solid ${accentColor}`;
      circle.style.color = accentColor;
    }
  });
}

// ======================================
// BOOKING ACTIONS
// ======================================

function selectCinema(cinemaId) {
  currentBooking.cinema = referenceCinemas.find(c => c.id === cinemaId);
  currentBooking.step = 2;
  showBookingStep();
}

function selectShowtime(time) {
  const dateSelect = document.getElementById('date-select');
  currentBooking.date = dateSelect.value;
  currentBooking.time = time;
  currentBooking.step = 3;
  showBookingStep();
}

function toggleSeat(seatId) {
  const index = currentBooking.seats.indexOf(seatId);
  if (index === -1) {
    currentBooking.seats.push(seatId);
  } else {
    currentBooking.seats.splice(index, 1);
  }
  showBookingStep();
}

function calculateTotal() {
  if (!currentBooking.movie) return 0;
  const pricePerSeat = currentBooking.movie.price - currentBooking.movie.discount;
  return pricePerSeat * currentBooking.seats.length;
}

async function selectPayment(method) {
  const loadingBtn = event.target;
  const originalContent = loadingBtn.innerHTML;
  loadingBtn.disabled = true;
  loadingBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Memproses...';

  if (window.dataSdk && allBookings.length >= 999) {
    showToast('Maksimum 999 pemesanan telah tercapai. Silakan hubungi admin.', 'error');
    loadingBtn.disabled = false;
    loadingBtn.innerHTML = originalContent;
    return;
  }

  const bookingData = {
    id: 'booking-' + Date.now(),
    user_email: currentUser,
    movie_title: currentBooking.movie.title,
    cinema_name: currentBooking.cinema.name,
    cinema_location: currentBooking.cinema.location,
    show_date: currentBooking.date,
    show_time: currentBooking.time,
    seats: currentBooking.seats.join(','),
    total_price: calculateTotal(),
    payment_method: method,
    booking_date: new Date().toISOString(),
    status: 'confirmed'
  };

  if (window.dataSdk) {
    const result = await window.dataSdk.create(bookingData);
    if (result.isOk) {
      showToast('Pemesanan berhasil! Tiket telah dikirim ke email Anda.', 'success');
      document.getElementById('booking-modal').classList.remove('active');
      resetBooking();
    } else {
      showToast('Gagal menyimpan pemesanan. Silakan coba lagi.', 'error');
    }
  } else {
    showToast('Pemesanan berhasil! Tiket telah dikirim ke email Anda.', 'success');
    document.getElementById('booking-modal').classList.remove('active');
    resetBooking();
  }

  loadingBtn.disabled = false;
  loadingBtn.innerHTML = originalContent;
}

function resetBooking() {
  currentBooking = {
    movie: null,
    cinema: null,
    date: null,
    time: null,
    seats: [],
    step: 1
  };
}

// ======================================
// UTILITY FUNCTIONS
// ======================================

function showToast(message, type = 'success') {
  const toast = document.createElement('div');
  toast.className = 'toast';
  toast.style.background = type === 'success' ? '#10b981' : '#ef4444';
  toast.innerHTML = `<i class="fas fa-${type === 'success' ? 'check-circle' : 'exclamation-circle'} mr-2"></i>${message}`;
  document.body.appendChild(toast);

  setTimeout(() => {
    toast.remove();
  }, 3000);
}

// ======================================
// AUTH SYSTEM
// ======================================
function showLoginForm() {
  document.getElementById('auth-title').textContent = 'Masuk';
  document.getElementById('login-form').classList.remove('hidden');
  document.getElementById('register-form').classList.add('hidden');
  document.getElementById('toggle-text').textContent = 'Belum punya akun?';
  document.getElementById('toggle-auth').textContent = 'Daftar';
}

function showRegisterForm() {
  document.getElementById('auth-title').textContent = 'Daftar';
  document.getElementById('login-form').classList.add('hidden');
  document.getElementById('register-form').classList.remove('hidden');
  document.getElementById('toggle-text').textContent = 'Sudah punya akun?';
  document.getElementById('toggle-auth').textContent = 'Masuk';
}

// ======================================
// DEVELOPER SECTION – GLOBAL FUNCTIONS (WAJIB DI LUAR!)
// ======================================

function renderDevelopers() {
const grid = document.getElementById('developer-grid');
if (!grid) {
    console.warn('developer-grid tidak ditemukan!');
    return;
}

grid.innerHTML = memberData.map((member, index) => `
    <div class="developer-card rounded-lg overflow-hidden shadow-lg cursor-pointer transition-transform hover:scale-105" 
        onclick="showDeveloperDetail(${index})">
    <div class="avatar bg-gradient-to-br from-purple-600 to-pink-600 h-48 flex items-center justify-center text-6xl text-white font-bold">
        ${member.foto !== '#' 
        ? `<img src="${member.foto}" alt="${member.nama}" class="w-full h-full object-cover">`
        : member.nama.charAt(0)}
    </div>
    <div class="p-4 text-center bg-white text-gray-800">
        <h3 class="font-bold text-lg">${member.nama}</h3>
        <h4 class="font-light text-lg">${member.email}</h4>
        <p class="text-sm opacity-70">${member.nim || 'Student'}</p>
    </div>
    </div>
`).join('');
}

function showDeveloperDetail(index) {
const member = memberData[index];
const content = document.getElementById('developer-detail-content');

if (!content) return;

content.innerHTML = `
    ${member.foto !== '#' 
    ? `<img src="${member.foto}" alt="${member.nama}" class="w-32 h-32 rounded-full mx-auto mb-4 object-cover border-4 border-[#667eea]">`
    : `<div class="w-32 h-32 rounded-full mx-auto mb-4 bg-gradient-to-br from-purple-600 to-pink-600 flex items-center justify-center text-5xl text-white font-bold border-4 border-[#667eea]">
        ${member.nama.charAt(0)}
        </div>`
    }
    <h4 class="text-2xl font-bold mb-2">${member.nama}</h4>
    <p class="text-lg mb-2"><strong>NIM :</strong> ${member.nim || '-'}</p>
    <p class="mb-6"><strong>Email :</strong> ${member.email}</p>

    <div class="flex flex-col sm:flex-row justify-center gap-4 mt-6">
    ${member.email && member.email !== '@gmail.com' 
        ? `<a href="mailto:${member.email}" class="px-6 py-3 bg-[#667eea] text-white rounded-lg hover:opacity-90 transition flex items-center justify-center">
            <i class="fas fa-envelope mr-2"></i>Kirim Email
        </a>`
        : ''}
    <button onclick="document.getElementById('developer-modal').classList.remove('active')"
            class="px-6 py-3 bg-gray-300 text-gray-800 rounded-lg hover:bg-gray-400 transition">
        Tutup
    </button>
    </div>
`;

document.getElementById('developer-modal').classList.add('active');
}

// ======================================
// DOM LOADED — SEMUA EVENT DI SINI
// ======================================
document.addEventListener('DOMContentLoaded', () => {

  // Buka modal login & tampilkan form login
  document.getElementById('login-btn').addEventListener('click', () => {
    document.getElementById('auth-modal').classList.add('active');
    showLoginForm();
  });

  // Tutup semua modal
  document.getElementById('close-auth-modal').onclick = () => document.getElementById('auth-modal').classList.remove('active');
  document.getElementById('close-movie-modal').onclick = () => document.getElementById('movie-modal').classList.remove('active');
  document.getElementById('close-booking-modal').onclick = () => {
    document.getElementById('booking-modal').classList.remove('active');
    resetBooking();
  };

  // Toggle Login ↔ Register
  document.getElementById('toggle-auth').addEventListener('click', () => {
    if (document.getElementById('auth-title').textContent === 'Masuk') {
      showRegisterForm();
    } else {
      showLoginForm();
    }
  });

  // LOGIN SUBMIT (Mengirim data ke Java/PostgreSQL)
    document.getElementById('login-form').addEventListener('submit', async (e) => {
        e.preventDefault();
        const email = document.getElementById('login-email').value.trim();
        const password = document.getElementById('login-password').value; // Pastikan id ini ada di HTML

        if (!email || !password) return showToast('Email dan password wajib diisi!', 'error');

        try {
            // Mengirim data ke Servlet Java
            const response = await fetch('LoginServlet', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `email=${encodeURIComponent(email)}&password=${encodeURIComponent(password)}`
            });

            const result = await response.json();

            if (result.success) {
                currentUser = email;
                document.getElementById('login-btn').innerHTML = `<i class="fas fa-user mr-2"></i>${result.username}`;
                document.getElementById('auth-modal').classList.remove('active');
                showToast('Login berhasil!', 'success');
            } else {
                // Jika akun tidak ada di PostgreSQL, pesan ini akan muncul
                showToast(result.message, 'error');
            }
        } catch (error) {
            showToast('Server Java belum aktif/error!', 'error');
        }
    });

  // REGISTER SUBMIT
  document.getElementById('register-form').addEventListener('submit', (e) => {
    e.preventDefault();

    const username = document.getElementById('reg-username').value.trim();
    const email    = document.getElementById('reg-email').value.trim();
    const phone    = document.getElementById('reg-phone').value.trim();
    const pass     = document.getElementById('reg-password').value;
    const confirm  = document.getElementById('reg-confirm').value;

    if (!username || !email || !phone || !pass) {
      showToast('Semua kolom wajib diisi!', 'error');
      return;
    }
    if (pass !== confirm) {
      showToast('Password dan konfirmasi tidak cocok!', 'error');
      return;
    }
    if (pass.length < 6) {
      showToast('Password minimal 6 karakter', 'error');
      return;
    }
    if (!/^\d{10,13}$/.test(phone)) {
      showToast('Nomor telepon tidak valid', 'error');
      return;
    }

    // Cek apakah email sudah terdaftar
    if (localStorage.getItem('cinemaBookUser_' + email)) {
      showToast('Email sudah terdaftar. Silakan login.', 'error');
      return;
    }

    // Simpan user
    localStorage.setItem('cinemaBookUser_' + email, JSON.stringify({ username, email, phone, password: pass }));
    
    currentUser = email;
    document.getElementById('login-btn').innerHTML = `<i class="fas fa-user mr-2"></i>${username}`;
    document.getElementById('auth-modal').classList.remove('active');
    showToast(`Selamat datang, ${username}! Akun berhasil dibuat`, 'success');
  });

  // Search
  document.getElementById('search-btn').onclick = () => {
    const query = document.getElementById('search-input').value.toLowerCase();
    const filtered = query ? referenceMovies.filter(m => 
      m.title.toLowerCase().includes(query) || m.genre.toLowerCase().includes(query)
    ) : referenceMovies;
    renderMovies(filtered);
    if (query) document.getElementById('movies').scrollIntoView({ behavior: 'smooth' });
  };

  document.getElementById('search-input').addEventListener('keypress', e => {
    if (e.key === 'Enter') document.getElementById('search-btn').click();
  });
    
    // Panggil render developer
    renderDevelopers();

    // Init app
    initApp();
});

// Global functions (untuk onclick inline)
window.showMovieDetail = showMovieDetail;
window.startBooking = startBooking;
window.selectCinema = selectCinema;
window.selectShowtime = selectShowtime;
window.toggleSeat = toggleSeat;
window.selectPayment = selectPayment;
window.showBookingStep = showBookingStep;
window.calculateTotal = calculateTotal;
window.resetBooking = resetBooking;
window.showToast = showToast;
window.showDeveloperDetail = showDeveloperDetail;