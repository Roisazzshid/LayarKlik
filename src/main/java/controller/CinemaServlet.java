package controller;

import dao.CinemaDAO;
import model.Cinemas;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CinemaServlet")
public class CinemaServlet extends HttpServlet {
    private CinemaDAO cDao = new CinemaDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("add".equals(action) || "update".equals(action)) {
            Cinemas c = new Cinemas();
            c.setName(request.getParameter("name"));
            c.setAddress(request.getParameter("address"));
            c.setCity(request.getParameter("city"));
            c.setCinemaType(request.getParameter("type"));

            if ("add".equals(action)) {
                cDao.addCinema(c);
            } else {
                c.setCinemaId(Integer.parseInt(request.getParameter("id")));
                cDao.updateCinema(c);
            }
        }
        response.sendRedirect("admin.jsp?page=cinemas");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            cDao.deleteCinema(id);
        }
        response.sendRedirect("admin.jsp?page=cinemas");
    }
}