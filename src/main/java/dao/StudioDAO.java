/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import util.KoneksiDB;
import model.Studios;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author USER
 */
public class StudioDAO {
    // Simpan Studio Baru
    public void insert(Studios studio) throws SQLException {
        String sql = "INSERT INTO studios (cinema_id, name) VALUES (?, ?)";
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studio.getCinemaId());
            ps.setString(2, studio.getName());
            ps.executeUpdate();
        }
    }

    // 2. Ambil Semua Studio berdasarkan ID Cinema
    public List<Studios> getByCinemaId(int cinemaId) throws SQLException {
        List<Studios> list = new ArrayList<>();
        String sql = "SELECT * FROM studios WHERE cinema_id = ? ORDER BY name ASC";
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cinemaId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Studios(
                        rs.getInt("studio_id"),
                        rs.getInt("cinema_id"),
                        rs.getString("name"),
                        rs.getString("studio_type")
                    ));
                }
            }
        }
        return list;
    }
    
    // Hapus Studio
    public void delete(int studioId) throws SQLException {
        String sql = "DELETE FROM studios WHERE studio_id = ?";
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studioId);
            ps.executeUpdate();
        }
    }
}
