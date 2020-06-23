package org.oc.escalade.models;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name="sites")
public class Site {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String name;
    private String description;
    private int nbOfSectors;

    @Type(type="numeric_boolean")
    private boolean tagged;

    @ManyToOne
    @JoinColumn(name="user_fk")
    private User siteOwner;

    @ManyToOne
    @JoinColumn(name = "place_fk")
    private Place place;

    @OneToMany(mappedBy = "site")
    private List<Sector> sectors;

    @OneToMany(mappedBy = "siteComment")
    private List<Comment> comments;

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

    public int getnbOfSectors() {
        return nbOfSectors;
    }

    public void setnbOfSectors(int nbOfSectors) {
        this.nbOfSectors = nbOfSectors;
    }

    public boolean isTagged() {
        return tagged;
    }

    public void setTagged(boolean tagged) {
        this.tagged = tagged;
    }

    public User getSiteOwner() {
        return siteOwner;
    }

    public void setSiteOwner(User siteOwner) {
        this.siteOwner = siteOwner;
    }

    public Place getPlace() {
        return place;
    }

    public void setPlace(Place place) {
        this.place = place;
    }

    public int getNbOfSectors() {
        return nbOfSectors;
    }

    public void setNbOfSectors(int nbOfSectors) {
        this.nbOfSectors = nbOfSectors;
    }

    public List<Sector> getSectors() {
        return sectors;
    }

    public void setSectors(List<Sector> sectors) {
        this.sectors = sectors;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }
}
