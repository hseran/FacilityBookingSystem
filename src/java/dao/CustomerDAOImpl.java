/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Customer;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author naresh
 */
@Stateless
public class CustomerDAOImpl extends AbstractDAO<Customer> implements CustomerDAO {
    @PersistenceContext(unitName = "FacilityBookingSystemPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CustomerDAOImpl() {
        super(Customer.class);
    }
    
    @Override
    public Customer authenticateUser(String login, String password) {
        Query query = null;
        query = em.createNamedQuery("Customer.findByLoginAndPassword");
        query.setParameter("login", login);
        query.setParameter("password", password);
        List obj = query.getResultList();
        
        /*
         * if there are no records, return null
         */
        if (obj == null || obj.isEmpty())
        {
            return null;
        }

        return (Customer)obj.get(0);            
    }

    @Override
    public boolean isLoginIDAvailable(String login) {
        Query query = null;
        query = em.createNamedQuery("Customer.findByUsername");
        query.setParameter("username", login);
        List obj = query.getResultList();
        
        /*
         * if there are no records, return false
         */
        if (obj == null || obj.isEmpty())
        {
            return true;
        }
        return false;
    }
}
