<%-- 
    Document   : facility
    Created on : Apr 16, 2013, 4:01:38 PM
    Author     : blue
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../WEB-INF/jspf/header.jspf"%>
<%!    
    int facilityId;
    String selectedFacility, selectList;
    String arr[];
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Facility Booking</title>
        <script>
            $(function() {
                $("#datepicker").datepicker();
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function() {
                $("#tablediv").hide();
                $("#showTable").click(function(event) {

                    var dateval = $('#datepicker').val();
                    var fid = $('#fid').val();
                    $.post('PopulateTable', {fidval: fid, dval: dateval}, function(data) {
                        if (data == success)
                    });

                });
            });
        </script>
    </head>
    <body>
        <%
            Facility selFacility = (Facility) session.getAttribute("selectedFacility");

            facilityId = selFacility.getId();
            if (facilityId == 1) {
                selectedFacility = "Badminton";
                selectList = "SRC Badminton Court";


            } else if (facilityId == 2) {
                selectedFacility = "Squash";
                selectList = "SRC Squash Indoor Court";
            } else if (facilityId == 3) {
                selectedFacility = "Lawn Tennis";
                selectList = "Hall 11 Tennis Court";
            } else {
                selectedFacility = "Table Tennis";
                selectList = "SRC Table Tennis Court";
            }
            HttpSession sess = request.getSession();
            sess.setAttribute("facilitytype", facilityId);
        %>

        <div class="hero-unit">
            <h1><%=selectedFacility%> Facility Booking System</h1>
        </div>
        <form name="frmLogin" action="view" method="post" id="claim-form" >
            <div class="container">
                <div>
                    <a class="btn btn-primary ">
                        Select Court
                    </a><br/>
                    <select name ="fid" id="fid">
                        <option value=1><%=selectList%> 1</option>
                        <option value=2><%=selectList%> 2</option>
                        <option value=3><%=selectList%> 3</option>
                        <option value=4><%=selectList%> 4</option>
                    </select><br/>
                </div>
                <div>
                    <a class="btn btn-primary" >
                        Select Date
                    </a><br/>
                    <input type="text" name ="datepicker" id="datepicker" />
                </div>
                <div>
                    <button type="submit" class="btn btn-primary  btn-large">Check Availability</button>
                </div>
            </div>
        </form>
    </body>
</html>
<%@include file="../WEB-INF/jspf/footer.jspf"%>