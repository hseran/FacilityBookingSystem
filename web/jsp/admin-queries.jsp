<%-- 
    Document   : admin-feedback
    Created on : 2 Apr, 2013, 6:35:21 PM
    Author     : naresh
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entity.UserQuery"%>
<%@include file="../WEB-INF/jspf/admin-header.jspf"%>

<%
    List<UserQuery> queryList = 
            (List<UserQuery>)request.getAttribute("queryList");
%>

<div class="container-fluid">
    <div class="row-fluid">
            <div class ="span3">
                <%@include file="../WEB-INF/jspf/admin-side-bar.jspf"%>
            </div>        
            <div class="span8">
                <p/><p/>
            <%
                for (UserQuery query : queryList)
                {
            %>
                    <div class="query">
                        <small>Is Resolved?</small> <input class ="query_status" type="checkbox" <%= query.getIsResolved()? "CHECKED" : "" %> id = "status_<%=query.getId()%>"/>
                        <div class="fo"> <small><span align ="left"> User: <em> <%= query.getUserName() + ", " + query.getEmail() %> </em></span>&nbsp;&nbsp;&nbsp;&nbsp;<span align ="right"> submitted on: <%= new SimpleDateFormat("yyyy-MM-dd").format(query.getSubmittedOn())%> </span></small></div>
                    <div><%= query.getQuery() %></div>
                    <br/><br/>
                    </div>
            <%
                }
            %>
            </div>
    </div>
</div>
    <script type="text/javascript">
    $(document).ready(function(){
    $(".query_status").click(updateResolutionStatus);
    });    
    
    function updateResolutionStatus(event)
    {
        var $that = $(this);
        var id = $that.attr("id");
        id = id.replace("status_", "");
        var checked = $(this).is(":checked");
        $.post("updateQueryStatus", {queryId:id, resolved:checked})
                .done (function(){
                    $that.closest("div.query").remove();
        });
    }
    
    </script>

<%@include file="../WEB-INF/jspf/footer.jspf"%>

