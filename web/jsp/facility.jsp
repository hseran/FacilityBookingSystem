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
        <div class="span3">
        <h1><%=selFacility.getName() %></h1>
        
        <form name="frmLogin" id="view-form" >
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
                <button type="button" class="btn btn-primary btn-large check-availability">Check Availability</button>
              <button type="reset" class="btn">Cancel</button>
            </div>
        </fieldset>
        </form>
    </div>
    <div class="span1"></div>
    <div class="span5">
         <div id="booking-table">
         </div>
    </div>
    <div class="span3">
    </div>
    </div>
</div>
<script type="text/javascript">
        $(document).ready(function() {
            $("#datepicker").datepicker({minDate:0, maxDate:3});
            $(".check-availability").click(checkAvailability);
            $("#view-form").validate();
        });
        //server-side date validation pending
        function checkAvailability()
        {
            var date = $.trim($("#datepicker").val());
            
            if (date === "")
            {
                alert("Please Select a Date to check Availablity");
            }
            
            var fac_ins_id = $.trim($("#fid").val());
            $.post("view", {datepicker:date, fid:fac_ins_id})
            .done (function(data){
                $("#booking-table").html(data);
            });
        }

        function book()
        {
            var selectedVal = "";
            var selected = $("#slots-table input[type='radio']:checked");
            if (selected.length > 0)
            {
                selectedValue = selected.val();
            }
            else
            {
                alert("Please select a slot for booking");    
            }
            $.post("book", {slot:selectedValue})
            .done (function(data){
                $("#booking-table").html(data);
            }).error(function(xhr, status, error)
            {
                $("#booking-table").html("<span class='label label-important'>ERROR</span> <span style='color:red'>"+ xhr.responseText +"</span>");
            });
        }

</script>

                        
<%@include file="../WEB-INF/jspf/footer.jspf"%>