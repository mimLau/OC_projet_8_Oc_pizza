package org.oc.escalade.consumers.impl.jpa;

import org.oc.escalade.consumers.BookingDao;
import org.oc.escalade.models.Booking;
import org.oc.escalade.models.Status;

import javax.persistence.*;
import java.util.List;

public class JpaBookingDao implements BookingDao  {
    private EntityManagerFactory emf;

    public JpaBookingDao(EntityManagerFactory emf) { this.emf = emf; }


    @Override
    public Booking addBooking(Booking book) {
        final EntityManager em = emf.createEntityManager();
        EntityTransaction t = em.getTransaction();
        try {
            t.begin();
            em.persist(book);
            t.commit();
        }finally {
            if(t.isActive()) t.rollback();
        }
        return book;
    }

    @Override
    public List<Booking> findBookingsByUserLenderId( Long user_LenderId ) {
        final EntityManager em = emf.createEntityManager();
        List<Booking> bookings;

        try {
            Query query = em.createQuery("SELECT b FROM Booking AS b WHERE b.userLender.userId= :u_id AND (b.status= :s1 OR b.status= :s2)");
            query.setParameter("u_id", user_LenderId);
            query.setParameter("s1", Status.IN_PROGRESS);
            query.setParameter("s2", Status.ACCEPTED);

            try {
                bookings = (List<Booking> )query.getResultList();
            } catch ( NoResultException noResultE ) {
                bookings = null;
            }
        }finally {
            em.close();
        }
        return bookings;
    }

    @Override
    public List<Booking> findBookingsByUserRequestId( Long userRequestId ) {
        final EntityManager em = emf.createEntityManager();
        List<Booking> bookings;

        try {
            Query query = em.createQuery("SELECT b FROM Booking AS b WHERE b.userRequest.userId= :u_id AND b.status= :s1");
            query.setParameter("u_id", userRequestId);
            query.setParameter("s1", Status.IN_PROGRESS);

            try {
                bookings = (List<Booking> )query.getResultList();
            } catch ( NoResultException noResultE ) {
                bookings = null;
            }
        }finally {
            em.close();
        }
        return bookings;
    }

    @Override
    public void updateBookingStatus(Long bookingId, Status status) {
        final EntityManager em = emf.createEntityManager();
        EntityTransaction t = em.getTransaction();

        try {
            t.begin();
            Query query = em.createQuery("UPDATE Booking b SET b.status = :status WHERE b.id= :id");
            query.setParameter("id", bookingId);
            query.setParameter("status", status);

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
    public Booking findBookingById(Long bookingId) {
        final EntityManager em = emf.createEntityManager();
        Booking booking;

        try {
            Query query = em.createQuery("SELECT b FROM Booking AS b WHERE b.id= :id");
            query.setParameter("id", bookingId);
            booking = (Booking) query.getSingleResult();

        }finally {
            em.close();
        }
        return booking;
    }

    @Override
    public Booking findBookingByStatusAndTopoId(Status status, Long topoId) {
        final EntityManager em = emf.createEntityManager();
        Booking booking;

        try {
            Query query = em.createQuery("SELECT b FROM Booking AS b WHERE b.status= :status AND b.topo.id= :id");
            query.setParameter("status", status);
            query.setParameter("id", topoId);

            try{
                booking = (Booking) query.getSingleResult();
            } catch ( NoResultException noResultE ) {
                booking = null;
            }
        }finally {
            em.close();
        }
        return booking;
    }
}