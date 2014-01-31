<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*, db.DBConnection,java.sql.* ;"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Start Exam</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-theme.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-theme.min.css" rel="stylesheet"
	type="text/css">
<link href="css/style.css" rel="stylesheet" type="text/css">
<style>
		body{
			-user-select: none;
			-webkit-touch-callout: none;
			-webkit-user-select: none;
			-khtml-user-select: none;
			-moz-user-select: none;
			-ms-user-select: none;
			user-select: none;	
		}
		.examinfo td:nth-child(3),.examinfo td:nth-child(7),.examinfo td:nth-child(11){
			color:yellow;
		}
		.examinfo td:nth-child(15),.examinfo td:nth-child(19){
			color:orange;
		}
		.indx{
			width:50px; 
			height:25px; 
			display:inline-block; 
			font-weight:bold; 
			margin-bottom:4px; 
			border-radius:3px; 
			border:1px solid #000000; 
			background-color: orange; 
			cursor:pointer;
			padding:2px;
			text-align: left;
			color:#000000;
			text-decoration: none;
		}
		.indx:hover{
			background-color: olive;
			color: #ffffff;
			border:1px solid #000000;
		}
	</style>
	<script type="text/javascript">
		function winresize(){
			var h1 = document.getElementById("navigator").clientHeight;
			var h2 = document.getElementById("examinfoholder").clientHeight;
			var h3 = document.getElementById("innerfooter").clientHeight;
			var w1 = window.innerHeight;
			var fh = w1-(h1+h2+h3+2);
			if(fh > 520){
				document.getElementById("queindex").style.height = fh+"px";
				document.getElementById("quepanel").style.height = fh+"px";
			}else{
				document.getElementById("queindex").style.height = "520px";
				document.getElementById("quepanel").style.height = "520px";
			}
		}
	</script>
</head>
<%

int id=(Integer)session.getAttribute("sId");


if(session.getAttribute("sId")==null){
	response.sendRedirect("login.jsp?s=false");
}
ArrayList  arr=new ArrayList();
arr=DBConnection.populateStudentDetails(id);

 int exam_id=(Integer)session.getAttribute("examId");
String exam_sessId=DBConnection.sessionRandomFunction();
session.setAttribute("examSessionId", exam_sessId);


%>
<body>
<div id="back" style="width:100%; position: absolute; z-index:1; min-width: 1000px; height:101%;">

		<nav id="navigator" class="navbar navbar-default" role="navigation" style="min-width: 1000px; margin-bottom:2px;" >
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">ExamCMS</a>
		</div>
		
		 <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" style="background-color:#F1EEEE">
			 <ul class="nav navbar-nav navbar-right">
				<li><a href="#">Home</a></li>
			 </ul>		
		</div><!-- /.navbar-collapse -->
	</nav>
	
	<div id="bodypart" style="margin:0px auto; width:950px;">
		<div id="examinfoholder" style="margin:0px auto; padding:5px 0px; width:950px;  background-color:rgba(55,55,55,0.5); border-radius:5px; text-align:center; color:#ffffff; font-weight:bold;">
				<table class="examinfo" style="margin:0px auto; display:inline-block;">
					<tr>
						<td>NAME:</td><td>:</td><td><%=arr.get(0) %> <%=arr.get(1) %></td><td>&nbsp;&nbsp;|&nbsp;&nbsp;</td>
						<td>Student ID:</td><td>:</td><td><%=id %></td><td>&nbsp;&nbsp;</td>
					</tr>
					
				</table>
				
		</div>
		<div style="margin:0px auto; width:950px; background-color: #ffffff; margin-left: 3px;  display:inline-block; vertical-align: top; ">
		
		<div style="margin-left:220px ; display:inline-block;"><b>INSTRUCTIONS TO THE CANDIDATES to be Read out by Invigilators in the EXAM HALL</b>
		</div>
		<ul>
		<li>Candidates should carefully enter the Hall ticket number</li><br/>
		<li>Candidates should carefully read and follow the instructions given on the first page after entering the hall ticket number</li><br/>
		<li>Candidate should check his/her name and hall ticket number being displayed on the screen. In case of any discrepancy, it should be reported immediately and candidate should not close the browser</li><br/>
		<li>Candidates should ensure that they have marked their attendance and also recorded the session id on the attendance sheet. Any other session id which has not been mentioned in the attendance sheet would not be considered and all responses on that session id would be treated as null and void.
		</li><br/>
		<li>Every Section has objective-type questions or true/false statements. Each objective-type question has four choices of which only one is correct and true/false statement has two options in which only one is correct . Candidate should select the radio button, given below the question, corresponding to his/her correct choice. 
		</li><br/>
		<li>Each question consists of different marks according to hardness level.
		</li><br/>
		<li>Candidates are not allowed to use any books, logarithmic tables, calculators, mobile phones, or any other electronic gadgets in the exam hall.
		</li><br/>
		<li>
		Candidate will be provided with only one(1) sheet of paper for rough work. Candidates should note down Name, hall ticket number and session id on the rough sheet immediately.
		
		</li>
		<div style=" float:right; margin-right:50px;"><input type="button" value="CONTINUE" class="btn btn-info" onclick="window.top.location='exam.jsp?examId=<%=exam_id %>';"/> </div><br/><br/><br/>
		</ul>
		
		</div>
	
		<div id="innerfooter" style="margin:0px auto; padding:5px 0px; width:950px;  background-color:rgba(55,55,55,0.5); border-radius:5px; text-align:center; color:#ffffff; font-weight:bold;">
				<table style="margin:0px auto; display:inline-block;">
					<tr>
						
					</tr>
				</table>
		</div>
	</div>
</div>

</body>
</html>

