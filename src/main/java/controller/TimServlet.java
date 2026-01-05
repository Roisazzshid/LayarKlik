package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Tim; // Pastikan package model kamu benar

@WebServlet("/TimServlet")
public class TimServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Siapkan Data
        List<Tim> memberData = new ArrayList<>();
        memberData.add(new Tim("Rois Azzam Shiddiq", "isamiq3@gmail.com", "0110224156", "#"));
        memberData.add(new Tim("Nama Teman", "email@gmail.com", "0110224", "#"));
        memberData.add(new Tim("Nama Teman", "email@gmail.com", "0110224", "#"));
        memberData.add(new Tim("Nama Teman", "email@gmail.com", "0110224", "#"));
        memberData.add(new Tim("Nama Teman", "email@gmail.com", "0110224", "#"));
        
        // 2. Kirim data ke JSP
        request.setAttribute("members", memberData);
        
        // 3. Arahkan ke file JSP kamu (pastikan nama file .jsp nya benar)
        request.getRequestDispatcher("/component/tim.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Panggil doGet agar jika ada request POST, logic-nya tetap sama
        doGet(request, response);
    }
}