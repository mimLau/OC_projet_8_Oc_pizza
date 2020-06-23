package org.oc.escalade.consumers.impl.jpa;

import org.oc.escalade.consumers.SectorDao;
import org.oc.escalade.models.Sector;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;

public class JpaSectorDao implements SectorDao {
    private EntityManagerFactory emf;

    public JpaSectorDao( EntityManagerFactory emf ){
        this.emf=emf;
    }

    @Override
    public Sector addSector( Sector sector ) {
        final EntityManager em = emf.createEntityManager();
        EntityTransaction t = em.getTransaction();
        try {
            t.begin();
            em.persist( sector );
            t.commit();
        }finally {
            if( t.isActive() ) t.rollback();
        }
        return sector;
    }

    @Override
    public Sector findSectorById( Long id ) {
        final EntityManager em = emf.createEntityManager();
        Sector sector = new Sector();

        try {
            Query query = em.createQuery("SELECT s FROM Sector AS s LEFT JOIN FETCH s.ways WHERE s.id= :id ");
            query.setParameter("id", id);
            sector = ( Sector) query.getSingleResult();
        } finally {
            em.close();
        }
        return sector;
    }

    @Override
    public void updateNbOfWays(Long id) {
        final EntityManager em = emf.createEntityManager();
        EntityTransaction t = em.getTransaction();

        try {
            t.begin();
            Query query = em.createQuery("UPDATE Sector s SET s.nbOfWays = s.nbOfWays + :increment WHERE s.id= :id");
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
}
