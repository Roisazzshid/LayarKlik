/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import util.KoneksiDB;
import model.Cinemas;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author USER
 */
public class CinemaDAO {
    public List<Cinemas> getAll() {
        List<Cinemas> list = new ArrayList<>();
        // Gunakan query sederhana untuk memastikan koneksi lancar
        String sql = "SELECT * FROM cinemas ORDER BY cinema_id ASC";

        try (Connection conn = KoneksiDB.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Cinemas cin = new Cinemas();
                // Ambil data sesuai nama kolom di psql kamu
                cin.setCinemaId(rs.getInt("cinema_id"));
                cin.setName(rs.getString("name"));
                cin.setAddress(rs.getString("address"));
                cin.setCity(rs.getString("city"));
                // Jika cinema_type null di baris pertama (Grand Indonesia Mall), 
                // berikan nilai default agar tidak error saat dipanggil di JSP
                String type = rs.getString("cinema_type");
                cin.setCinemaType(type == null ? "REGULAR" : type);

                list.add(cin);
            }
        } catch (Exception e) {
            System.err.println("Gagal memuat data cinema: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
    
    public int getTotalCinemas() {
        String sql = "SELECT COUNT(*) FROM cinemas";
        try (Connection c = KoneksiDB.getConnection(); 
             Statement s = c.createStatement(); 
             ResultSet r = s.executeQuery(sql)) {
            if (r.next()) return r.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public void addCinema(Cinemas c) {
        String sql = "INSERT INTO cinemas (name, address, city, cinema_type) VALUES (?, ?, ?, ?)";
        try (Connection conn = KoneksiDB.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getName());
            ps.setString(2, c.getAddress()); // Perbaikan indeks ke-2
            ps.setString(3, c.getCity());    // Perbaikan indeks ke-3
            ps.setString(4, c.getCinemaType()); // Perbaikan indeks ke-4
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteCinema(int id) {
        String sql = "DELETE FROM cinemas WHERE cinema_id = ?";
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCinema(Cinemas c) {
        String sql = "UPDATE cinemas SET name=?, address=?, city=?, cinema_type=? WHERE cinema_id=?";
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getName());
            ps.setString(2, c.getAddress());
            ps.setString(3, c.getCity());
            ps.setString(4, c.getCinemaType());
            ps.setInt(5, c.getCinemaId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
