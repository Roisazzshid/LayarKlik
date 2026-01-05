package controller;

import dao.ScheduleDAO;
import model.Schedules;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ScheduleServlet")
public class ScheduleServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        ScheduleDAO sDao = new ScheduleDAO();

        if ("add".equals(action)) {
            Schedules s = new Schedules();
            s.setMovieId(Integer.parseInt(request.getParameter("movie_id")));
            s.setStudioId(Integer.parseInt(request.getParameter("studio_id")));
            s.setShowDate(Date.valueOf(request.getParameter("show_date")));
            s.setShowTime(Time.valueOf(request.getParameter("show_time") + ":00"));
            s.setPrice(Double.parseDouble(request.getParameter("price")));
            
            sDao.addSchedule(s);
        }
        
        response.sendRedirect("admin.jsp?page=schedules");
    }
}