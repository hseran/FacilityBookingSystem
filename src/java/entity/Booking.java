/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author blue
 */
@Entity
@Table(name = "booking")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Booking.findAll", query = "SELECT b FROM Booking b"),
    @NamedQuery(name = "Booking.findById", query = "SELECT b FROM Booking b WHERE b.id = :id"),
    @NamedQuery(name = "Booking.findByCreatedDate", query = "SELECT b FROM Booking b WHERE b.createdDate = :createdDate"),
    @NamedQuery(name = "Booking.findByBookingDate", query = "SELECT b FROM Booking b WHERE b.bookingDate = :bookingDate"),
    @NamedQuery(name = "Booking.findByBookingFrom", query = "SELECT b FROM Booking b WHERE b.bookingFrom = :bookingFrom"),
    @NamedQuery(name = "Booking.findByBookingTo", query = "SELECT b FROM Booking b WHERE b.bookingTo = :bookingTo"),
    @NamedQuery(name = "Booking.findByIsCancelled", query = "SELECT b FROM Booking b WHERE b.isCancelled = :isCancelled"),
    @NamedQuery(name = "Booking.findByCreatedDateAndFacilityId", query = "SELECT b FROM Booking b INNER JOIN b.facilityInstanceId f WHERE b.createdDate = :createdDate AND f.id = :id"),
    @NamedQuery(name = "Booking.findByCancellationDate", query = "SELECT b FROM Booking b WHERE b.cancellationDate = :cancellationDate")})
public class Booking implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Size(max = 50)
    @Column(name = "created_date")
    private String createdDate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "booking_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date bookingDate;
    @Column(name = "booking_from")
    private Integer bookingFrom;
    @Column(name = "booking_to")
    private Integer bookingTo;
    @Column(name = "is_cancelled")
    private Boolean isCancelled;
    @Column(name = "cancellation_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date cancellationDate;
    @JoinColumn(name = "facility_instance_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private FacilityInstances facilityInstanceId;
    @JoinColumn(name = "customer_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Customer customerId;

    public Booking() {
    }

    public Booking(Integer id) {
        this.id = id;
    }

    public Booking(Integer id, Date bookingDate) {
        this.id = id;
        this.bookingDate = bookingDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public Integer getBookingFrom() {
        return bookingFrom;
    }

    public void setBookingFrom(Integer bookingFrom) {
        this.bookingFrom = bookingFrom;
    }

    public Integer getBookingTo() {
        return bookingTo;
    }

    public void setBookingTo(Integer bookingTo) {
        this.bookingTo = bookingTo;
    }

    public Boolean getIsCancelled() {
        return isCancelled;
    }

    public void setIsCancelled(Boolean isCancelled) {
        this.isCancelled = isCancelled;
    }

    public Date getCancellationDate() {
        return cancellationDate;
    }

    public void setCancellationDate(Date cancellationDate) {
        this.cancellationDate = cancellationDate;
    }

    public FacilityInstances getFacilityInstanceId() {
        return facilityInstanceId;
    }

    public void setFacilityInstanceId(FacilityInstances facilityInstanceId) {
        this.facilityInstanceId = facilityInstanceId;
    }

    public Customer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Customer customerId) {
        this.customerId = customerId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Booking)) {
            return false;
        }
        Booking other = (Booking) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Booking[ id=" + id + " ]";
    }
    
}
