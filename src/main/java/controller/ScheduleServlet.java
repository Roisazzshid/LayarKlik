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

        if ("add".equals(action) || "update".equals(action)) {
            Schedules s = new Schedules();
            
            // Jika update, ambil ID-nya
            if ("update".equals(action)) {
                s.setScheduleId(Integer.parseInt(request.getParameter("id")));
            }
            
            s.setMovieId(Integer.parseInt(request.getParameter("movie_id")));
            s.setStudioId(Integer.parseInt(request.getParameter("studio_id")));
            s.setShowDate(Date.valueOf(request.getParameter("show_date")));
            
            // Tambahkan :00 jika input time hanya HH:mm agar sesuai format SQL Time
            String timeInput = request.getParameter("show_time");
            if (timeInput.length() == 5) timeInput += ":00"; 
            s.setShowTime(Time.valueOf(timeInput));
            
            s.setPrice(Double.parseDouble(request.getParameter("price")));
            
            if ("add".equals(action)) {
                sDao.addSchedule(s);
            } else {
                sDao.updateSchedule(s);
            }
        }
        
        response.sendRedirect("admin.jsp?page=schedules");
    }
}