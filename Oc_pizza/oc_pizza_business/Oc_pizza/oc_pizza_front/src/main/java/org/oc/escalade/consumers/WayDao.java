package org.oc.escalade.consumers;

import org.oc.escalade.models.Way;

import java.util.List;

public interface WayDao {
    Way addWay(Way way);
    List<Way> getAllWays();
    Way findWayById(Long id);
    void updateNbOfLengths(Long id);
    List<Way> findWaysByRating( String rating );
}
