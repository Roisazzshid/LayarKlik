package controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import util.KoneksiDB;
import model.Users;

@WebServlet("/DeleteBookingServlet")
public class DeleteBookingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        String bookingId = request.getParameter("id");

        if (user != null && bookingId != null) {
            try (Connection conn = KoneksiDB.getConnection()) {
                // Pastikan user hanya bisa menghapus bookingannya sendiri
                String sql = "DELETE FROM bookings WHERE booking_id = ? AND user_id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(bookingId));
                ps.setInt(2, user.getId());
                
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        // Kembali ke halaman my_bookings dengan pesan sukses
        response.sendRedirect("myBookings.jsp?msg=deleted");
    }
}