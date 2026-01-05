package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Users;
import util.KoneksiDB;

public class UserDAO {

    // 1. Logika Login (Email atau Username)
    public Users login(String loginIdentifier, String password) {
        // Query ini memungkinkan user login menggunakan username ATAU email
        String sql = "SELECT * FROM users WHERE (username = ? OR email = ?) AND password = ?";
        
        try (Connection c = KoneksiDB.getConnection(); 
             PreparedStatement ps = c.prepareStatement(sql)) {
            
            ps.setString(1, loginIdentifier);
            ps.setString(2, loginIdentifier);
            ps.setString(3, password);
            
            try (ResultSet r = ps.executeQuery()) {
                if (r.next()) {
                    Users u = new Users();
                    u.setId(r.getInt("id"));
                    u.setUsername(r.getString("username"));
                    u.setEmail(r.getString("email"));
                    u.setNama(r.getString("nama"));
                    u.setRole(r.getString("role"));
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 2. Logika Registrasi User Baru
    public boolean register(Users user) {
        // Query disesuaikan dengan kolom yang kita buat tadi (termasuk 'nama' dan 'role')
        String sql = "INSERT INTO users (username, password, nama, email, role) VALUES (?, ?, ?, ?, 'user')";
        
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getNama());
            ps.setString(4, user.getEmail());
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.out.println("Error Register: " + e.getMessage());
            return false;
        }
    }

    // Method getAll tetap sama...
    public List<Users> getAll() {
        List<Users> list = new ArrayList<>();
        // Pastikan menggunakan user_id, bukan id
        String sql = "SELECT * FROM users ORDER BY user_id ASC"; 

        try (Connection conn = KoneksiDB.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Users u = new Users();
                // Ambil data dengan nama kolom yang benar sesuai database
                u.setId(rs.getInt("user_id")); 
                u.setUsername(rs.getString("username"));
                u.setNama(rs.getString("nama"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getString("role"));
                list.add(u);
            }
        } catch (SQLException e) {
            System.out.println("Error UserDAO getAll: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
    
    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection c = KoneksiDB.getConnection(); 
             Statement s = c.createStatement(); 
             ResultSet r = s.executeQuery(sql)) {
            if (r.next()) return r.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
}