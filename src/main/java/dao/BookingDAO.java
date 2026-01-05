/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.*;
import model.Bookings;
import util.KoneksiDB;
/**
 *
 * @author USER
 */
public class BookingDAO {
    public List<Map<String, Object>> getByUserId(int userId) {
        List<Map<String, Object>> list = new ArrayList<>();
        // QUERY DENGAN JOIN KE SCHEDULES & STUDIOS
        String sql = "SELECT b.*, m.title as movie_title, c.name as cinema_name, " +
                 "s.show_date, s.show_time, st.name as studio_name " +
                 "FROM bookings b " +
                 "LEFT JOIN schedules s ON b.schedule_id = s.schedule_id " +
                 "LEFT JOIN movies m ON b.movie_id = m.movie_id " +
                 "LEFT JOIN cinemas c ON b.cinema_id = c.cinema_id " +
                 "LEFT JOIN studios st ON s.studio_id = st.studio_id " +
                 "WHERE b.user_id = ? ORDER BY b.created_at DESC";

        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("booking_id", rs.getInt("booking_id"));
                    map.put("movie_title", rs.getString("movie_title"));
                    map.put("cinema_name", rs.getString("cinema_name"));
                    map.put("studio_name", rs.getString("studio_name"));
                    map.put("show_date", rs.getDate("show_date"));
                    map.put("show_time", rs.getTime("show_time"));
                    map.put("seat_numbers", rs.getString("seat_numbers"));
                    map.put("total_price", rs.getDouble("total_price"));
                    map.put("status", rs.getString("status"));
                    map.put("created_at", rs.getTimestamp("created_at"));
                    list.add(map);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
