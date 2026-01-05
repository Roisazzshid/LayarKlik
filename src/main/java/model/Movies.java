/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author USER
 */
import java.math.BigDecimal;
import java.time.LocalDate;
import java.sql.Date;

public class Movies {
    private int id;
    private String title;
    private String genre;
    private int durationMinutes;
    private Date releaseDate;
    private double ratingScore; // Skala 1-5
    private int basePrice;
    private String synopsis;
    private String poster;

    // Constructors
    public Movies() {}

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public int getDurationMinutes() {
        return durationMinutes;
    }

    public void setDurationMinutes(int durationMinutes) {
        this.durationMinutes = durationMinutes;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public double getRatingScore() {
        return ratingScore;
    }

    public void setRatingScore(double ratingScore) {
        this.ratingScore = ratingScore;
    }

    public int getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(int basePrice) {
        this.basePrice = basePrice;
    }

    public String getSynopsis() {
        return synopsis;
    }

    public void setSynopsis(String synopsis) {
        this.synopsis = synopsis;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    @Override
    public String toString() {
        return "Movies{" + "id=" + id + ", title=" + title + ", genre=" + genre + ", durationMinutes=" + durationMinutes + ", releaseDate=" + releaseDate + ", ratingScore=" + ratingScore + ", basePrice=" + basePrice + ", synopsis=" + synopsis + ", poster=" + poster + '}';
    }
    
}
