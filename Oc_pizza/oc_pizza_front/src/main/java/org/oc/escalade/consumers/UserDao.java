package org.oc.escalade.consumers;

import org.oc.escalade.models.User;

public interface UserDao {

    User addUser(User user);
    User findUserByUsername(String username);
    boolean usernameExists(String username);
    User findUserByEmail(String email);

}
