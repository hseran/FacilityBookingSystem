<%-- 
    Document   : register
    Created on : 13 Apr, 2013, 8:48:18 PM
    Author     : naresh
--%>

<%@include file="../WEB-INF/jspf/header.jspf"%>
<div class="container-fluid">
    
    <span id="message_register" align ="center"> </span>
        <form action="register" method="POST" id="signupform" class="form-horizontal" onsubmit="return validateLogin();">
        <fieldset>
          <legend>Register Here</legend>
            <div class="control-group">
              <label class="control-label" for="login">Login</label>
              <div class="controls">
                <input type="text" class="input-xlarge required" name="reg_login" id="reg_login">
              </div>
            </div>
           <div class="control-group">
              <label class="control-label" for="password">Password</label>
              <div class="controls">
                <input type="password" class="input-xlarge required" name="reg_password" id="reg_password">
              </div>
            </div>
           <div class="control-group">
              <label class="control-label" for="name">Name</label>
              <div class="controls">
                <input type="text" class="input-xlarge required" name="name" id="name">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="email">Email Address</label>
              <div class="controls">
                <input type="text" class="input-xlarge required email" name="email" id="email">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="phone">Phone</label>
              <div class="controls">
                <input type="text" class="input-xlarge required tel" name="phone" id="phone">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="address1">Address Line 1</label>
              <div class="controls">
                <input type="text" class="input-xlarge required" name="address1" id="address1">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="address2">Address Line 2</label>
              <div class="controls">
                <input type="text" class="input-xlarge" name="address2" id="address2">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="city">City</label>
              <div class="controls">
                <input type="text" class="input-xlarge required" name="city" id="city">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="province">Province</label>
              <div class="controls">
                <input type="text" class="input-xlarge" name="province" id="province">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="country">Country</label>
              <div class="controls">
                <input type="text" class="input-xlarge required" name="country" id="country">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="postalcode">Postal Code</label>
              <div class="controls">
                <input type="text" class="input-xlarge required digits" name="postalcode" id="postalcode">
              </div>
            </div>
            <div class="form-actions">
              <button type="submit" class="btn btn-primary btn-large">Submit</button>
              <button type="reset" class="btn">Cancel</button>
            </div>
          </fieldset>
        </form>    
</div>

    <script type="text/javascript">
    $(document).ready(function(){
    $("#signupform").validate();
    });    
    
    function validateLogin()
    {
        loginVal = $.trim($("#reg_login").val());
        if (loginVal != "")
        {
            val = $.ajax({url:"checkIDAvailablility", type:"POST", data:{login:loginVal}, async:false}).responseText;
            if (val === "false")
            {
                alert ("This login name is already in use. Please choose another login");
                return false;
            }
        }
        return true;
    }
    
    </script>
    
<%@include file="../WEB-INF/jspf/footer.jspf"%>