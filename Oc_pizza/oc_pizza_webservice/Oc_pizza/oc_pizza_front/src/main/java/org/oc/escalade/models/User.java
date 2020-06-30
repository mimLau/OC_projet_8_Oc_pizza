package org.oc.escalade.models;

import javax.persistence.*;
import java.awt.print.Book;
import java.util.List;

@Entity
@Table(name="users")
public class User {

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long userId;
    private String firstname;
    private String lastname;
    private String username;
    private String email;
    private String password;
    private int nbOfConnections;

    @Enumerated(EnumType.STRING)
    private Role role;

    @OneToMany(mappedBy = "siteOwner")
    private List<Site> sites;

    @OneToMany(mappedBy = "commentOwner")
    private List<Comment> comments;

    @OneToMany(mappedBy = "topoOwner")
    private List<Topo> topos;

    @OneToMany(mappedBy = "userRequest")
    private List<Booking> bookingsReq;

    @OneToMany(mappedBy = "userLender")
    private List<Booking> bookingsLend;


    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
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

    public int getNbOfConnections() {
        return nbOfConnections;
    }

    public void setNbOfConnections(int nbOfConnections) {
        this.nbOfConnections = nbOfConnections;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public List<Site> getSites() {
        return sites;
    }

    public void setSites(List<Site> sites) {
        this.sites = sites;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public List<Topo> getTopos() {
        return topos;
    }

    public void setTopos(List<Topo> topos) {
        this.topos = topos;
    }

    public List<Booking> getBookingsReq() {
        return bookingsReq;
    }

    public void setBookingsReq(List<Booking> bookingsReq) {
        this.bookingsReq = bookingsReq;
    }

    public List<Booking> getBookingsLend() {
        return bookingsLend;
    }

    public void setBookingsLend(List<Booking> bookingsLend) {
        this.bookingsLend = bookingsLend;
    }
}
