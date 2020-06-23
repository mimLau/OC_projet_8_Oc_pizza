package org.oc.escalade.consumers.impl.jpa;

import org.oc.escalade.consumers.PlaceDao;
import org.oc.escalade.models.Place;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

public class JpaPlaceDao implements PlaceDao {
    private EntityManagerFactory emf;

    public JpaPlaceDao(EntityManagerFactory emf){
        this.emf=emf;
    }
    @Override
    public Place addPlace(Place place) {
        final EntityManager em = emf.createEntityManager();
        EntityTransaction t = em.getTransaction();
        try {
            t.begin();
            em.persist(place);
            t.commit();
        }finally {
            if(t.isActive()) t.rollback();
        }
        return place;
    }

    @Override
    public Place findPlaceByCountryAndRegion(String country, String region) {
        final EntityManager em = emf.createEntityManager();
        Place placeByCountryAndRegion = new Place();

        try {
            Query query = em.createQuery("SELECT p FROM Place AS p WHERE p.country= :country AND p.region= :region");
            query.setParameter("country" , country);
            query.setParameter("region", region);
           try {
               placeByCountryAndRegion = ( Place ) query.getSingleResult();
           } catch (NoResultException e){
               placeByCountryAndRegion = null;
           }
        } finally {
            em.close();
        }

        return placeByCountryAndRegion;
    }

    @Override
    public List<String> getAllDistinctCountries() {
        final EntityManager em = emf.createEntityManager();
        List <String> countries = new ArrayList<>();

        try {
            Query query = em.createQuery("SELECT DISTINCT (p.country)  FROM Place AS p");
            countries = (List<String>) query.getResultList();

        } finally {
            em.close();
        }

        return countries;
    }

    @Override
    public List<Place> getPlaceByCountryName(String country) {
        final EntityManager em = emf.createEntityManager();
        List<Place> places = new ArrayList<>();

        try {
            Query query = em.createQuery("SELECT p FROM Place AS p WHERE p.country= :country");
            query.setParameter("country", country);
            places = (List<Place>) query.getResultList();
        } finally {
            em.close();
        }
        return places;
    }

    @Override
    public Place getPlaceByRegionName(String region) {
        final EntityManager em = emf.createEntityManager();
        Place place = new Place();

        try {
            Query query = em.createQuery("SELECT p FROM Place AS p WHERE p.region= :region");
            query.setParameter("region", region);
            place = (Place) query.getSingleResult();

        } finally {
            em.close();
        }
        return place;
    }
}
