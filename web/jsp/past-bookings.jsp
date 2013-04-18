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
            <div class ="span9">
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
				<th>Note</th>
			  </tr>
			</thead>
			<tbody>

<%
        for (Booking booking : bookings)
        {
%>
<tr>
    <td>Table Tennis - 1</td>
    <td>2013-04-17</td>
    <td>2013-04-19</td>
    <td>10:00 to 11:00</td>
    <td>CANCELLED</td>
</tr>
<tr>
    <td><%= booking.getFacilityInstanceId().getFacilityId().getName() + booking.getFacilityInstanceId().getName() %></td>
    <td><%= new SimpleDateFormat("yyyy-MM-dd").format(booking.getCreatedDate()) %></td>
    <td><%= new SimpleDateFormat("yyyy-MM-dd").format(booking.getBookingFrom()) %></td>
    <td><%= new SimpleDateFormat("HH:mm").format(booking.getBookingFrom()) + " to " 
            + new SimpleDateFormat("HH:mm").format(booking.getBookingTo())%></td>
    <td><%= booking.getIsCancelled()?"CANCELLED":"-" %></td>
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
    </div>
</div>
<%@include file="../WEB-INF/jspf/footer.jspf"%>