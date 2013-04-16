<%-- 
    Document   : editProfile
    Created on : 18 Mar, 2013, 9:10:32 PM
    Author     : naresh
--%>

<%@include file="../WEB-INF/jspf/header.jspf"%>

<%
    if (loggedInUser == null)
    {
        return;
    }
%>

<div class="container-fluid">
    <div class ="row-fluid">
            <div class ="span3">
                <%@include file="../WEB-INF/jspf/account-side-bar.jspf"%>
                <%
                    String updateMsg = (String)request.getAttribute("updateMessage");
                    if (updateMsg != null)
                    {
                %>
                <div class="success"><b><%= updateMsg %></b></div>
                <%
                    }
                %>
            </div>
        <div class="span9">
        <form action="editProfile" method="POST" id="profile" class="form-horizontal">
            <fieldset>
          <legend>Account Details</legend>
            <div class="control-group">
              <label class="control-label" for="login">Login</label>
              <div class="controls">
                    <%=loggedInUser.getUsername() %>
              </div>
            </div>
           <div class="control-group">
              <label class="control-label" for="password">Password</label>
              <div class="controls">
                  <input type="password" class="input-xlarge required" name="password" id="password">
              </div>
            </div>
           <div class="control-group">
              <label class="control-label" for="name">Name</label>
              <div class="controls">
                <input type="text" class="input-xlarge required" name="name" id="name" value="<%=loggedInUser.getName() %>">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="email">Email Address</label>
              <div class="controls">
                <input type="text" class="input-xlarge required email" name="email" id="email" value="<%=loggedInUser.getEmail() %>">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="phone">Phone</label>
              <div class="controls">
                <input type="text" class="input-xlarge required tel" name="phone" id="phone" value="<%=loggedInUser.getPhone() %>">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="address1">Address Line 1</label>
              <div class="controls">
                <input type="text" class="input-xlarge required" name="address1" id="address1" value="<%=loggedInUser.getAddressLine1() %>">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="address2">Address Line 2</label>
              <div class="controls">
                <input type="text" class="input-xlarge" name="address2" id="address2" value="<%=loggedInUser.getAddressLine2() %>">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="city">City</label>
              <div class="controls">
                <input type="text" class="input-xlarge required" name="city" id="city" value="<%=loggedInUser.getCity() %>">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="province">Province</label>
              <div class="controls">
                <input type="text" class="input-xlarge" name="province" id="province" value="<%=loggedInUser.getProvince() %>">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="country">Country</label>
              <div class="controls">
                <input type="text" class="input-xlarge required" name="country" id="country" value="<%=loggedInUser.getCountry() %>">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="postalcode">Postal Code</label>
              <div class="controls">
                <input type="text" class="input-xlarge required digits" name="postalcode" id="postalcode" value="<%=loggedInUser.getPostalCode() %>">
              </div>
            </div>
            <div class="form-actions">
              <button type="submit" class="btn btn-primary btn-large">Update</button>
              <button type="reset" class="btn">Cancel</button>
            </div>
          </fieldset>
        </form>    
        </div>
    </div>
</div>
    <script type="text/javascript">
    $(document).ready(function(){
    $("#profile").validate();
    });    
    </script>
    
<%@include file="../WEB-INF/jspf/footer.jspf"%>
