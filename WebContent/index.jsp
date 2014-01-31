<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*,db.DBConnection"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import=" java.io.FileNotFoundException"%>
<%@ page import=" java.io.FileReader"%>
<%@ page import=" java.io.IOException"%>
<%@ page import=" org.json.simple.parser.ParseException"%>
<%

JSONParser parser = new JSONParser();
String UniversityName="";
String AboutUniversity="";
String ImagePath1="";
String Label1="";
String Description1="";

String ImagePath2="";
String Label2="";
String Description2="";

String ImagePath3="";
String Label3="";
String Description3="";
try {
	String serverPath= request.getServletContext().getRealPath("");
	 
	 JSONObject person = (JSONObject) parser.parse(new FileReader(serverPath+"\\js\\homepage.json"));

	    UniversityName = (String) person.get("UniversityName");
	    System.out.println(UniversityName);

	    AboutUniversity = (String) person.get("AboutUniversity");
	    System.out.println(AboutUniversity);

	    ImagePath1 = (String) person.get("ImagePath1");
	    System.out.println(ImagePath1);
	    
	    Label1 = (String) person.get("Label1");
	    System.out.println(Label1);
	    
	    Description1 = (String) person.get("Description1");
	    System.out.println(Description1);
	    
	    ImagePath2 = (String) person.get("ImagePath2");
	    System.out.println(ImagePath2);
	    
	    Label2 = (String) person.get("Label2");
	    System.out.println(Label2);
	    
	    Description2 = (String) person.get("Description2");
	    System.out.println(Description2);
	    
	    
	    ImagePath3 = (String) person.get("ImagePath3");
	    System.out.println(ImagePath3);
	    
	    Label3 = (String) person.get("Label3");
	    System.out.println(Label3);
	    
	    Description3 = (String) person.get("Description3");
	    System.out.println(Description3);
	  
}

catch (FileNotFoundException e) {
	e.printStackTrace();
} catch (IOException e) {
	e.printStackTrace();
} catch (ParseException e) {
	e.printStackTrace();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><% %></title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-theme.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-theme.min.css" rel="stylesheet"
	type="text/css">
<link href="css/style.css" rel="stylesheet" type="text/css">

 <link rel="stylesheet" href="calendarview.css">
    <style>
    #calenderView{
    		mar
    }
      body {
        font-family: Trebuchet MS;
      }
      div.calendar {
       width: 200px;
        max-width: 300px;
        margin-left: auto;
        margin-right: auto;
      }
      div.calendar table {
        width: 100%;
      }
      div.dateField {
        width: 140px;
        padding: 6px;
        -webkit-border-radius: 6px;
        -moz-border-radius: 6px;
        color: #555;
        background-color: white;
        margin-left: auto;
        margin-right: auto;
        text-align: center;
      }
      div#popupDateField:hover {
        background-color: #cde;
        cursor: pointer;
      }
    </style>
    <script src="prototype.js"></script>
    <script src="calendarview.js"></script>
    <script>
      function setupCalendars() {
        // Embedded Calendar
        Calendar.setup(
          {
            dateField: 'embeddedDateField',
            parentElement: 'embeddedCalendar'
          }
        )

        // Popup Calendar
        Calendar.setup(
          {
            dateField: 'popupDateField',
            triggerElement: 'popupDateField'
          }
        )
      }

      Event.observe(window, 'load', function() { setupCalendars() })
    </script>

</head>


