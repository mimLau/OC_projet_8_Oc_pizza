package org.oc.escalade.consumers;

import org.oc.escalade.models.Comment;
import org.oc.escalade.models.Site;

import java.util.Date;
import java.util.List;

public interface CommentDao {

    Comment addComment( Comment comment );
    List<Comment> getCommentsBySiteId( Site site );
    void deleteComById( Long id );
    void updateCommentById( Long id, String newContent, String editedDate);
}
