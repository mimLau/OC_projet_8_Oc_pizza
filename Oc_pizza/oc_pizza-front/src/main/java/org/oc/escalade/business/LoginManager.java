package org.oc.escalade.business;

import org.oc.escalade.consumers.DaoFactory;
import org.oc.escalade.consumers.UserDao;
import org.oc.escalade.models.User;
import org.oc.escalade.utils.HashGenerator;
import org.oc.escalade.utils.RetrieveParamValue;

import javax.persistence.NoResultException;
import javax.servlet.http.HttpServletRequest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

public final class LoginManager {

    private static final String IDENTIFIER_FIELD = "identifier";
    private static final String PASS_FIELD = "password";
    private static final String AUTH_MESS = "authMess";

    private Map<String, String> errors = new HashMap<String, String>(); // Map with the fields values in key, and error message in value.
    private UserDao userDao = DaoFactory.getUserDao();

    public Map<String, String> getErrors() {
        return errors;
    }

    /**
     *
     * @param req
     * @return
     */
    public User logUser(HttpServletRequest req) throws NoSuchAlgorithmException {
        String identifier = RetrieveParamValue.getParameterValue( req, IDENTIFIER_FIELD ); // Retrieve the identifier value from the field identifier.
        String password = RetrieveParamValue.getParameterValue( req, PASS_FIELD ); // Retrieve the password value from the field password.
        boolean authenticationOk;

        User user = retrieveUserByIdentifier( identifier );
        authenticationOk = authentication( user, password ); // verify if retrieved identifier and password match.

        if( authenticationOk == false ) {
            setError(AUTH_MESS, "Combinaison identifiant/mot de passe invalide.");  // If authentication failed, put an error in the Map error.
        }
        return user;
    }

    /**
     * Get a user from BDD by his identifier. The identifier can be the username or the email.
     * @param identifier
     * @return return the identified user.
     */
    private User retrieveUserByIdentifier( String identifier ) {
            User user = new User();
        if( identifier.contains("@")) { // If the typed identifier contains an @, it's an email.
            try {
                user = userDao.findUserByEmail( identifier ); // So we search the user by his email.
            } catch (NoResultException e) {
                setError( IDENTIFIER_FIELD, "Adresse e-mail non existante." ); // If the result is null, we put an error massage in the Map error.
            }
        } else { // If the typed identifier doesn't contain an @, it's a username.
            try {
                user = userDao.findUserByUsername( identifier ); // So we search the user by his useranme.
            } catch (NoResultException e) {
                setError( IDENTIFIER_FIELD, "Nom d'utilisateur non reconnu." );
            }
        }
        return user;
    }

    /**
     *
     * @param user The user who want to connect.
     * @param password The user password.
     * @return True if the password is the good one, otherwise return false.
     */
    private boolean authentication( User user, String password ) throws NoSuchAlgorithmException {
        boolean authenticationOk = false;
        String retrievedPass = user.getPassword();  // Get the password of the user that want to connect.
        if( HashGenerator.toHexString( password ).equals( retrievedPass ) ) { // Verify if this password matches with the typed password.
            authenticationOk = true;
        }
        System.out.println("---------------------------------- hash " + HashGenerator.toHexString(password));

        return authenticationOk;
    }

    /**
     * Retrieve errors in filling fields and put them in the error map.
     * @param  field the form field attribute
     * @param message the error message
     */
    private void setError( String field, String message ) {
        errors.put( field, message );
    }
}
