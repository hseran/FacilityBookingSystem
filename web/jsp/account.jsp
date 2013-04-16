<%-- 
    Document   : account
    Created on : 17 Mar, 2013, 12:10:11 PM
    Author     : naresh
--%>

<%@include file="../WEB-INF/jspf/header.jspf"%>

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span3"> <%@include file="../WEB-INF/jspf/account-side-bar.jspf"%> </div>        
        <div class="span8">
            <h1>Hi <%= loggedInUser.getName() %></h1>
            <br/>
            <p>You can use the adjacent links to update your account details and also to go through all your current and past bookings</p> 
        </div>
    </div>
</div>

<%@include file="../WEB-INF/jspf/footer.jspf"%>