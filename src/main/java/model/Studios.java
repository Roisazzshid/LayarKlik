/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author USER
 */
public class Studios {
    private int studioId;
    private int cinemaId;
    private String name;
    private String studioType; // Misal: 2D, Premiere, IMAX

    public Studios() {}
    
    public Studios(int studioId, int cinemaId, String name, String studioType) {
        this.studioId = studioId;
        this.cinemaId = cinemaId;
        this.name = name;
        this.studioType = studioType;
    }

    public int getStudioId() {
        return studioId;
    }

    public void setStudioId(int studioId) {
        this.studioId = studioId;
    }

    public int getCinemaId() {
        return cinemaId;
    }

    public void setCinemaId(int cinemaId) {
        this.cinemaId = cinemaId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return studioType;
    }

    public void setType(String type) {
        this.studioType = type;
    }
    
    
}
