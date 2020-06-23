package org.oc.escalade.consumers;


import org.oc.escalade.models.Length;

import java.util.List;

public interface LengthDao {
    Length addLength( Length length );
    Length findLengthById( Long id );
    List<Length> findLengthsByRating( String rating );
}
