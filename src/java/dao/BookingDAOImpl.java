/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Booking;
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
public class BookingDAOImpl extends AbstractDAO<Booking> implements BookingDAO {
    @PersistenceContext(unitName = "FacilityBookingSystemPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public BookingDAOImpl() {
        super(Booking.class);
    }
        @Override
    public Object getBookingByDate(String date, int facilityId) {

        Query query = null;
        query = em.createNamedQuery("Booking.findByCreatedDateAndFacilityId");
        query.setParameter("createdDate", date);
        query.setParameter("id", facilityId);
        List obj = query.getResultList();
        return obj;
    }
    
}
