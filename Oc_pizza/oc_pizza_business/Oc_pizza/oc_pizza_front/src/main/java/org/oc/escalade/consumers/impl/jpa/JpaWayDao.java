package org.oc.escalade.consumers.impl.jpa;

import org.oc.escalade.consumers.WayDao;
import org.oc.escalade.models.Way;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

public class JpaWayDao implements WayDao {
  private EntityManagerFactory emf;

  public JpaWayDao(EntityManagerFactory emf) {
      this.emf = emf;
  }


    @Override
    public Way addWay(Way way) {
      final EntityManager em = emf.createEntityManager();
        EntityTransaction t = em.getTransaction();

        try {
            t.begin();
            em.persist(way);
            t.commit();
        } finally {
            if( t.isActive() ) t.rollback();
        }
        return way;
    }

    @Override
    public List<Way> getAllWays() {
        final EntityManager em = emf.createEntityManager();
        List<Way> allWays = new ArrayList<Way>();

        try {
            Query query = em.createQuery("SELECT w FROM Way as w");
            allWays = (List<Way>) query.getResultList();

        } finally {
            em.close();
        }

        return allWays;
    }

    @Override
    public Way findWayById( Long id ) {
        final EntityManager em = emf.createEntityManager();
        Way way = new Way();

        try {
            Query query = em.createQuery("SELECT w FROM Way AS w LEFT JOIN FETCH w.lengths WHERE w.id= :id");
            query.setParameter("id", id);
            way = ( Way) query.getSingleResult();
        } finally {
            em.close();
        }
        return way;
    }

    @Override
    public void updateNbOfLengths(Long id) {
        final EntityManager em = emf.createEntityManager();
        EntityTransaction t = em.getTransaction();

        try {
            t.begin();
            Query query = em.createQuery("UPDATE Way w SET w.nbOfLengths = w.nbOfLengths + :increment WHERE w.id= :id");
            query.setParameter("increment", 1);
            query.setParameter("id", id);

            query.executeUpdate();
            t.commit();
        }finally {
            if ( t.isActive() ) {
                t.rollback();
            }
            em.close();
        }
    }

    @Override
    public List<Way> findWaysByRating(String rating) {
        final EntityManager em = emf.createEntityManager();
        List<Way> ways = new ArrayList<Way>();

        try {
            Query query = em.createQuery("SELECT w FROM Way AS w WHERE w.rating= :rating");
            query.setParameter("rating", rating);
            ways = (List<Way>) query.getResultList();

        } catch (NoResultException noResultE) {
            ways = null;

        } finally {
            em.close();
        }
        return ways;
    }
}
