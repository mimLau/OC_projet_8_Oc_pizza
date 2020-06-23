package org.oc.escalade.consumers;

import org.oc.escalade.models.Sector;

public interface SectorDao {

    Sector addSector(Sector sector);
    Sector findSectorById(Long id);
    void updateNbOfWays(Long id);
}
