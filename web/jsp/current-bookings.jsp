<%-- 
    Document   : current-bookings
    Created on : 18 Apr, 2013, 12:35:06 AM
    Author     : naresh
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entity.Booking"%>

<%@include file="../WEB-INF/jspf/header.jspf"%>

<div class="container-fluid">
    <div class ="row-fluid">
            <div class ="span3">
                <%@include file="../WEB-INF/jspf/account-side-bar.jspf"%>
            </div>
            <div class ="span7">
<%
    List<Booking> bookings = (List<Booking>)request.getAttribute("bookings");
    if (bookings == null || bookings.size() == 0)
    {
%>
<h2>You have do not have any Current Bookings</h2>
<%
    }
    else
    {
%>
<table class="table table-bordered table-hover">
		  <thead>
                      <tr>
				<th>Facility</th>
                                <th>Date Booked On</th>
				<th>Date Booked For</th>
                                <th>From - To</th>
				<th>Action</th>
			  </tr>
			</thead>
			<tbody>

<%
        for (Booking booking : bookings)
        {
%>
<tr>
    <td><%= booking.getFacilityInstanceId().getFacilityId().getName() + booking.getFacilityInstanceId().getName() %></td>
    <td><%= new SimpleDateFormat("yyyy-MM-dd").format(booking.getCreatedDate())%></td>
    <td><%= new SimpleDateFormat("yyyy-MM-dd").format(booking.getBookingDate())%></td>
    <td><%= booking.getBookingFrom() + ":00 - " + booking.getBookingTo() +":00"%></td>
    <%System.out.println("4");%>
    <td><%= booking.getIsCancelled()?"CANCELLED":"<a title='Cancel Booking' href='cancel-booking?id=" + booking.getId() + "'><i class='icon-trash'> </i></a>" %></td>
</tr>

<%
        }
%>
    </tbody>
    </table>
<%
    }
%>
        </div>
        <div class="span2"></div>
    </div>
</div>
<%@include file="../WEB-INF/jspf/footer.jspf"%>