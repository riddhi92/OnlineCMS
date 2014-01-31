<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,db.DBConnection"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DashBoard</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-theme.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
<link href="css/style.css" rel="stylesheet" type="text/css">
<script>
function closeDiv()
{
	document.getElementById('infoDiv').style.display="none";
}
</script>
</head>
<%!
	String msg = "";
%>
<%

Boolean validateResult=(Boolean)session.getAttribute("login_success");
if(validateResult==null){
	response.sendRedirect("admin_login.jsp?s=false");
}
String admin_name=(String)session.getAttribute("admin_name");
String reg=request.getParameter("status");

%>
<body>
<div id="back" style="width:100%; height:100%;  z-index:1;">

<nav class="navbar navbar-default" role="navigation" >
  <!-- Brand and toggle get grouped for better mobile display -->
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="#">CMS(online Exams)</a>
	
	 <a class="navbar-brand" >Dashboard</a>
  </div>

  
  <div class="btn-group" style="float:right; padding-right:60px; margin-top:10px;">
  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" style="">
    <%=admin_name %> <span class="caret"></span>
  </button>
  <form action="Logout" method="post" id="logout">
  	<input type="hidden" name="user" value="admin" />
  </form>
  <ul class="dropdown-menu" role="menu" style="width:60px; ">
    <li><a href="#">Edit Account</a></li>
    <li><a href="#" onclick="logout.submit();">Logout</a></li>
  </ul>
</div>
</nav>
<%if(reg!=null)
{
if(reg.equals("t_success"))
{
	%>
	<div  id="infoDiv" class="alert alert-success"  style="font-size: 18px;line-height: 1.5;"> <center>Teachers Registration Successfully done!</center><span id="cross" style="float:right ;position: absolute;top: 70px; right: 15px; cursor:pointer;" onclick="closeDiv()" ><h3>X</h3></span></div>
	<%
}
else if(reg.equals("s_success"))
{
	%>
	<div  id="infoDiv" class="alert alert-success"  style="font-size: 18px;line-height: 1.5;"> <center>Student accounts created successfully!</center><span id="cross" style="float:right ;position: absolute;top: 70px;right: 15px;  cursor:pointer;" onclick="closeDiv()" ><h3>X</h3></span></div>
	<%
}
else if(reg.equals("exam_success"))
{
	%>
	<div  id="infoDiv" class="alert alert-success"  style="font-size: 18px;line-height: 1.5;"> <center>Exam Paper created successfully!</center><span id="cross" style="float:right ;position: absolute;top: 70px;right: 15px;  cursor:pointer;" onclick="closeDiv()" ><h3>X</h3></span></div>
	<%
}

} %>
 
<div style=" margin:0px auto; padding:50px; min-width:1000px; max-width:1000px; padding:20px;">
	<div style="width:220px;  display:inline-block; min-width:220px" >
		
        <div class="list-group">
		  <a href="#" class="list-group-itemleft active">
			DashBoard
		  </a>
		  <a href="HomePageSetting.jsp" class="list-group-itemleft">Home Page Settings</a>
		
		</div>
		
	</div>
	
	
	<div style=" width:530px; display:inline-block;vertical-align: top">
		 <div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title">Organization Information</h3>
			  </div>
			  <div class="panel-body">
			 <% 
			 String total_student="";
			 String total_teacher="";
			 DBConnection obj1 = DBConnection.getObject();
				 ResultSet rs1= obj1.getTotalStudent();
			 if(rs1.next())
			 {
				  total_student=rs1.getString("countval");
			 }
			 ResultSet rs2= obj1.getTotalteacher();
			 if(rs2.next())
			 {
				  total_teacher=rs2.getString("countval");
			 }
				%>
				<b> Registered Total student :<%=total_student %></b><br>
				<b> Registered Total Teacher:<%=total_teacher %></b>
			  </div>
		       <div class="panel-heading">
				<h3 class="panel-title">Available Exam</h3>
			  </div>
			  <div class="panel-body">
			 <table class="table table-hover" style="background-color:#fff; border-radius:3px;">
			    <thead>
          <tr>
            <th>Subject</th>
            <th>Exam Date</th>
            <th>Hardness Level</th>
			<th>Venue</th>
			<th>Result</th>
		
          </tr>
        </thead>
			  <tbody>
				 <% 
				 DBConnection obj= DBConnection.getObject();
			     String sql="select * from examinfo";
				 ResultSet rs= obj.selectQuery(sql); 
				
		        
				 while(rs.next())
				 { String arr[]= rs.getString("exam_date").split(" ");
				    int exam_id=rs.getInt("exam_id");
				   
				    String msg= obj.checkExamresult(exam_id); 
				   
				    	     
				    		
				 
				 %>
					  <tr>
			            <td><%=rs.getString("subject") %></td>
			            <td><%=arr[0]%></td>
			            <td><%=rs.getString("hardness")%></td>
			            <td><%=rs.getString("venue")%></td>
			            <td><%=msg %></td>
			           
			           </tr>
					 
				<% 
				}
				 rs.close();
			 
			  %>
			  </tbody>
			  </table>
			  </div>
		  
		 </div>
	 
	</div>
	
	<div style="width:200px;display:inline-block; float:right">
		<div class="list-group">
		  <a href="teacher_registration.jsp" class="list-group-item ">
			Create Teacher
		  </a>
		  <a href="createStudent.jsp" class="list-group-item">Create Student</a>
		  <a href="createexam.jsp" class="list-group-item">Create Exam</a>
		 
		</div>
	</div>
</div>
</div>
</body>
<script src="https://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>