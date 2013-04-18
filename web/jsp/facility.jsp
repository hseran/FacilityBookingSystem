<%-- 
    Document   : facility
    Created on : Apr 16, 2013, 4:01:38 PM
    Author     : blue
--%>

<%@page import="entity.FacilityInstances"%>
<%@include file="../WEB-INF/jspf/header.jspf"%>
<%!    
    int facilityId;
    String arr[];
%>
        <%
            Facility selFacility = (Facility) session.getAttribute("selectedFacility");
            facilityId = selFacility.getId();
            List<FacilityInstances> instances = selFacility.getFacilityInstancesList();
        %>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span1"></div>
        <div class="span4">
        <h1><%=selFacility.getName() %></h1>
        
        <form name="frmLogin" action="view" method="post" id="claim-form" >
            <fieldset>
            <div class="control-group">
              <label class="control-label" for="login">Select Court</label>
              <div class="controls">
                    <select name ="fid" id="fid">
                        <% for (FacilityInstances ins : instances){ %>
                        <option value="<%=ins.getId()%>"><%=ins.getName() %></option>
                        <% } %>
                    </select>
              </div>                    
            </div>
            <div class="control-group">
              <label class="control-label" for="postalcode">Date</label>
              <div class="controls">
                <input type="text" class="required" name ="datepicker" id="datepicker" />
              </div>
            </div>
            <div class="form-actions">
              <button type="submit" class="btn btn-primary btn-large">Check Availability</button>
              <button type="reset" class="btn">Cancel</button>
            </div>
        </fieldset>
        </form>
    </div>
    <div class="span7">
         <div id="booking-table">
         </div>
    </div>
    </div>
</div>
        <script type="text/javascript">
            $(document).ready(function() {
                $("#datepicker").datepicker({minDate:0, maxDate:6});
            });
        </script>

                        
<%@include file="../WEB-INF/jspf/footer.jspf"%>