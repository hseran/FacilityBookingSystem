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
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author naresh
 */
@Entity
@Table(name = "user_query")
@NamedQueries({
    @NamedQuery(name = "UserQuery.findAll", query = "SELECT u FROM UserQuery u"),
    @NamedQuery(name = "UserQuery.findById", query = "SELECT u FROM UserQuery u WHERE u.id = :id"),
    @NamedQuery(name = "UserQuery.findByUserName", query = "SELECT u FROM UserQuery u WHERE u.userName = :userName"),
    @NamedQuery(name = "UserQuery.findByPhone", query = "SELECT u FROM UserQuery u WHERE u.phone = :phone"),
    @NamedQuery(name = "UserQuery.findByEmail", query = "SELECT u FROM UserQuery u WHERE u.email = :email"),
    @NamedQuery(name = "UserQuery.findByIsResolved", query = "SELECT u FROM UserQuery u WHERE u.isResolved = :isResolved ORDER BY u.submittedOn DESC"),
    @NamedQuery(name = "UserQuery.findBySubmittedOn", query = "SELECT u FROM UserQuery u WHERE u.submittedOn = :submittedOn"),
    @NamedQuery(name = "UserQuery.updateStatus", query = "UPDATE UserQuery u SET u.isResolved = :isResolved WHERE u.id = :id")})
public class UserQuery implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "user_name")
    private String userName;
    // @Pattern(regexp="^\\(?(\\d{3})\\)?[- ]?(\\d{3})[- ]?(\\d{4})$", message="Invalid phone/fax format, should be as xxx-xxx-xxxx")//if the field contains phone or fax number consider using this annotation to enforce field validation
    @Size(max = 45)
    private String phone;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    private String email;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 65535)
    private String query;
    @Basic(optional = false)
    @NotNull
    @Column(name = "is_resolved")
    private boolean isResolved;
    @Basic(optional = false)
    @NotNull
    @Column(name = "submitted_on")
    @Temporal(TemporalType.TIMESTAMP)
    private Date submittedOn;

    public UserQuery() {
    }

    public UserQuery(Integer id) {
        this.id = id;
    }

    public UserQuery(Integer id, String userName, String email, String query, boolean isResolved, Date submittedOn) {
        this.id = id;
        this.userName = userName;
        this.email = email;
        this.query = query;
        this.isResolved = isResolved;
        this.submittedOn = submittedOn;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public boolean getIsResolved() {
        return isResolved;
    }

    public void setIsResolved(boolean isResolved) {
        this.isResolved = isResolved;
    }

    public Date getSubmittedOn() {
        return submittedOn;
    }

    public void setSubmittedOn(Date submittedOn) {
        this.submittedOn = submittedOn;
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
        if (!(object instanceof UserQuery)) {
            return false;
        }
        UserQuery other = (UserQuery) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.UserQuery[ id=" + id + " ]";
    }
    
}
