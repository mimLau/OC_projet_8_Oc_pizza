package org.oc.escalade.consumers.impl.jpa;

import org.oc.escalade.consumers.LengthDao;
import org.oc.escalade.models.Length;

import javax.persistence.*;
import java.util.List;

public class JpaLengthDao implements LengthDao {
        private EntityManagerFactory emf;

        public JpaLengthDao(EntityManagerFactory emf){
            this.emf=emf;
        }

        @Override
        public Length addLength(Length length) {
            final EntityManager em = emf.createEntityManager();
            EntityTransaction t = em.getTransaction();
            try {
                t.begin();
                em.persist(length);
                t.commit();
            }finally {
                if(t.isActive()) t.rollback();
            }
            return length;
        }

    @Override
    public Length findLengthById(Long id) {
        final EntityManager em = emf.createEntityManager();
        Length length = new Length();

        try {
            Query query = em.createQuery("SELECT l FROM Length AS l WHERE l.id= :id ");
            query.setParameter("id", id);
            try {
                length = ( Length) query.getSingleResult();
            } catch ( NoResultException noResultE ) {
                length = null;
            }

        } finally {
            em.close();
        }
        return length;
    }

    @Override
    public List<Length> findLengthsByRating(String rating) {
        final EntityManager em = emf.createEntityManager();
        List<Length> lengths;

        try {
            Query query = em.createQuery("SELECT l FROM Length AS l WHERE l.rating= :rating");
            query.setParameter("rating", rating);
            lengths = (List<Length>) query.getResultList();

        } catch (NoResultException noResultE) {
            lengths = null;

        } finally {
            em.close();
        }
        return lengths;
    }
}
