package org.oc.escalade.consumers;

import org.oc.escalade.consumers.impl.jpa.*;
import org.oc.escalade.utils.PersistenceManager;

public class DaoFactory {

    private DaoFactory(){}

    public static UserDao getUserDao(){
        return new JpaUserDao(
            PersistenceManager.getEntityManagerFactory());
        }

    public static PlaceDao getPlaceDao() {
        return new JpaPlaceDao(
                PersistenceManager.getEntityManagerFactory());
    }

    public static SiteDao getSiteDao() {
        return new JpaSiteDao(
                PersistenceManager.getEntityManagerFactory());
    }

    public static SectorDao getSectorDao() {
        return new JpaSectorDao(
                PersistenceManager.getEntityManagerFactory());
    }

    public static WayDao getWayDao() {
        return new JpaWayDao(
                PersistenceManager.getEntityManagerFactory());
    }

    public static LengthDao getLengthDao() {
        return new JpaLengthDao(
                PersistenceManager.getEntityManagerFactory());
    }

    public static CommentDao getCommentDao() {
        return new JpaCommentDao(
                PersistenceManager.getEntityManagerFactory());
    }

    public static TopoDao getTopoDao() {
        return new JpaTopoDao(
                PersistenceManager.getEntityManagerFactory());
    }

    public static BookingDao getBookingDao() {
        return new JpaBookingDao(
                PersistenceManager.getEntityManagerFactory());
    }
}
