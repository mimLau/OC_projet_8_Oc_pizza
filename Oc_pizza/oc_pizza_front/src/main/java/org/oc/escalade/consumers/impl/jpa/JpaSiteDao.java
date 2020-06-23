package org.oc.escalade.consumers.impl.jpa;

import org.oc.escalade.consumers.SiteDao;
import org.oc.escalade.models.Place;
import org.oc.escalade.models.Site;

import javax.persistence.*;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class JpaSiteDao implements SiteDao {
    private EntityManagerFactory emf;

    public JpaSiteDao(EntityManagerFactory emf) {
        this.emf = emf;
    }

    @Override
    public List<Site> getAllSites() {
        final EntityManager em = emf.createEntityManager();
        List<Site> allSites = new ArrayList<Site>();

        try {
            Query query = em.createQuery("SELECT s FROM Site as s");
            allSites = (List<Site>) query.getResultList();

        } finally {
            em.close();
        }

        return allSites;
    }

    @Override
    public Site addSite(Site site) {
        final EntityManager em = emf.createEntityManager();
        EntityTransaction t = em.getTransaction();
        try {
            t.begin();
            em.persist(site);
            t.commit();
        }finally {
            if(t.isActive()) t.rollback();
        }
        return site;
    }

    @Override
    public Site findSiteById(Long id) {
        final EntityManager em = emf.createEntityManager();
        Site site = new Site();

        try {
            Query query = em.createQuery("SELECT DISTINCT s FROM Site AS s LEFT JOIN FETCH s.sectors  WHERE s.id= :id ");
            query.setParameter("id", id);
            site = (Site) query.getSingleResult();

            Query  query2 = em.createQuery("SELECT DISTINCT s FROM Site AS s LEFT JOIN FETCH s.comments WHERE  s IN :site");
            query2.setParameter("site", site);
            site = (Site) query2.getSingleResult();
        } finally {
            em.close();
        }
        return site;
    }

    @Override
    public void updateNbOfSectors(Long id) {
        final EntityManager em = emf.createEntityManager();
        EntityTransaction t = em.getTransaction();

        try {
            t.begin();
            Query query = em.createQuery("UPDATE Site s SET s.nbOfSectors = s.nbOfSectors + :increment WHERE s.id= :id");
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
    public void updateTag( Long sitId, Boolean tag ) {
        final EntityManager em = emf.createEntityManager();
        EntityTransaction t = em.getTransaction();

        try {
            t.begin();
            Query query = em.createQuery("UPDATE Site s SET s.tagged= :tag WHERE s.id= :id");
            query.setParameter("id", sitId);
            query.setParameter("tag", tag);

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
    public List<Site> getSitesByPlaceId(Long placeId) {
        final EntityManager em = emf.createEntityManager();
        List<Site> sites;

        Query query = em.createQuery("SELECT s FROM Site AS s  WHERE s.place.id= :id ");
        query.setParameter("id", placeId);

        try {
            sites = (List<Site>) query.getResultList();
        } finally {
            em.close();
        }
        return sites;
    }

    @Override
    public int getMaxNbSector() {
        final EntityManager em = emf.createEntityManager();
        int nbSectorMax;

        try {
            Query query = em.createQuery("SELECT max(s.nbOfSectors) FROM Site AS s");
            nbSectorMax = (int) query.getSingleResult();

        } finally {
            em.close();
        }
        return nbSectorMax;
    }

    @Override
    public List<Site> getSitesByTag( Boolean tagged ) {
        final EntityManager em = emf.createEntityManager();
        List<Site> sites = new ArrayList<>();

        Query query = em.createQuery("SELECT s FROM Site AS s  WHERE s.tagged= :tagged ");
        query.setParameter("tagged", tagged);

        try {
            sites = (List<Site>) query.getResultList();
        }catch ( NoResultException noResultE ) {

        } finally {
            em.close();
        }
        return sites;
    }

    @Override
    public List<Site> getSitesBySearchParams( Map<String, Object> criteriaResearchMap ) {
        final EntityManager em = emf.createEntityManager();
        Boolean tagged = null;
        Place place = null;
        Integer sectorNb = null;
        List<Long> sitesIds = null;

        List<Site> sites = new ArrayList<>();
        Query query;
        String stringQuery = "SELECT s FROM Site AS s WHERE ";

        for( Map.Entry<String, Object> entry : criteriaResearchMap.entrySet() ) {
            if( entry.getKey().equals("sitesIds") ) {
                sitesIds = (List<Long>) entry.getValue();

            } else if( entry.getKey().equals("sectorNb") ) {
                sectorNb = (Integer) entry.getValue();

            } else if ( entry.getKey().equals("place") ) {
                place = (Place) entry.getValue();

            } else if ( entry.getKey().equals("tagged") ) {
                tagged = (Boolean) entry.getValue();
            }
        }

        try {

            if( tagged != null && place != null && sectorNb != null ) {
                stringQuery = stringQuery + " s.tagged= :tagged AND s.place= :place AND s.nbOfSectors= :sectorNb";
                query = em.createQuery( stringQuery );
                query.setParameter("tagged", tagged );
                query.setParameter("place", place );
                query.setParameter("sectorNb", sectorNb );

                try {
                    sites = (List<Site>) query.getResultList();
                } catch( NoResultException noResultE) {
                    sites = null;
                }

            } else if( tagged == null && place != null && sectorNb != null ) {
                stringQuery = stringQuery + " s.place= :place AND s.nbOfSectors= :sectorNb";
                query = em.createQuery( stringQuery );
                query.setParameter("place", place );
                query.setParameter("sectorNb", sectorNb );

                try {
                    sites = (List<Site>) query.getResultList();
                } catch( NoResultException noResultE) {
                    sites = null;
                }

            } else if( tagged != null && place == null && sectorNb != null ) {
                stringQuery = stringQuery + " s.tagged= :tagged AND s.nbOfSectors= :sectorNb";
                query = em.createQuery( stringQuery );
                query.setParameter("tagged", tagged );
                query.setParameter("sectorNb", sectorNb );

                try {
                    sites = (List<Site>) query.getResultList();
                } catch( NoResultException noResultE) {
                    sites = null;
                }

            } else if( tagged == null && place == null && sectorNb != null ) {
                stringQuery = stringQuery + "s.nbOfSectors= :sectorNb";
                query = em.createQuery( stringQuery );
                query.setParameter("sectorNb", sectorNb );

                try {
                    sites = (List<Site>) query.getResultList();
                } catch( NoResultException noResultE) {
                    sites = null;
                }

            } else if( tagged != null && place != null && sectorNb == null ) {
                stringQuery = stringQuery + " s.tagged= :tagged AND s.place= :place";
                query = em.createQuery( stringQuery );
                query.setParameter("tagged", tagged );
                query.setParameter("place", place );

                try {
                    sites = (List<Site>) query.getResultList();
                } catch( NoResultException noResultE) {
                    sites = null;
                }

            } else if( tagged == null && place != null && sectorNb == null ) {
                stringQuery = stringQuery + " s.place= :place";
                query = em.createQuery( stringQuery );
                query.setParameter("place", place );

                try {
                    sites = (List<Site>) query.getResultList();
                } catch( NoResultException noResultE) {
                    sites = null;
                }

            } else if( tagged != null && place == null && sectorNb == null ) {
                stringQuery = stringQuery + "s.tagged= :tagged";
                query = em.createQuery( stringQuery );
                query.setParameter("tagged", tagged );

                try {
                    sites = (List<Site>) query.getResultList();
                } catch( NoResultException noResultE) {
                    sites = null;
                }

            } /*else if( tagged == null && place == null && sectorNb == null ) {
                query = em.createQuery("SELECT s FROM Site AS s");

                try {
                    sites = (List<Site>) query.getResultList();
                } catch( NoResultException noResultE) {
                    sites = null;
                }
            }*/


            if( sitesIds != null ) {
                Query query2;

                if ( !sitesIds.isEmpty() ) {
                    String stringQuery2 = "SELECT s FROM Site AS s WHERE s.id IN :ids";

                    if (tagged == null && place == null && sectorNb == null) {
                        query2 = em.createQuery(stringQuery2);
                        query2.setParameter("ids", sitesIds);

                    } else if (sites.isEmpty() || sites == null) {
                        query2 = null;
                    } else {
                        query2 = em.createQuery(stringQuery2 + " AND s IN :sites");

                        query2.setParameter("ids", sitesIds);
                        query2.setParameter("sites", sites);
                    }

                    try {
                        sites = (List<Site>) query2.getResultList();
                    } catch (NoResultException noResultE) {
                        sites = null;
                    } catch (NullPointerException n) {
                        sites = null;
                    }
                } else {
                    sites = null;
                }
            }
        } finally {
            em.close();
        }
        return sites;
    }


}
