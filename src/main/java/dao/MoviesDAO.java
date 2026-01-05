/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author USER
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Movies;
import util.KoneksiDB;

public class MoviesDAO {
    // Mengambil semua data film
    public List<Movies> getAll() {
        List<Movies> movies = new ArrayList<>();
    String sql = "SELECT * FROM movies ORDER BY rating_score DESC";

    // We split the connection check to avoid the NullPointerException crash
    try {
        Connection c = KoneksiDB.getConnection();
        
        if (c == null) {
            System.err.println("CRITICAL: KoneksiDB.getConnection() returned NULL. Check your database settings.");
            return movies; // Return empty list instead of crashing
        }

        try (Statement s = c.createStatement(); 
             ResultSet r = s.executeQuery(sql)) {

            while (r.next()) {
                Movies movie = new Movies();
                movie.setId(r.getInt("movie_id"));
                movie.setTitle(r.getString("title"));
                movie.setGenre(r.getString("genre"));
                movie.setDurationMinutes(r.getInt("duration_minutes"));
                movie.setRatingScore(r.getDouble("rating_score"));
                movie.setBasePrice(r.getInt("base_price"));
                movie.setSynopsis(r.getString("synopsis"));
                movie.setPoster(r.getString("poster"));
                movies.add(movie);
            }
        }
        c.close(); // Remember to close if not using try-with-resources for 'c'
    } catch (SQLException e) {
        // THIS IS IMPORTANT: Now you will see the actual DB error in the logs
        System.out.println("Error Query: " + e.getMessage()); // Ini akan memunculkan pesan error di console
    }
    return movies;
    }
    
    public Movies getById(int id) {
        Movies movie = null;
        String sql = "SELECT * FROM movies WHERE movie_id = ?";
        try (Connection c = KoneksiDB.getConnection()) {
            if (c != null) {
                try (PreparedStatement ps = c.prepareStatement(sql)) {
                    ps.setInt(1, id);
                    try (ResultSet r = ps.executeQuery()) {
                        if (r.next()) {
                            movie = new Movies();
                            movie.setId(r.getInt("movie_id"));
                            movie.setTitle(r.getString("title"));
                            movie.setGenre(r.getString("genre"));
                            movie.setDurationMinutes(r.getInt("duration_minutes"));
                            movie.setRatingScore(r.getDouble("rating_score"));
                            movie.setBasePrice(r.getInt("base_price"));
                            movie.setSynopsis(r.getString("synopsis"));
                            movie.setPoster(r.getString("poster"));
                        }
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("Error getById: " + e.getMessage());
        }
        return movie;
    }
    
    // Tambahkan di dalam class MoviesDAO
    public boolean addMovie(Movies m) {
        String sql = "INSERT INTO movies (title, genre, duration_minutes, release_date, rating_score, base_price, synopsis, poster) " +
                 "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getTitle());      // Judul
            ps.setString(2, m.getGenre());      // Genre
            ps.setInt(3, m.getDurationMinutes()); // Durasi
            ps.setDate(4, m.getReleaseDate());   // Tanggal Rilis (Diambil dari model)
            ps.setDouble(5, 4.5);               // Rating Score (Default)
            ps.setDouble(6, (double) m.getBasePrice()); // Harga Dasar
            ps.setString(7, m.getSynopsis());
            ps.setString(8, m.getPoster());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
    
    public boolean updateMovie(Movies m) {
        String sql = "UPDATE movies SET title=?, genre=?, duration_minutes=?, release_date=?, base_price=?, synopsis=? WHERE movie_id=?";
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, m.getTitle());
            ps.setString(2, m.getGenre());
            ps.setInt(3, m.getDurationMinutes());
            ps.setDate(4, m.getReleaseDate());
            ps.setDouble(5, (double) m.getBasePrice());
            ps.setString(6, m.getSynopsis());
            ps.setString(8, m.getPoster());
            ps.setInt(7, m.getId()); // ID film yang akan diubah

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteMovie(int id) {
        String sql = "DELETE FROM movies WHERE movie_id = ?";
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
    
    public int getTotalMovies() {
        String sql = "SELECT COUNT(*) FROM movies";
        try (Connection c = KoneksiDB.getConnection(); 
             Statement s = c.createStatement(); 
             ResultSet r = s.executeQuery(sql)) {
            if (r.next()) return r.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    public List<Movies> searchMovies(String keyword) {
        List<Movies> list = new ArrayList<>();
        // ILIKE digunakan di PostgreSQL agar pencarian tidak sensitif huruf besar/kecil
        String sql = "SELECT * FROM movies WHERE title ILIKE ? OR genre ILIKE ?";

        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String searchKey = "%" + keyword + "%";
            ps.setString(1, searchKey);
            ps.setString(2, searchKey);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Movies m = new Movies();
                    m.setId(rs.getInt("movie_id"));
                    m.setTitle(rs.getString("title"));
                    m.setGenre(rs.getString("genre"));
                    m.setPoster(rs.getString("poster"));
                    // ... set field lainnya ...
                    list.add(m);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
