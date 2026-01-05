package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Schedules;
import util.KoneksiDB;

public class ScheduleDAO {

    // 1. Simpan Jadwal Baru ke Database
    public boolean addSchedule(Schedules s) {
        String sql = "INSERT INTO schedules (movie_id, studio_id, show_date, show_time, price) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, s.getMovieId());
            ps.setInt(2, s.getStudioId());
            ps.setDate(3, s.getShowDate());
            ps.setTime(4, s.getShowTime());
            ps.setDouble(5, s.getPrice());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. Ambil Semua Jadwal dengan Data JOIN (Untuk Tabel Admin)
    public List<Map<String, Object>> getAllSchedules() {
        List<Map<String, Object>> list = new ArrayList<>();
        // QUERY YANG BENAR: JOIN schedules -> studios -> cinemas
        String sql = "SELECT s.*, m.title, st.name as studio_name, c.name as cinema_name " +
                     "FROM schedules s " +
                     "JOIN movies m ON s.movie_id = m.movie_id " +
                     "JOIN studios st ON s.studio_id = st.studio_id " +
                     "JOIN cinemas c ON st.cinema_id = c.cinema_id " + // cinema_id diambil dari st (studios)
                     "ORDER BY s.show_date DESC, s.show_time ASC";

        try (Connection conn = KoneksiDB.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getInt("schedule_id"));
                row.put("movie_title", rs.getString("title"));
                row.put("studio_name", rs.getString("studio_name"));
                row.put("cinema_name", rs.getString("cinema_name"));
                row.put("date", rs.getDate("show_date"));
                row.put("time", rs.getTime("show_time"));
                row.put("price", rs.getDouble("price"));
                list.add(row);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return list;
    }

    // 3. Hapus Jadwal
    public boolean delete(int id) {
        String sql = "DELETE FROM schedules WHERE schedule_id = ?";
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Map<String, Object>> getAllSchedulesByMovie(int movieId) {
        List<Map<String, Object>> list = new ArrayList<>();
        // Query JOIN untuk mendapatkan detail jadwal berdasarkan ID Film tertentu
        String sql = "SELECT s.*, m.title as movie_title, st.name as studio_name, c.name as cinema_name " +
                     "FROM schedules s " +
                     "JOIN movies m ON s.movie_id = m.movie_id " +
                     "JOIN studios st ON s.studio_id = st.studio_id " +
                     "JOIN cinemas c ON st.cinema_id = c.cinema_id " +
                     "WHERE s.movie_id = ? " + // Filter berdasarkan film yang dipilih
                     "ORDER BY s.show_date ASC, s.show_time ASC";

        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, movieId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", rs.getInt("schedule_id"));
                    map.put("movie_title", rs.getString("movie_title"));
                    map.put("studio_name", rs.getString("studio_name"));
                    map.put("cinema_name", rs.getString("cinema_name"));
                    map.put("date", rs.getDate("show_date"));
                    map.put("time", rs.getTime("show_time"));
                    map.put("price", rs.getDouble("price"));
                    list.add(map);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Map<String, Object>> getSchedulesByMovieAndCinema(int movieId, int cinemaId) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT s.*, st.name as studio_name " +
                     "FROM schedules s " +
                     "JOIN studios st ON s.studio_id = st.studio_id " +
                     "WHERE s.movie_id = ? AND st.cinema_id = ? " +
                     "ORDER BY s.show_time ASC";

        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, movieId);
            ps.setInt(2, cinemaId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", rs.getInt("schedule_id"));
                    map.put("studio_name", rs.getString("studio_name"));
                    map.put("time", rs.getTime("show_time"));
                    map.put("price", rs.getDouble("price"));
                    list.add(map);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
    
    public Map<String, Object> getScheduleById(int id) {
        Map<String, Object> map = null;
        // Query JOIN lengkap untuk mengambil semua ID yang dibutuhkan tabel bookings
        String sql = "SELECT s.*, m.title, st.name as studio_name, c.cinema_id, c.name as cinema_name " +
                     "FROM schedules s " +
                     "JOIN movies m ON s.movie_id = m.movie_id " +
                     "JOIN studios st ON s.studio_id = st.studio_id " +
                     "JOIN cinemas c ON st.cinema_id = c.cinema_id " +
                     "WHERE s.schedule_id = ?";

        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    map = new HashMap<>();
                    map.put("id", rs.getInt("schedule_id"));
                    map.put("movie_id", rs.getInt("movie_id"));
                    map.put("movie_title", rs.getString("title"));
                    map.put("studio_id", rs.getInt("studio_id"));
                    map.put("studio_name", rs.getString("studio_name"));
                    map.put("cinema_id", rs.getInt("cinema_id")); // Penting untuk tabel bookings
                    map.put("cinema_name", rs.getString("cinema_name"));
                    map.put("price", rs.getDouble("price"));
                    map.put("date", rs.getDate("show_date"));
                    map.put("time", rs.getTime("show_time"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }
    
    public List<String> getTakenSeats(int scheduleId) {
        List<String> takenSeats = new ArrayList<>();
        String sql = "SELECT seat_numbers FROM bookings WHERE schedule_id = ?";

        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, scheduleId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String seatsString = rs.getString("seat_numbers");
                    if (seatsString != null) {
                        // Pecah string "A1, A2" menjadi array ["A1", "A2"]
                        String[] parts = seatsString.split(", ");
                        for (String s : parts) {
                            takenSeats.add(s.trim());
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return takenSeats;
    }
    
    public int getTotalSchedules() {
        String sql = "SELECT COUNT(*) FROM schedules";
        try (Connection c = util.KoneksiDB.getConnection(); 
             Statement s = c.createStatement(); 
             ResultSet r = s.executeQuery(sql)) {
            if (r.next()) return r.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
}