package org.oc.escalade.consumers.impl.jpa;

import org.oc.escalade.consumers.UserDao;
import org.oc.escalade.models.User;

import javax.persistence.*;

public class JpaUserDao implements UserDao {
    private EntityManagerFactory emf;

    public JpaUserDao(EntityManagerFactory emf){
        this.emf=emf;
    }

    @Override
    public User addUser(User user) {
        final EntityManager em = emf.createEntityManager();
        EntityTransaction t = em.getTransaction();
        try {
            t.begin();
            em.persist(user);
            t.commit();
        }finally {
            if(t.isActive()) t.rollback();
        }
        return user;
    }

    @Override
    public User findUserByUsername(String username) {
        final EntityManager em = emf.createEntityManager();
        User user;

        try {
            Query query = em.createQuery("SELECT u FROM User AS u WHERE u.username= :username");
            query.setParameter("username", username);
            user = (User) query.getSingleResult();
        }finally {
            em.close();
        }
        return user;
    }

    @Override
    public boolean usernameExists(String username) {
        final EntityManager em = emf.createEntityManager();
        boolean usernameExists = true;

        try {
            Query query = em.createQuery("SELECT u FROM User AS u WHERE u.username= :username");
            query.setParameter("username", username);
            try {
                User user = (User) query.getSingleResult();
            } catch (NoResultException e) {
                usernameExists = false;
            }
        }finally {
            em.close();
        }
        return usernameExists;
    }

    @Override
    public User findUserByEmail(String email) {
        final EntityManager em = emf.createEntityManager();
        User user;

        try {
            Query query = em.createQuery("SELECT u FROM User AS u WHERE u.email= :email");
            query.setParameter("email", email);
            user = (User) query.getSingleResult();
        } finally {
            em.close();
        }
        return user;
    }
}
