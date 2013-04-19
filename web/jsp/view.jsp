<%-- 
    Document   : select
    Created on : Apr 17, 2013, 3:22:51 AM
    Author     : blue
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entity.FacilityInstances"%>
<%@page import="entity.Customer"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%!            
    String status[];
    Iterator iterator;
    String key;
    String obj;
    String arr[] = new String[]{"08 Hrs - 09 Hrs", "09 Hrs - 10 Hrs", "10 Hrs - 11 Hrs", "11 Hrs - 12 Hrs",
        "12 Hrs - 13 Hrs", "13 Hrs - 14 Hrs", "14 Hrs - 15 Hrs", "15 Hrs - 16 Hrs", "16 Hrs - 17 Hrs", "17 Hrs - 18 Hrs", "18 Hrs - 19 Hrs"};
%>
<%
    Customer loggedInUser = (Customer)session.getAttribute("customer");
    FacilityInstances ins = (FacilityInstances) request.getAttribute("selectedInstance");
    Date sdate = (Date) session.getAttribute("selectdate");
%>
<div style="text-align: center;">
    <b>Availability for <%= ins.getFacilityId().getName() + " " + ins.getName() %> on <%=new SimpleDateFormat("yyyy-MM-dd").format(sdate)%></b><br/>
    <form>
        <table id ="slots-table"  class="text-center table table-bordered " width="30%">
            <tr class="success">
                <th>Slot</th>
                <th>Status</th>
                <%if (loggedInUser != null){%><th>Update</th><%}%>

                <%
                    HttpSession sess = request.getSession();
                    //m = (Map<Integer, String>) sess.getAttribute("bookmap");
                    status = (String[]) sess.getAttribute("bookmap");
                    boolean isToday = (Boolean)session.getAttribute("isToday");
                    Date date = new Date();
                    int hour = date.getHours();
                    for (int i = 0; i < status.length; i++) {
                        if (isToday && (i + 8)<= hour)
                        {
                            status[i] = "UnAvailable";
                        }
                %>      
            <tr>
                <td><%=arr[i]%></td>
                <td><%=status[i]%></td>
                <%if (loggedInUser != null){%>
                <%if (isToday && (i + 8) <= hour){%>
                <td style="background-color: #ff9999"> <input class="booking-slot" type="radio" name="slot" value=<%=(i + 8)%> disabled> UnAvailable </td>
                <%} else if (status[i].equals("Available")) {%>
                    <td style="background-color: #ccffcc"> <input class="booking-slot" type="radio" name="slot" value=<%=(i + 8)%> > Book Slot </td>
                    <% } else {%>
                <td style="background-color: #ff9999"><input class ="booking-slot" type="radio" name="slot" value=<%=(i + 8)%> disabled >Unavailable</td>
                    <%
                    }
                }
                    %>
            </tr>
            <%
                    }
            %>
        </table>
        <%if (loggedInUser != null){%>
        <button type="button" class="btn btn-success btn-large make-booking" onclick="book();">Make booking </button>
        <%}else{%>
        <h1>Please login to proceed to booking</h1>
        <%}%>
    </form>
</div>