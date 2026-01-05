<%@ page import="java.util.*" %>

<div class="max-w-7xl mx-auto px-4 py-12">
    <h2 class="text-3xl font-bold mb-10 text-center text-gray-800">Tim Pengembang</h2>

    <%
        List<Map<String, String>> members = new ArrayList<>();
        
        Map<String, String> dev1 = new HashMap<>();
        dev1.put("nama", "Rois Azzam Shiddiq");
        dev1.put("nim", "0110224156");
        dev1.put("email", "isamiq3@gmail.com");
        dev1.put("foto", "#");
        members.add(dev1);
        
        Map<String, String> dev2 = new HashMap<>();
        dev2.put("nama", "Siti Nurhaliza");
        dev2.put("nim", "87654321");
        dev2.put("email", "siti.nurhaliza@example.com");
        dev2.put("foto", "#");
        members.add(dev2);
        
        Map<String, String> dev3 = new HashMap<>();
        dev3.put("nama", "Budi Santoso");
        dev3.put("nim", "11223344");
        dev3.put("email", "budi.santoso@example.com");
        dev3.put("foto", "#");
        members.add(dev3);
        
        Map<String, String> dev4 = new HashMap<>();
        dev4.put("nama", "Budi Santoso");
        dev4.put("nim", "11223344");
        dev4.put("email", "budi.santoso@example.com");
        dev4.put("foto", "#");
        members.add(dev4);
        
        Map<String, String> dev5 = new HashMap<>();
        dev5.put("nama", "Budi Santoso");
        dev5.put("nim", "11223344");
        dev5.put("email", "budi.santoso@example.com");
        dev5.put("foto", "#");
        members.add(dev5);
    %>

    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-8">
        <% for (Map<String, String> dev : members) { %>
            <div class="group relative bg-white/5 backdrop-blur-sm rounded-3xl p-1 border border-white/10 shadow-2xl transition-all duration-500 hover:-translate-y-2 hover:shadow-indigo-500/20">

                <div class="absolute inset-0 bg-gradient-to-br from-indigo-600/20 to-purple-600/20 rounded-3xl opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>

                <div class="relative bg-slate-900/40 rounded-[22px] overflow-hidden">
                    <div class="relative h-48 overflow-hidden">
                        <% if (!"#".equals(dev.get("foto"))) { %>
                            <img src="<%= dev.get("foto") %>" 
                                 class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110">
                        <% } else { %>
                            <div class="w-full h-full bg-gradient-to-tr from-indigo-600 to-violet-500 flex items-center justify-center">
                                <span class="text-5xl font-black text-white/30 tracking-tighter">
                                    <%= dev.get("nama").substring(0, 1) %>
                                </span>
                            </div>
                        <% } %>

                        <div class="absolute inset-0 bg-gradient-to-t from-slate-900 via-transparent to-transparent opacity-60"></div>
                    </div>

                    <div class="p-6 text-center relative">
                        <h3 class="font-bold text-white text-lg tracking-tight group-hover:text-indigo-400 transition-colors">
                            <%= dev.get("nama") %>
                        </h3>
                        <div class="inline-block mt-1 px-3 py-1 rounded-full bg-indigo-500/10 border border-indigo-500/20">
                            <p class="text-[10px] font-bold text-indigo-400 uppercase tracking-widest">
                                <%= dev.get("nim") %>
                            </p>
                        </div>

                        <div class="mt-4 pt-4 border-t border-white/5 flex justify-center items-center gap-2">
                            <i class="fas fa-envelope text-[10px] text-gray-500"></i>
                            <p class="text-[10px] text-gray-400 font-medium truncate">
                                <%= dev.get("email") %>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        <% } %>
    </div>
</div>