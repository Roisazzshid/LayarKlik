<%@ page import="java.util.*" %>

<!-- Section Endorsement Brands -->
<div class="max-w-7xl mx-auto px-4 py-8">
    
    <%
        List<Map<String, String>> brands = new ArrayList<>();
        
        // Contoh data lokal untuk brand 1
        Map<String, String> brand1 = new HashMap<>();
        brand1.put("nama", "Google");
        brand1.put("logo", "images/google-logo.png");
        brands.add(brand1);
        
        // Contoh data lokal untuk brand 2
        Map<String, String> brand2 = new HashMap<>();
        brand2.put("nama", "Microsoft");
        brand2.put("logo", "images/microsoft-logo.png");
        brands.add(brand2);
        
        // Contoh data lokal untuk brand 3
        Map<String, String> brand3 = new HashMap<>();
        brand3.put("nama", "Apple");
        brand3.put("logo", "images/apple-logo.png");
        brands.add(brand3);
        
        // Contoh data lokal untuk brand 4
        Map<String, String> brand4 = new HashMap<>();
        brand4.put("nama", "Amazon");
        brand4.put("logo", "images/amazon-logo.png");
        brands.add(brand4);
        
        // Contoh data lokal untuk brand 5
        Map<String, String> brand5 = new HashMap<>();
        brand5.put("nama", "Facebook");
        brand5.put("logo", "images/facebook-logo.png");
        brands.add(brand5);
        
        // Tambahkan lebih banyak brand sesuai kebutuhan
    %>
    
    <div class="grid grid-cols-3 sm:grid-cols-4 md:grid-cols-5 lg:grid-cols-6 xl:grid-cols-8 gap-4 justify-center">
        <% for (Map<String, String> brand : brands) { %>
            <div class="flex items-center justify-center p-2 bg-white rounded-lg shadow-sm border border-gray-200 hover:shadow-md transition-shadow duration-200">
                <img src="<%= brand.get("#") %>" alt="" class="h-8 w-auto object-contain">
            </div>
        <% } %>
    </div>
</div>