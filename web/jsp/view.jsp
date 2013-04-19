<%-- 
    Document   : select
    Created on : Apr 17, 2013, 3:22:51 AM
    Author     : blue
--%>

<%@page import="entity.Customer"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%!            
    String status[];
    Iterator iterator;
    String key;
    String obj;
    String arr[] = new String[]{"8 am - 9 am", "9 am - 10 am", "10 am - 11 am", "11 am - 12 am",
        "12 am - 1 pm", "1 pm - 2 pm", "2 pm - 3 pm", "3 pm - 4 pm ", "4 pm - 5 pm", "5 pm - 6 pm", "6 pm - 7 pm"};
%>
<%
    Customer loggedInUser = (Customer)session.getAttribute("customer");
%>
<div style="text-align: center;">
    <form  action="book" method="post">
        <table id ="testTable"  class="text-center table table-bordered " width="30%">
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
                    <td> <input type="checkbox" name="slot" value=<%=i%> disabled> UnAvailable </td>
                <%} else if (status[i].equals("Available")) {%>
                <td> <input type="checkbox" name="slot" value=<%=i%> > Book Slot </td>
                    <% } else {%>
                <td><input type="checkbox" checked name="slot" value=<%=i%> disabled >Unavailable</td>
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
        <button type="submit" class="btn btn-success btn-large">Make booking </button>
        <%}else{%>
        <h1>Please login to proceed to booking</h1>
        <%}%>
    </form>
</div>