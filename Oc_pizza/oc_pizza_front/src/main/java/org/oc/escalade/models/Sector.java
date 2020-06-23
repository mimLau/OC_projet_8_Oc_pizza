package org.oc.escalade.models;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "sectors")
public class Sector {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String name;
    private int nbOfWays;

    @ManyToOne
    @JoinColumn(name="site_fk")
    private Site site;

    @OneToMany(mappedBy = "sector")
    private List<Way> ways;


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

    public int getNbOfWays() {
        return nbOfWays;
    }

    public void setNbOfWays(int nbOfWays) {
        this.nbOfWays = nbOfWays;
    }

    public Site getSite() {
        return site;
    }

    public void setSite(Site site) {
        this.site = site;
    }

    public List<Way> getWays() {
        return ways;
    }

    public void setWays(List<Way> ways) {
        this.ways = ways;
    }
}
