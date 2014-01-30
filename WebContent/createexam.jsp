<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="db.DBConnection,java.sql.* ;"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Exam</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-theme.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-theme.min.css" rel="stylesheet"
	type="text/css">
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function  getTotalQuestion(id)
{
	var e = document.getElementById("selectSub");
	var strUser = e.options[e.selectedIndex].text;

	var xmlhttp;
	if (window.XMLHttpRequest)
	  {
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
		  
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		
	    var totalque =xmlhttp.responseText;
	    document.getElementById("maxquestion").innerHTML=totalque;
	    document.getElementById("totalque").max =totalque;
	    document.getElementById("totalque").disabled = false;
	    }
	  }
	xmlhttp.open("GET","gettotalquestion.jsp?sub_name="+strUser,true);
	xmlhttp.send();
}

</script>
</head>
<%
 String msg="";
	Boolean validateResult = (Boolean) session
			.getAttribute("login_success");
	if (validateResult == null) {
		response.sendRedirect("admin_login.jsp?s=false");

	}
	String admin_name = (String) session.getAttribute("admin_name");
	
	 
	ResultSet rs=DBConnection.selectQuery("select * from subject");
	System.out.println(rs);
	
	if(request.getParameter("status")!=null)
	{
		msg=request.getParameter("status");
		
		if(msg.equals("exam_fail")){
			msg = "exam info are not inserted properly";
		}
	
	}
	
%>
<body>
	<div id="back" style="width: 100%; height: 100%; z-index: 1;">

		<nav class="navbar navbar-default" role="navigation"> <!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">CMS(online Exams)</a> <a
				class="navbar-brand">Create Exam </a>
		</div>

		<div class="btn-group"
			style="float: right; padding-right: 60px; margin-top: 10px;">
			<button type="button" class="btn btn-default dropdown-toggle"
				data-toggle="dropdown" style="">
				
				 <%=admin_name %><span class="caret"></span>
			</button>
			<form action="Logout" method="post" id="logout">
				<input type="hidden" name="user" value="admin" />
			</form>
			<ul class="dropdown-menu" role="menu" style="width: 60px;">
				<li><a href="#">Edit Account</a></li>
				<li><a href="#" onclick="logout.submit();">Logout</a></li>
			</ul>
		</div>
		</nav>
<%if(msg!=null)
{
if(msg.equals("exam_fail"))
{
	%>
	<div  id="infoDiv" class="alert alert-success"  style="font-size: 18px;line-height: 1.5;"> <center>Teachers Registration Successfully done!</center><span id="cross" style="float:right ;position: absolute;top: 70px; right: 15px; cursor:pointer;" onclick="closeDiv()" ><h3>X</h3></span></div>
	<%
}
}
%>
<div style="margin: 0px auto; padding: 50px; min-width: 600px; max-width: 600px; padding: 20px;">

		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">Create Examination Paper</h3>
			</div>
			<div class="panel-body">

				<form role="form" action="CreateExamController" method="post">
					<div class="form-group">
						<label for="exampleInputEmail1">Subject</label> 
						<select class="form-control" id="selectSub" onchange="getTotalQuestion(this)" name="selectSub">
						<% 
							while(rs.next())
							{
							%>
           					<option value="<%=rs.getString("sub_name") %>"><%=rs.getString("sub_name") %></option>
							<%
							}
							%>
						</select>
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">Total no. of question</label>
						<br>
						 1<input type="range" id="totalque" name="totalque" min="1" max="10" style="width:490px;" onchange="document.getElementById('show').innerHTML = this.value;" disabled><span id="maxquestion">10</span><br/>
						
						<label for="exampleInputEmail1">Selected total question :   </label> <span id="show"></span>
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">Hardness level</label>
						<br>
						 1<input type="range" name="hardness" min="1" max="5" style="width:490px;" onchange="document.getElementById('show1').innerHTML = this.value;" >5
						 <br/>
						 
						 <label for="exampleInputEmail1">selected hardness :   </label> <span id="show1"></span>
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">Exam Date</label> <input
							type="date" class="form-control" name="exam_date"
							placeholder="enter date" required>
					</div>

					<div class="form-group">
						<label for="exampleInputPassword1">venue</label> <input
							type="text" class="form-control" name="venue"
							placeholder="Venue of exam" required>

					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">Result Date</label> <input
							type="date" class="form-control" name="result_date"
							placeholder="enter Result date" required>
					</div>
					<button type="submit" class="btn btn-info" style=" float: right;">Submit</button>
				</form>
			</div>
		</div>
	</div>
   </div>
</body>
<script src="https://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
</html>