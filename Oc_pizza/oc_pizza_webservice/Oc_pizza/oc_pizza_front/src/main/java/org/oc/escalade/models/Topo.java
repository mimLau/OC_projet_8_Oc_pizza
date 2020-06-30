package org.oc.escalade.models;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "topos")
public class Topo {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String name;
    private String description;
    private String releaseDate;

    @Type(type = "numeric_boolean")
    private boolean borrowed;

    @ManyToOne
    @JoinColumn(name = "user_fk")
    private User topoOwner;

    @OneToMany(mappedBy = "topo")
    private List<Booking> bookings;

    public Topo() {}

    public Topo(boolean borrowed) {
        this.borrowed = borrowed;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(String releaseDate) {
        this.releaseDate = releaseDate;
    }

    public boolean isBorrowed() {
        return borrowed;
    }

    public void setBorrowed(boolean borrowed) {
        this.borrowed = borrowed;
    }

    public User getTopoOwner() {
        return topoOwner;
    }

    public void setTopoOwner(User topoOwner) {
        this.topoOwner = topoOwner;
    }

    public List<Booking> getBookings() {
        return bookings;
    }

    public void setBookings(List<Booking> bookings) {
        this.bookings = bookings;
    }
}
