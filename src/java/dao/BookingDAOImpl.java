/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Booking;
import java.util.Date;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TemporalType;

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
    public List<Booking> getBookingByDate(Date date, int facilityId) {
        Query query = null;
        query = em.createNamedQuery("Booking.findByBookingDateAndFacilityId");
        query.setParameter("bookingDate", date, TemporalType.DATE);
        query.setParameter("id", facilityId);
        List obj = query.getResultList();
        return obj;
    }
    @Override
    public List<Booking> getCurrentBookings(int customerId) {
        Query query = null;
        query = em.createNamedQuery("Booking.findCurrentBookings");
        query.setParameter("customerId", customerId);
        query.setParameter("currentDate", new Date(), TemporalType.DATE);
        List obj = query.getResultList(); 
        System.out.println(obj.size());
        return (List<Booking>)obj;
    }

    @Override
    public List<Booking> getPastBookings(int customerId) {
        Query query = null;
        query = em.createNamedQuery("Booking.findPastBookings");
        query.setParameter("customerId", customerId);
        query.setParameter("currentDate", new Date(), TemporalType.DATE);
        List obj = query.getResultList();        
        return (List<Booking>)obj;
    }

    @Override
    public List<Booking> getCanceledBookings(int customerId) {
        Query query = null;
        query = em.createNamedQuery("Booking.findMyCanceledBookings");
        query.setParameter("customerId", customerId);
        List obj = query.getResultList();        
        return (List<Booking>)obj;
    }
}
