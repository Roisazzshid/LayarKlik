package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class KoneksiDB {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // WAJIB: Tambahkan baris ini untuk mendaftarkan driver
            Class.forName("org.postgresql.Driver"); 
            
            String url = "jdbc:postgresql://localhost:5432/db_bioskop";
            String user = "postgres";
            String pass = "roisazzamshiddiq3";
            conn = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException e) {
            System.err.println("Driver tidak ditemukan: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Koneksi gagal: " + e.getMessage());
        }
        return conn;
    }
}