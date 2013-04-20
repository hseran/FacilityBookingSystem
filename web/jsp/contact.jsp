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
        <strong>NTU Sports and Recreation Centre</strong><br>
        20 Nanyang Green <br> 
        Singapore 637715 <br>
        <abbr title="Phone">Tel:</abbr> 6790 5168/5172<br>
        <abbr title="Fax">Fax:</abbr> 6791 1810<br>
        Email:<a href="mailto:srcgo@ntu.edu.sg">srcgo@ntu.edu.sg</a>
        </address>
        </div>
        </div>
        <div class="span5">
            <iframe width="500" height="255" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com.sg/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=20+Nanyang+Green+Singapore+637715&amp;aq=0&amp;oq=20+Nanyang+Green+Singapore+637715&amp;sll=1.349359,103.687989&amp;sspn=0.00724,0.013078&amp;g=Singapore+637715&amp;ie=UTF8&amp;hq=&amp;hnear=20+Nanyang+Green,+637715&amp;ll=1.349359,103.687989&amp;spn=0.00724,0.013078&amp;t=m&amp;z=16&amp;output=embed"></iframe>
        </div>
    </div>
     <div class="span1"></div>
     <div class="span7">
         <div id="updateMessage"></div>
        <form id="query-form" class="form-horizontal">
        <fieldset>
      <legend>Submit Query</legend>
        <div class="control-group">
          <label class="control-label" for="name">Name *</label>
          <div class="controls">
              <input type="text" class="input-xlarge required" id="name" name="name"  value='<%=loggedInUser == null? "": loggedInUser.getName()%>'>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="phone">Contact Number *</label>
          <div class="controls">
            <input type="text" class="input-xlarge required tel" id="phone" name="phone"  
                   value='<%=loggedInUser == null? "": loggedInUser.getPhone()%>'>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="email">Email *</label>
          <div class="controls">
            <input type="text" class="input-xlarge required email" id="email" name="email" value='<%=loggedInUser == null? "": 
                    loggedInUser.getEmail()%>'>
          </div>
        </div>
        <div class="control-group">
        <label class="control-label" for="query">Query *</label>
          <div class="controls">
              <textarea cols="200" id="query" name="query" rows="5" class="required"></textarea>
          </div>
        </div>
        <div class="form-actions">
            <button type="button" id="submit" class="btn btn-primary btn-large">Submit</button>
            <button id ="clear" type="reset" class="btn">Cancel</button>
        </div>
      </fieldset>
    </form>
    </div>
</div>

    <script type="text/javascript">
    $(document).ready(function(){
    $("#submit").click(postQuery);
    });    
    
    function postQuery()
    {
        if ($("#query-form").validate().form() === false)
        {
            return;
        }
        var nameVal = $("#name").val();
        var emailVal = $("#email").val();
        var phoneVal = $("#phone").val();
        var queryVal = $("#query").val();
        
        $.post("submit-query", {name:nameVal, email:emailVal, phone:phoneVal, query:queryVal})
            .done (function(){
                $("#updateMessage").html("<span class='label label-success'>Query Posted</span>. We will get in touch with you shortly");
                $("button#clear").click();
        }).error(function()
            {
                $("#updateMessage").html("<span class='label label-important'>Error!!</span>. Please try later");
            });

    }

    </script>
<%@include file="../WEB-INF/jspf/footer.jspf"%>