<body>
	<div id="" style="width: 100%; height: 100%; z-index: 1;">

		<nav class="navbar navbar-default" role="navigation"
			style="margin-bottom:0px;"> <!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#"><%=UniversityName %></a> <a
				class="navbar-brand"></a>
		</div>


		</nav>
		<div style="margin: 0px auto; min-width: 1000px;">
			<div id="carousel-example-captions" class="carousel slide"
				data-ride="carousel">
				<ol class="carousel-indicators">
					<li data-target="#carousel-example-captions" data-slide-to="0"
						class="active"></li>
					<li data-target="#carousel-example-captions" data-slide-to="1"
						class=""></li>
					<li data-target="#carousel-example-captions" data-slide-to="2"
						class=""></li>
				</ol>
				<div class="carousel-inner"
					style="border: 1px solid #000; margin: 0px auto; max-width: 1600px; height: 300px;">
					<% 
		 if(ImagePath1.equals("true"))
		 {
		
		%>

					<div class="item active">
						<img src="SliderImages/img1.jpg" alt=""
							style="width: 100%; height: 300px; max-width: 1600px;" />
						<div class="carousel-caption">
							<h3><%=Label1 %></h3>
							<p><%=Description1 %></p>
						</div>
					</div>
					<%}
		 else{
			 %>
					<div class="item active">
						<img src="images/2.jpg" alt=""
							style="width: 100%; height: 300px; max-width: 1600px;" />
						<div class="carousel-caption">
							<h3><%=Label1 %></h3>
							<p><%=Description1 %></p>
						</div>
					</div>
					<%  }
		
		%>

					<% 
		 if(ImagePath2.equals("true"))
		 {
		
		%>
					<div class="item">
						<img src="SliderImages/img2.jpg" alt=""
							style="width: 100%; height: 300px; max-width: 1600px;" />
						<div class="carousel-caption">
							<h3><%=Label2 %></h3>
							<p><%=Description2 %></p>
						</div>
					</div>
					<%} %>

					<% 
		 if(ImagePath3.equals("true"))
		 {
		
		%>
					<div class="item">
						<img src="SliderImages/img3.jpg" alt=""
							style="width: 100%; height: 300px; max-width: 1600px;" />
						<div class="carousel-caption">
							<h3><%=Label3 %></h3>
							<p><%=Description3 %>.
							</p>
						</div>
					</div>

					<%} %>
				</div>
				<a class="left carousel-control" href="#carousel-example-captions"
					data-slide="prev"> <span
					class="glyphicon glyphicon-chevron-left"></span>
				</a> <a class="right carousel-control" href="#carousel-example-captions"
					data-slide="next"> <span
					class="glyphicon glyphicon-chevron-right"></span>
				</a>
			</div>
		</div>
		<div style="width: 100%; min-width: 1000px; margin: 10px;margin-left:48px;">
			<div style="width: 1000px; float: left;">

				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title" style="color: #000; font: weight:bold">ABOUT US</h3>
					</div>
					<div class="panel-body">
						<%=AboutUniversity %>

					</div>


				</div>

			</div>
			<div style="width: 240px; float: left; margin-left: 20px;">

				<div class="well well-lg" style="height: 200px;">
					<h5>
						<b>SIGN IN</b>
					</h5>
					Already registered users sign in here to access their profile.</br> <input
						type="submit" class="btn btn-info" value="Login"
						onclick="window.top.location='login.jsp'" />
					
				</div>

			</div>
		</div>

		<div style="width: 100%; min-width: 1000px;margin: 10px;margin-left:48px;">
			<div style="width: 1000px; float: left;">

				<div class="panel  panel-info">
					<div class="panel-heading">
						<h3 class="panel-title" style="color: #000; font: weight:bold">UPCOMING
							EXAM</h3>
					</div>
					<div class="panel-body">
						<table class="table table-hover"
							style="background-color: #fff; border-radius: 3px;">
							<thead>
								<tr>
									<th>Subject</th>
									<th>Exam Date</th>
									
									<th>Venue</th>

								</tr>
							</thead>
							<tbody>
								<% 
			     String sql="select * from examinfo";
				 ResultSet rs= DBConnection.getObject().selectQuery(sql); 
				
				
				 while(rs.next())
				 {
					 String arr[]= rs.getString("exam_date").split(" ");
				  %>
				              
								<tr>
									<td><%=rs.getString("subject") %></td>
									<td><%=arr[0]%></td>
									<td><%=rs.getString("venue")%></td>
								</tr>

								<% 
				}
			 
			  %>
							</tbody>
						</table>
					</div>


				</div>

			</div>
			<div style="width: 240px; float: left; margin-left: 20px;">

				<div class="panel  panel-info">
					<div class="panel-heading">
						<h3 class="panel-title" style="color: #000; font: weight:bold">Calendar</h3>
					</div>
					<div class="panel-body">
						<div id="calenderView" style="width: 50%">
        <div id="embeddedExample" style="">
          <div id="embeddedCalendar" style="margin-left: auto; margin-right: auto">
          </div>
        </div>
        </div>

					</div>


				</div>

			</div>
		</div>

	</div>
</body>
<script src="https://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/carousel.js"></script>
<script type="text/javascript" src="js/script.js"></script>
  <script src="prototype.js"></script>
    <script src="calendarview.js"></script>
</body>
</html>