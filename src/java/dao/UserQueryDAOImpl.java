/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.UserQuery;
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
public class UserQueryDAOImpl extends AbstractDAO<UserQuery> implements UserQueryDAO {
    @PersistenceContext(unitName = "FacilityBookingSystemPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UserQueryDAOImpl() {
        super(UserQuery.class);
    }

    @Override
    public List<UserQuery> getUnResolvedQuery() {
        Query query = em.createNamedQuery("UserQuery.findByIsResolved");
        query.setParameter("isResolved", false);
        List<UserQuery> queries = (List<UserQuery>)query.getResultList();        
        return queries;
    }

    @Override
    public List<UserQuery> getResolvedQuery() {
        Query query = em.createNamedQuery("UserQuery.findByIsResolved");
        query.setParameter("isResolved", true);
        List<UserQuery> queries = (List<UserQuery>)query.getResultList();        
        return queries;
    }

    @Override
    public boolean updateQueryStatus(int queryId, boolean isResolved) {
        Query query = em.createNamedQuery("UserQuery.updateStatus");
        query.setParameter("id", queryId);
        query.setParameter("isResolved", isResolved);
        return query.executeUpdate() > 0;
    }
    
    
}
