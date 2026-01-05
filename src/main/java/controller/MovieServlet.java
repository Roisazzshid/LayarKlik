package controller;

import dao.MoviesDAO;
import model.Movies;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/MovieServlet")
public class MovieServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String action = request.getParameter("action");
        MoviesDAO mDao = new MoviesDAO();

        if ("add".equals(action)) {
            Movies m = new Movies();
            m.setTitle(request.getParameter("title"));
            m.setGenre(request.getParameter("genre"));
            m.setSynopsis(request.getParameter("synopsis"));
            m.setDurationMinutes(Integer.parseInt(request.getParameter("duration")));
            m.setBasePrice((int) Double.parseDouble(request.getParameter("base_price"))); // Ambil harga
            // Parsing tanggal rilis
            String releaseDateStr = request.getParameter("release_date");
            m.setReleaseDate(java.sql.Date.valueOf(releaseDateStr)); 
            m.setRatingScore(4.0); // Berikan nilai default rating (misal 4.0) agar lolos Check Constraint

            mDao.addMovie(m);
        } else if ("edit".equals(action)) {
            Movies m = new Movies();
            m.setId(Integer.parseInt(request.getParameter("id"))); // ID tersembunyi
            m.setTitle(request.getParameter("title"));
            m.setGenre(request.getParameter("genre"));
            m.setSynopsis(request.getParameter("synopsis"));
            m.setDurationMinutes(Integer.parseInt(request.getParameter("duration")));
            m.setBasePrice(Integer.parseInt(request.getParameter("base_price")));
            m.setRatingScore(4.0); 

            String releaseDateStr = request.getParameter("release_date");
            if (releaseDateStr != null && !releaseDateStr.isEmpty()) {
                m.setReleaseDate(java.sql.Date.valueOf(releaseDateStr));
            }

            mDao.updateMovie(m);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            mDao.deleteMovie(id);
        }

        response.sendRedirect("admin.jsp?page=movies");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}