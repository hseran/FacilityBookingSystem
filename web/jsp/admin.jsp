<%-- 
    Document   : admin
    Created on : 2 Apr, 2013, 5:04:34 PM
    Author     : naresh
--%>

<%@include file="../WEB-INF/jspf/admin-header.jspf"%>
    <div class="container-fluid">
      <div class="row-fluid">
          <div class="span3"></div>
        <div class="span6">
          <div class="hero-unit">
        <form style="margin: 0px" accept-charset="UTF-8" action="admin" method="post">
         <fieldset>
          <legend>Please Enter password to access Administration UI</legend>
            <!--div class="control-group">
              <label class="control-label" for="login">Login</label>
              <div class="controls">
                <input type="text" class="input-xlarge required" name="login" id="login">
              </div>
            </div-->
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

          </div>
          </div>
          <div class="span3">
          </div> <!--/row-->
        </div><!--/span-->
      </div><!--/row-->
<%@include file="../WEB-INF/jspf/footer.jspf"%>
