<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us — LayarKlik</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-slate-900 text-white antialiased font-[Plus_Jakarta_Sans]">

    <header class="sticky top-0 z-[60] glass-nav">
        <%@include file="/components/navbar.jsp" %>
    </header>

    <section class="max-w-6xl mx-auto px-6 py-16">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            <div>
                <h1 class="text-5xl font-black mb-6 leading-tight">Bawa Keajaiban Bioskop ke <span class="text-blue-500 underline decoration-blue-500/30">Genggaman Anda.</span></h1>
                <p class="text-slate-400 text-lg leading-relaxed mb-8">
                    LayarKlik adalah platform manajemen dan pemesanan tiket bioskop modern yang dirancang untuk memberikan kemudahan akses hiburan bagi para pecinta film. Kami percaya bahwa menonton film bukan sekadar hobi, melainkan pengalaman yang layak didapatkan dengan praktis dan cepat.
                </p>
                <div class="flex space-x-6">
                    <div class="flex items-center space-x-2">
                        <i class="fas fa-check-circle text-blue-500"></i>
                        <span class="text-sm font-semibold">Real-time Booking</span>
                    </div>
                    <div class="flex items-center space-x-2">
                        <i class="fas fa-check-circle text-blue-500"></i>
                        <span class="text-sm font-semibold">Multiple Cinemas</span>
                    </div>
                </div>
            </div>
            <div class="relative group">
                <div class="absolute -inset-1 bg-gradient-to-r from-blue-600 to-indigo-600 rounded-3xl blur opacity-25 group-hover:opacity-50 transition duration-1000"></div>
                <img src="${pageContext.request.contextPath}/images/Lobby.jpg" alt="LayarKlik Promo" class="relative rounded-3xl shadow-2xl border border-white/10 object-cover w-full">
            </div>
        </div>
    </section>

    <section id="about" class="py-32 max-w-7xl mx-auto px-6">
        <div class="text-center mb-20">
          <h2 class="text-6xl font-black italic tracking-tighter text-transparent bg-clip-text bg-gradient-to-r from-blue-500 to-indigo-500">OUR TEAM</h2>
          <p class="text-gray-500 font-medium mt-4 tracking-widest text-xs uppercase">Dibalik Layar Pengembangan LayarKlik</p>
        </div>
        
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-8">
          <%
            // DATA JAVA UNTUK TEAM
            List<Map<String, String>> team = new ArrayList<>();
            Map<String, String> t1 = new HashMap<>(); 
            t1.put("foto", "images/tim/rois.jpg"); // Path lokal
            t1.put("nama", "Rois Azzam Shiddiq"); 
            t1.put("nim", "0110224156"); 
            t1.put("email", "isamiq3@gmail.com"); 
            t1.put("github", "https://github.com/Roisazzshid"); 
            team.add(t1);
            
            Map<String, String> t2 = new HashMap<>();
            t2.put("foto", "images/tim/fatur.jpeg");
            t2.put("nama", "Faturrahman");
            t2.put("nim", "0110224236");
            t2.put("email", "faturrahman072006@gmail.com");
            t2.put("github", "https://github.com/faturaxxel"); 
            team.add(t2);
            
            Map<String, String> t3 = new HashMap<>(); 
            t3.put("foto", "images/tim/indah.jpeg"); 
            t3.put("nama", "Nur Indah"); 
            t3.put("nim", "0110224199"); 
            t3.put("email", "0110224199@student.nurulfikri.ac.id"); 
            t3.put("github", "https://github.com/nuri1306"); 
            team.add(t3);
            
            Map<String, String> t4 = new HashMap<>(); 
            t4.put("foto", "images/tim/aisyah.jpeg"); 
            t4.put("nama", "Aisyah Az Zahra"); 
            t4.put("nim", "0110224054"); 
            t4.put("email", "azzahrasyaa1705@gmail.com"); 
            t4.put("github", "https://github.com/Aisyaramli15"); 
            team.add(t4);
            
            Map<String, String> t5 = new HashMap<>(); 
            t5.put("foto", "images/tim/ima.jpeg"); 
            t5.put("nama", "Muhamad Imadudin"); 
            t5.put("nim", "0110224196"); 
            t5.put("email", "chenelstory96@gmail.com"); 
            t5.put("github", "https://github.com/Imadudin6060"); 
            team.add(t5);

            for (Map<String, String> dev : team) {
          %>
          <div class="group relative h-[300px] rounded-[32px] overflow-hidden p-[1px] bg-gradient-to-b from-white/10 to-transparent hover:from-blue-600 transition-all duration-700 shadow-2xl">
            <div class="relative w-full h-full bg-brand-dark rounded-[31px] overflow-hidden">

                <div class="absolute inset-0 w-full h-full overflow-hidden">
                    <% if (dev.get("foto") != null && !dev.get("foto").isEmpty()) { %>
                        <img src="${pageContext.request.contextPath}/<%= dev.get("foto") %>" 
                             alt="<%= dev.get("nama") %>" 
                             class="w-full h-full object-cover transition-transform duration-1000 ease-out group-hover:scale-110">
                    <% } else { %>
                        <div class="w-full h-full bg-gradient-to-br from-slate-800 to-slate-900 flex items-center justify-center">
                            <span class="text-6xl font-black text-white/10"><%= dev.get("nama").substring(0, 1) %></span>
                        </div>
                    <% } %>

                    <div class="absolute inset-0 bg-gradient-to-t from-[#020617] via-[#020617]/40 to-transparent opacity-80 group-hover:opacity-90 transition-opacity duration-500"></div>
                </div>

                <div class="relative h-full flex flex-col items-center justify-end p-8 text-center z-10">
    
                    <div class="transform translate-y-16 group-hover:translate-y-0 transition-all duration-500 ease-out">

                        <h3 class="text-sm font-black text-white tracking-tight drop-shadow-[0_2px_10px_rgba(0,0,0,0.8)] uppercase italic">
                            <%= dev.get("nama") %>
                        </h3>

                        <p class="text-xs font-bold text-blue-400 mt-1 tracking-[0.2em] opacity-0 group-hover:opacity-100 transition-opacity duration-700 delay-100">
                            <%= dev.get("nim") %>
                        </p>

                        <div class="flex items-center justify-center space-x-4 mt-6 opacity-0 group-hover:opacity-100 transition-all duration-500 delay-200">
                            <a href="<%= dev.get("github") %>" class="w-9 h-9 rounded-xl bg-white/10 backdrop-blur-md flex items-center justify-center text-white hover:bg-blue-600 hover:scale-110 transition-all border border-white/10">
                                <i class="fab fa-github text-sm"></i>
                            </a>
                            <a href="mailto:<%= dev.get("email") %>" class="w-9 h-9 rounded-xl bg-white/10 backdrop-blur-md flex items-center justify-center text-white hover:bg-blue-600 hover:scale-110 transition-all border border-white/10" title="<%= dev.get("email") %>">
                                <i class="fas fa-envelope text-sm"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
          </div>
          <% } %>
        </div>
      </section>

    <footer class="relative bg-brand-dark pt-20 pb-10 border-t border-white/5 overflow-hidden">
        <%@include file="/components/footer.jsp" %>
    </footer>

</body>
</html>