package org.oc.escalade.business;

import org.oc.escalade.consumers.CommentDao;
import org.oc.escalade.consumers.DaoFactory;
import org.oc.escalade.models.Comment;
import org.oc.escalade.models.Site;
import org.oc.escalade.models.User;
import org.oc.escalade.utils.DateManager;
import org.oc.escalade.utils.RetrieveParamValue;

import javax.servlet.http.HttpServletRequest;

public class CommentsManager {
    private CommentDao commentDao = DaoFactory.getCommentDao();
    private final static String COMMENT_CONTENTS_FIELD = "comment_contents";
    private final static String COMMENT_EDIT_CONTENTS_FIELD = "comment_edit_contents";
    private final static String ID_COMMENT_PARAM = "id";
    private static final String SITE_ATT =  "site";
    private final static String USER_SESSION = "user";

    /**
     * Add a new comment in BDD.
     * @param req
     * @return The created comment.
     */
    public Comment addComment( HttpServletRequest req ) {
        String commentContents = RetrieveParamValue.getParameterValue( req, COMMENT_CONTENTS_FIELD ); // Retrieve the comment contents from the field comment_contents
        User user = (User) req.getSession().getAttribute( USER_SESSION ); // Retrieve the connected user.
        Site site = (Site) req.getServletContext().getAttribute( SITE_ATT ); //Retrieve the site linked to the new comment.

        Comment comment = new Comment();
        comment.setContents( commentContents );
        comment.setCommentOwner( user );
        comment.setSiteComment( site );
        comment.setDate( DateManager.getLocalDate() );

        commentDao.addComment( comment );
        return comment;
    }

    /**
     * Delete a comment from its id.
     * @param req
     */
    public void deleteComment( HttpServletRequest req ) {
        Long commentId = Long.parseLong(RetrieveParamValue.getParameterValue( req,  ID_COMMENT_PARAM )); // Retrieve the id of the comment which will be deleted.
        commentDao.deleteComById(commentId);
    }

    /**
     * Update a comment in the BDD.
     * @param req
     */
    public void updateComment( HttpServletRequest req ) {
        Long commentId = Long.parseLong(RetrieveParamValue.getParameterValue( req,  ID_COMMENT_PARAM )); // Retrieve the id of the comment which will be edited.
        String commentContents = RetrieveParamValue.getParameterValue(  req, COMMENT_EDIT_CONTENTS_FIELD ); // Retrieve the edited contents from the comment_contents field.
        commentDao.updateCommentById( commentId, commentContents , DateManager.getLocalDate() );
    }
}
