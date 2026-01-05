/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author USER
 */
public class Tim {
    private final String nama;
    private final String email;
    private final String nim;
    private final String foto;

    public Tim(String nama, String email, String nim, String foto) {
        this.nama = nama;
        this.email = email;
        this.nim = nim;
        this.foto = foto;
    }

    // Getter (Penting agar JSP bisa membaca datanya)
    public String getNama() { return nama; }
    public String getEmail() { return email; }
    public String getNim() { return nim; }
    public String getFoto() { return foto; }
}
