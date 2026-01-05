<%@page import="dao.MoviesDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.Movies"%>
<%@page import="java.sql.Connection"%>

<%
    try {
        Class.forName("org.postgresql.Driver");
        //out.println("<b>Driver PostgreSQL TERLOAD</b><br>");
    } catch (Exception e) {
        out.println("<b>Driver PostgreSQL TIDAK TERLOAD</b><br>");
    }

    MoviesDAO dao = new MoviesDAO();
    List<Movies> daftarMovies = dao.getAll();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Daftar Film Bioskop</title>
</head>
<body>

<div class="header-bg text-center mb-4">
    <h1>Cinema XXI - Sekarang Tayang</h1>
</div>

<div class="container">
    <div class="table-responsive">
        <table class="table table-hover table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Judul Film</th>
                    <th>Genre</th>
                    <th>Durasi</th>
                    <th>Rating</th>
                    <th>Harga Tiket</th>
                    <th>Sinopsis</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Movies m : daftarMovies) {
                %>
                <tr>
                    <td><%= m.getTitle()%></td>
                    <td><%= m.getGenre()%></td>
                    <td><%= m.getDurationMinutes()%> Menit</td>
                    <td><%= m.getRatingScore()%></td>
                    <td><%= m.getBasePrice()%></td>
                    <td><p><%= m.getSynopsis()%></p></td>
                </tr>
                <% 
                    } // Penutup loop for yang tadi hilang
                %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>