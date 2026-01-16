package controller;

import dao.UserDAO;
import model.Users;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        UserDAO uDao = new UserDAO();

        // Logika HAPUS User
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            uDao.deleteUser(id);
        }
        
        // Kembalikan ke halaman kelola pengguna
        response.sendRedirect("admin.jsp?page=users");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        UserDAO uDao = new UserDAO();

        // Logika UPDATE User
        if ("update".equals(action)) {
            Users u = new Users();
            u.setId(Integer.parseInt(request.getParameter("id")));
            u.setNama(request.getParameter("nama"));
            u.setUsername(request.getParameter("username"));
            u.setEmail(request.getParameter("email"));
            u.setRole(request.getParameter("role"));
            
            // Logika ganti password (Hanya diupdate jika admin mengisi input password)
            String newPassword = request.getParameter("password");
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                u.setPassword(newPassword);
            } else {
                // Jika kosong, ambil password lama dari database agar tidak menjadi null
                Users oldUser = uDao.getById(u.getId());
                u.setPassword(oldUser.getPassword());
            }

            uDao.updateUser(u);
        }

        response.sendRedirect("admin.jsp?page=users");
    }
}