package controller;

import dao.MoviesDAO;
import java.io.File;
import model.Movies;
import java.io.IOException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/MovieServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
    maxFileSize = 1024 * 1024 * 2,      // 2MB
    maxRequestSize = 1024 * 1024 * 10   // 10MB
)
public class MovieServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String action = request.getParameter("action");
        MoviesDAO mDao = new MoviesDAO();

        // Gabungkan semua logika add dan edit di sini
        if ("add".equals(action) || "edit".equals(action)) {
            Movies m = new Movies();
            
            if ("edit".equals(action)) {
                m.setId(Integer.parseInt(request.getParameter("id")));
            }
            
            m.setTitle(request.getParameter("title"));
            m.setGenre(request.getParameter("genre"));
            m.setSynopsis(request.getParameter("synopsis"));
            m.setDurationMinutes(Integer.parseInt(request.getParameter("duration")));
            m.setBasePrice((int) Double.parseDouble(request.getParameter("base_price")));
            m.setReleaseDate(java.sql.Date.valueOf(request.getParameter("release_date")));
            m.setRatingScore(4.0);

            // LOGIKA UPLOAD FILE
            Part filePart = request.getPart("poster"); 
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = UUID.randomUUID().toString() + "_" + filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("/") + "images" + File.separator + "poster";
                
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                filePart.write(uploadPath + File.separator + fileName);
                m.setPoster(fileName); 
            } else if ("edit".equals(action)) {
                // Ambil poster lama jika tidak ganti gambar
                m.setPoster(request.getParameter("old_poster"));
            }

            if ("add".equals(action)) {
                mDao.addMovie(m);
            } else {
                mDao.updateMovie(m);
            }

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