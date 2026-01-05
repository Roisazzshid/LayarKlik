package model;

import java.sql.Date; // Untuk show_date
import java.sql.Time; // Untuk show_time

public class Schedules {
    private int scheduleId;
    private int movieId;
    private int studioId;
    private Date showDate; // Tambahkan ini
    private Time showTime; // Tambahkan ini
    private double price;

    public Schedules() {}

    // Update Getter dan Setter
    public Date getShowDate() { return showDate; }
    public void setShowDate(Date showDate) { this.showDate = showDate; }

    public Time getShowTime() { return showTime; }
    public void setShowTime(Time showTime) { this.showTime = showTime; }
    
    // ... getter setter lainnya (id, movieId, studioId, price) ...

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public int getStudioId() {
        return studioId;
    }

    public void setStudioId(int studioId) {
        this.studioId = studioId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Schedules{" + "scheduleId=" + scheduleId + ", movieId=" + movieId + ", studioId=" + studioId + ", showDate=" + showDate + ", showTime=" + showTime + ", price=" + price + '}';
    }
    
}