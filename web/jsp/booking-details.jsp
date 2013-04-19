<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entity.FacilityInstances"%>
<%@page import="entity.Booking"%>

<%
    Booking booking = (Booking)request.getAttribute("booking");
    if (booking == null)
    {
        return;
    }
%>

<div>
    <strong>Booking Details:</strong>
    <table class="table table-bordered table-hover">
        <tr><td><strong>Booking Id:</strong></td><td><%=booking.getId()%></td></tr>
        <tr><td><strong>Facility:</strong></td><td><%=booking.getFacilityInstanceId().getFacilityId().getName() + " " + booking.getFacilityInstanceId().getName()%></td></tr>
        <tr><td><strong>Date:</strong></td><td><%= new SimpleDateFormat("yyyy-MM-dd").format(booking.getBookingDate()) %></td></tr>
        <tr><td><strong>Time:</strong></td><td><%=booking.getBookingFrom() + " Hrs to " + booking.getBookingTo() + " Hrs" %></td></tr>
    </table>
</div>
