package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Ambil session yang ada, jangan buat baru (false)
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Menghapus semua data di dalam session (termasuk user dan userId)
            session.invalidate(); 
        }
        
        // Alihkan kembali ke halaman utama setelah logout
        response.sendRedirect("index.jsp");
    }
}