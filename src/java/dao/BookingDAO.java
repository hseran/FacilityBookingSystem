/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Booking;
import java.util.Date;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author naresh
 */
@Local
public interface BookingDAO {

    void create(Booking booking);

    void edit(Booking booking);

    void remove(Booking booking);

    Booking find(Object id);

    List<Booking> findAll();

    List<Booking> findRange(int[] range);

    int count();
    
    List<Booking> getCurrentBookings(int customerId);
    
    List<Booking> getBookingByDate(Date date, int facilityId);
    
    List<Booking> getPastBookings(int customerId);

    List<Booking> getCanceledBookings(int customerId);
    
    boolean checkSlotAvailability(int facilityInstanceId, int slot, Date bookingDate);
    
    boolean checkIfUserReachedBookingLimit(int userId, int facilityId, Date bookingDate);

    boolean checkMultipleFacilitiesAtSameTime(int userId, int slot, Date bookingDate);
}
