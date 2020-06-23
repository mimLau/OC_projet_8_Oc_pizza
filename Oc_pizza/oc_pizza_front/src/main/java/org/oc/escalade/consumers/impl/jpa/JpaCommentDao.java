package org.oc.escalade.consumers.impl.jpa;

import org.oc.escalade.consumers.CommentDao;
import org.oc.escalade.models.Comment;
import org.oc.escalade.models.Site;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class JpaCommentDao implements CommentDao {
    private EntityManagerFactory emf;

    public JpaCommentDao(EntityManagerFactory emf) {
        this.emf = emf;
    }

    @Override
    public Comment addComment(Comment comment) {
       final  EntityManager em = emf.createEntityManager();
        EntityTransaction t = em.getTransaction();
        try {
            t.begin();
            em.persist(comment);
            t.commit();
        } finally {
            if( t.isActive() ) t.rollback();
        }
        return comment;
    }

    @Override
    public List<Comment> getCommentsBySiteId(Site site) {
        final  EntityManager em = emf.createEntityManager();
        List <Comment> comments = new ArrayList<Comment>();

        try {
            Query query = em.createQuery("SELECT c FROM Comment AS c WHERE c.siteComment= :site");
            query.setParameter("site", site );
            comments = (List<Comment>) query.getResultList();
        } finally {
            em.close();
        }
        return comments;
    }

    @Override
    public void deleteComById(Long id) {
        final EntityManager em = emf.createEntityManager();
        final EntityTransaction t = em.getTransaction();
        try {
            t.begin();
            Query query = em.createQuery("DELETE FROM Comment c WHERE c.id = :id");
            query.setParameter("id", id);
            query.executeUpdate();
            t.commit();
        } finally {
            if( t.isActive() ) t.rollback();
        }
        em.close();
    }

    @Override
    public void updateCommentById(Long id, String newContents, String editedDate) {
        final EntityManager em = emf.createEntityManager();
        EntityTransaction t = em.getTransaction();

        try {
            t.begin();
            Query query = em.createQuery("UPDATE Comment c SET c.contents= :contents, c.editedDate= :date, c.edited = TRUE WHERE c.id= :id");
            query.setParameter("contents", newContents );
            query.setParameter("date", editedDate );
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
