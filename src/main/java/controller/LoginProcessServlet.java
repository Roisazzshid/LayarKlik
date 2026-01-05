package controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.Users;
import util.KoneksiDB;

@WebServlet("/LoginProcessServlet")
public class LoginProcessServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userParam = request.getParameter("username");
        String passParam = request.getParameter("password");
        HttpSession session = request.getSession();

        try (Connection conn = KoneksiDB.getConnection()) {
            String sql = "SELECT * FROM users WHERE (username = ? OR email = ?) AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userParam); // dari input text
            ps.setString(2, userParam); // dari input text yang sama
            ps.setString(3, passParam); // dari input password
            
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Buat objek user untuk disimpan di session
                Users user = new Users();
                user.setId(rs.getInt("user_id")); // Pastikan nama kolom sesuai DB psql kamu
                user.setUsername(rs.getString("username"));
                user.setNama(rs.getString("nama"));
                user.setRole(rs.getString("role"));

                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());

                // Cek apakah ada redirect tertunda (dari booking gate)
                if ("admin".equals(user.getRole())) {
                    response.sendRedirect("admin.jsp");
                } else {
                    // Jika user biasa, cek apakah ada hutang halaman booking
                    String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
                    if (redirectUrl != null) {
                        session.removeAttribute("redirectAfterLogin");
                        response.sendRedirect(redirectUrl);
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                }
            } else {
                response.sendRedirect("login.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=db");
        }
    }
}