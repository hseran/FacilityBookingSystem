<%-- 
    Document   : contact
    Created on : 12 Apr, 2013, 4:31:07 PM
    Author     : naresh
--%>

<%@include file="../WEB-INF/jspf/header.jspf"%>

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span1"></div>
        <div class="span5">            
        <div class="hero-unit">
        <address>
        <strong>NTU Sports</strong><br>
        Nanyang Drive <br> 
        Jurong West,  415934 <br>
        <abbr title="Phone">P:</abbr> (65) 86574116
        </address>
        </div>
            <%
                String message = (String)request.getAttribute("updateMessage");
                if (message != null)
                {
            %>
            <strong><%=message%></strong>
            <%
                }
            %>
        </div>
        <div class="span5">
            <form action="submit-query" method="POST" id="query" class="form-horizontal">
            <fieldset>
          <legend>Submit Query</legend>
            <div class="control-group">
              <label class="control-label" for="name">Name *</label>
              <div class="controls">
                <input type="text" class="input-xlarge required" name="name" id="address1">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="phone">Contact Number *</label>
              <div class="controls">
                <input type="text" class="input-xlarge required tel" name="phone" id="address1">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="email">Email *</label>
              <div class="controls">
                <input type="text" class="input-xlarge required email" name="email" id="address1">
              </div>
            </div>
            <div class="control-group">
            <label class="control-label" for="query">Query *</label>
              <div class="controls">
                  <textarea cols="200" id="inquiry" name="query" rows="5" class="required"></textarea>
              </div>
            </div>
            <div class="form-actions">
                <button type="submit" id="submit" class="btn btn-primary btn-large">Submit</button>
                <button type="reset" class="btn">Cancel</button>
            </div>
          </fieldset>
        </form>
        </div>
    </div>
</div>
    <script type="text/javascript">
    $(document).ready(function(){
    $("#query").validate();    
    });    
    
//    $("#submit").click(postQuery);

    </script>
<%@include file="../WEB-INF/jspf/footer.jspf"%>