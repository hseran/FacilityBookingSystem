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
        Date date = new Date();
        query = em.createNamedQuery("Booking.findCurrentBookings");
        query.setParameter("customerId", customerId);
        query.setParameter("currentDate", date, TemporalType.DATE);
        query.setParameter("currentHour", date.getHours());
        List obj = query.getResultList(); 
        System.out.println(obj.size());
        return (List<Booking>)obj;
    }

    @Override
    public List<Booking> getPastBookings(int customerId) {
        Query query = null;
        Date date = new Date();
        query = em.createNamedQuery("Booking.findPastBookings");
        query.setParameter("customerId", customerId);
        query.setParameter("currentDate", date, TemporalType.DATE);
        query.setParameter("currentHour", date.getHours());
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

    @Override
    public boolean checkSlotAvailability(int facilityInstanceId, int slot, Date bookingDate) {
        Query query = null;
        query = em.createNamedQuery("Booking.checkBookingSlotForInstance");
        //SELECT b FROM Booking b JOIN b.facilityInstanceId fid WHERE fid.id = :fInstanceId AND b.isCancelled = FALSE AND b.bookingDate = :bookingDate AND b.bookingFrom = :bookingFrom BY b.bookingDate DESC, b.bookingFrom DESC
        query.setParameter("fInstanceId", facilityInstanceId);
        query.setParameter("bookingDate", bookingDate, TemporalType.DATE);
        query.setParameter("bookingFrom", slot);
        List obj = query.getResultList();        
        return obj.isEmpty();
    }

    @Override
    public boolean checkIfUserReachedBookingLimit(int userId, int facilityId, Date bookingDate){
        
        String queryStr = "SELECT t0.ID, t0.booking_date, t0.booking_from, t0.booking_to, t0.cancellation_date, t0.created_date, t0.is_cancelled, t0.customer_id, t0.facility_instance_id FROM BOOKING t0, facility_instances t2, CUSTOMER t1, facility t3 WHERE (((((t2.facility_id = ?) AND (t0.is_cancelled = 0)) AND (t0.booking_date = ?)) AND (t1.ID = ?)) AND ((t0.customer_id = t1.ID) AND (t2.ID = t0.facility_instance_id) AND (t2.facility_id = t3.id)))";
        
        Query query = em.createNativeQuery(queryStr, Booking.class);
        query.setParameter(1, facilityId);
        query.setParameter(2, bookingDate, TemporalType.DATE);
        query.setParameter(3, userId);
        List obj = query.getResultList();
        return !obj.isEmpty();
    }
    
    @Override
    public boolean checkMultipleFacilitiesAtSameTime(int userId, int slot, Date bookingDate) {
        Query query = null;
        query = em.createNamedQuery("Booking.checkMultipleFacilitiesAtSameTime");
        //SELECT b FROM Booking b JOIN b.customerId cid WHERE b.isCancelled = FALSE AND b.bookingDate = :bookingDate AND b.bookingFrom = :bookingFrom AND cid.id = :customer_id
        query.setParameter("customer_id", userId);
        query.setParameter("bookingDate", bookingDate, TemporalType.DATE);
        query.setParameter("bookingFrom", slot);
        List obj = query.getResultList();        
        return !obj.isEmpty();
    }
}
