<%@include file="../WEB-INF/jspf/header.jspf"%>
    <div class="container-fluid">
      <div class="row-fluid">
        <div class="span8">
          <div class="hero-unit">
            <h1>NTU Sports Facility Booking System</h1>
            <p> Just Play. Have Fun  </p>
            
            <%
              /*
               * If user is not logged in, he might be a registered user, so 
               * display link to register
               * 
               */
              if (loggedInUser == null)
              {
            %>
            <p><a href="register" class="btn btn-primary btn-large">Sign up</a></p>
            <%
              }
              %>
          </div>
          </div>
            <%
              /*
               * If user is not logged in, he might be a registered user, so 
               * display link to register
               */
              if (loggedInUser == null)
              {
            %>
          <div class="span4">
            <form style="margin: 0px" accept-charset="UTF-8" action="login" method="post">
         <fieldset>
          <legend>Login Here</legend>
            <div class="control-group">
              <label class="control-label" for="login">Login</label>
              <div class="controls">
                <input type="text" class="input-xlarge required" name="login" id="login">
              </div>
            </div>
           <div class="control-group">
              <label class="control-label" for="password">Password</label>
              <div class="controls">
                <input type="password" class="input-xlarge required" name="password" id="password">
              </div>
            </div>
            <div class="form-actions">
              <button type="submit" class="btn btn-primary btn-large">Submit</button>
              <button type="reset" class="btn">Cancel</button>
            </div>

           </form>
          </div> <!--/row-->
                        <%}%>
        </div><!--/span-->
      </div><!--/row-->
<%@include file="../WEB-INF/jspf/footer.jspf"%>
