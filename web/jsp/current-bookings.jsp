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
            <div class ="span8 booking-data">
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
<b> Current Bookings</b>
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
<tr class="booking">
    <td><%= booking.getFacilityInstanceId().getFacilityId().getName() + " " + booking.getFacilityInstanceId().getName() %></td>
    <td><%= new SimpleDateFormat("yyyy-MM-dd").format(booking.getCreatedDate())%></td>
    <td><%= new SimpleDateFormat("yyyy-MM-dd").format(booking.getBookingDate())%></td>
    <td><%= booking.getBookingFrom() + ":00 - " + booking.getBookingTo() +":00"%></td>
    <%System.out.println("4");%>
    <td><%= booking.getIsCancelled()?"CANCELLED":"<a style='cursor:pointer' id='booking_" + booking.getId() + "' class='cancel' title='Cancel Booking'><i class='icon-trash'> </i></a> &nbsp;&nbsp;&nbsp; <a style='cursor:pointer' onClick='printBooking(" + booking.getId() +  ");' title='Print'><i class='icon-print'> </i></a>" %></td>
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
        <div class="span1"></div>
    </div>
</div>

    <script type="text/javascript">
    $(document).ready(function(){
        $("a.cancel").click(cancelBooking);
        }); 
        
    function cancelBooking(event)
    {
        var $that = $(this).closest('tr');        
        var booking_id_val = $.trim($(this).attr('id'));
        booking_id_val = booking_id_val.replace("booking_", "");
        $.post("cancel-booking", {booking_id:booking_id_val})
        .done (function(data){
            parent = $that.parent();
            $that.remove();
            if (parent.find('tr').length == 0)
            {
                parent.closest('div.booking-data').html("<h2>You have do not have any Current Bookings</h2>")
            }
        });
    }
    
    function printBooking(id)
    {
        window.open('booking-details?booking_id=' + id,'Booking Details','directories=no,titlebar=yes,toolbar=no,location=no,status=no,menubar=yes,scrollbars=no,resizable=no,width=400,height=300');
    }
            
    </script>

<%@include file="../WEB-INF/jspf/footer.jspf"%>