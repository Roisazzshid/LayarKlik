package model;

/**
 *
 * @author USER
 */
public class Users {
    private int id;
    private String username;
    private String email;
    private String password;
    private String nama;
    private String role;
    
    // Constructor Kosong
    public Users() {
    }

    // Constructor Lengkap
    public Users(int id, String username,String email , String password, String nama, String role) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password;
        this.nama = nama;
        this.role = role;
    }

    // Getter dan Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNama() {
        return nama;
    }

    public void setNama(String nama) {
        this.nama = nama;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    // Override toString untuk mempermudah debugging jika diperlukan
    @Override
    public String toString() {
        return "Users{" + "id=" + id + ", username=" + username + ", email=" + email + ", password=" + password + ", nama=" + nama + ", role=" + role + '}';
    }
    
}