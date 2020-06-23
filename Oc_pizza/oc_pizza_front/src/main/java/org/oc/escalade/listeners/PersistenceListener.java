package org.oc.escalade.listeners;

import org.oc.escalade.utils.PersistenceManager;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class PersistenceListener implements ServletContextListener {

    public void contextInitialized(ServletContextEvent arg0){

    }

    public void contextDestroyed(ServletContextEvent arg0){
        PersistenceManager.closeEntityManagerFactory();
    }
}
