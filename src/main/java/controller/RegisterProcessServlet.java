package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.Users;
import dao.UserDAO;

@WebServlet("/RegisterProcessServlet")
public class RegisterProcessServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Ambil data dari form register.jsp
        String nama = request.getParameter("nama");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Bungkus dalam objek Model
        Users newUser = new Users();
        newUser.setNama(nama);
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(password);

        UserDAO uDao = new UserDAO();
        
        if (uDao.register(newUser)) {
            // Jika berhasil, arahkan ke login dengan pesan sukses
            response.sendRedirect("login.jsp?status=reg_success");
        } else {
            // Jika gagal (misal username sudah ada), kembali ke register dengan pesan error
            response.sendRedirect("register.jsp?error=reg_failed");
        }
    }
}