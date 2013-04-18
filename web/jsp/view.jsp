<%-- 
    Document   : select
    Created on : Apr 17, 2013, 3:22:51 AM
    Author     : blue
--%>

<%@include file="../WEB-INF/jspf/header.jspf"%>

<%!            String status[];
    Iterator iterator;
    String key;
    String obj;
    String arr[] = new String[]{"8 am - 9 am", "9 am - 10 am", "10 am - 11 am", "11 am - 12 am",
        "12 am - 1 pm", "1 pm - 2 pm", "2 pm - 3 pm", "3 pm - 4 pm ", "4 pm - 5 pm", "5 pm - 6 pm", "6 pm - 7 pm"};
%>
<div class="container" style="text-align: center;">
    <form  action="book" method="post">
        <table id ="testTable"  class="text-center table table-bordered " width="30%">
            <tr class="success">
                <th>Slot</th>
                <th>Status</th>
                <th>Update</th>

                <%
                    HttpSession sess = request.getSession();
                    //m = (Map<Integer, String>) sess.getAttribute("bookmap");
                    status = (String[]) sess.getAttribute("bookmap");
                    for (int i = 0; i < status.length; i++) {
                %>      
            <tr>
                <td><%=arr[i]%></td>
                <td><%=status[i]%></td>
                <% if (status[i].equals("Available")) {%>
                <td> <input type="checkbox" name="slot" value=<%=i%> > Book Slot </td>
                    <% } else {%>
                <td><input type="checkbox" checked name="slot" value=<%=i%> disabled >Unavailable</td>
                    <%}%>

            </tr>
            <%
                        }%>
        </table>
        <button type="submit" class="btn btn-success btn-large">Make booking </button>
    </form>
</div>    
<div class="text-center">
    <form  action="facility" method="post">
        <button type="submit" class="btn btn-warning btn-large">Back</button>
    </form>
</div>
<%@include file="../WEB-INF/jspf/footer.jspf"%>
