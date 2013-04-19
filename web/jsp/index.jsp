<%@include file="../WEB-INF/jspf/header.jspf"%>
<head>
    <style type="text/css">
        #back {background-image:url('img/SportsBackground.jpg');-moz-background-size: 100% 100%;
            -o-background-size: 100% 100%;
            -webkit-background-size: 100% 100%;
            background-size: 100% 100%;
            -moz-border-image: url(scale.jpg) 0;}
    </style>
    <!--[if lt IE 9]>
    <style type="text/css">
    #back{
          background-image:none; filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='img/SportsBackground.jpg', sizingMethod='scale');

    }
    </style>
    <![endif]-->
</head>
    <div class="container-fluid" id="back">
      <div class="row-fluid">
        <div class="span7">
                      
            <div class="hero-unit">
            <h1>NTU Sports</h1>
            <p> Just Play. Have Fun  </p>
            <br/>
            <br/>
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
            <br/>
            <br/>
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
            <div class="carousel slide" id="myCarousel">
                <ol class="carousel-indicators">
                  <li class="" data-slide-to="0" data-target="#myCarousel"></li>
                  <li data-slide-to="1" data-target="#myCarousel" class="active"></li>
                  <li data-slide-to="2" data-target="#myCarousel" class=""></li>
                  <li data-slide-to="3" data-target="#myCarousel" class=""></li>
                </ol>
                <div class="carousel-inner">
                  <div class="item">
                      <img height="500" width="700" alt="" src="img/table-tennis.jpg">
                    <div class="carousel-caption">
                      <h4>WTTF approved Table-Tennis boards</h4>
                    </div>
                  </div>
                  <div class="item active">
                    <img height="500" width="700" alt="" src="img/badminton.JPG">
                    <div class="carousel-caption">
                      <h4>Indoor Badminton courts</h4>
                    </div>
                  </div>
                <div class="item">
                    <img height="500" width="700" alt="" src="img/squash.jpeg">
                    <div class="carousel-caption">
                      <h4>Squash courts</h4>
                    </div>
                  </div>
                <div class="item">
                    <img height="500" width="700" alt="" src="img/lawn-tennis.jpg">
                    <div class="carousel-caption">
                      <h4>Outdoor grass Tennis courts</h4>
                    </div>
                  </div>
                </div>
                <a data-slide="prev" href="#myCarousel" class="left carousel-control">&lsaquo;</a>
                <a data-slide="next" href="#myCarousel" class="right carousel-control">&rsaquo;</a>
              </div>
          </div> <!--/row-->
                        <%}%>
        </div><!--/span-->
      </div><!--/row-->
<%@include file="../WEB-INF/jspf/footer.jspf"%>
