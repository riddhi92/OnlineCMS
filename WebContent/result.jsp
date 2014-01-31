<%@ page language="java" errorPage="error.jsp" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*, db.DBConnection,java.sql.* ;"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Result Page</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-theme.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body>



<%!
	String msgerr = "";
	String msgsuc = "";
	String msg="";
%>
<%
	
	int id=(Integer)session.getAttribute("sId");
   String pwd=(String)session.getAttribute("newPwd"); 

if(session.getAttribute("sId")==null){
	response.sendRedirect("login.jsp?s=false");
}
	
	
	ArrayList  arr=new ArrayList();
	arr=DBConnection.populateStudentDetails(id);
	

	
	if(request.getParameter("f") != null){
		msg = request.getParameter("f");
		if(msg.equals("1")){
			msgsuc = "Details updated successfully";
		}else if(msg.equals("0")){
			msgerr = "Details not updated successfully";
		}
	}

  
%>
<script type="text/javascript" >
function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}

function check()
{
        if (getUrlVars()["t"] == undefined) 
        {
        	document.getElementById("myTab").childNodes[3].className = "";
       		document.getElementById("myTab").childNodes[1].className = "active";
       		document.getElementById("home").className = "tab-pane fade active in";
       		document.getElementById("profile").className = "tab-pane fade";
        }
        else
       	{
        	document.getElementById("myTab").childNodes[3].className = "active";
       		document.getElementById("myTab").childNodes[1].className = "";
       		document.getElementById("home").className = "tab-pane fade";
       		document.getElementById("profile").className = "tab-pane fade active in";
        }
}


function closeDiv()
{
	document.getElementById('infoDiv').style.display="none";
}

</script>
</head>
<body id="back" onload="check()">

<div  style="width:100%; height:100%;  z-index:1; min-width: 1000px;">
<nav class="navbar navbar-default" role="navigation" style="min-width: 1000px;" >
  <!-- Brand and toggle get grouped for better mobile display -->
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="#">ExamCMS</a>
    <a class="navbar-brand" href="#">Student Dashboard</a>
  </div>
  
   <div class="btn-group" style="float:right; padding-right:60px; margin-top:10px;">
  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" style="">
    <%=arr.get(0) %> <span class="caret"></span>
  </button>
  <form action="Logout" method="post" id="logout">
  	<input type="hidden" name="user" value="student" />
  </form>
  <ul class="dropdown-menu" role="menu" style="width:60px; ">
    <li><a href="#">Edit Account</a></li>
    <li><a href="#" onclick="logout.submit();">Logout</a></li>
  </ul>
</div>
</div>
</nav>
<% 
int exmid=(Integer)session.getAttribute("examId");
String examid = exmid+"";
ArrayList<Integer> resultarr=null;
if(examid!=null)
{
	try
	{
	 resultarr=DBConnection.processResult(5, id);
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
}
if(resultarr!=null)
{
%>
				 <table class="table table-hover" 

style="background-color:#fff; border-radius:3px;">
				 <tr>
				 <td style="width:150px;"><b>Student 

Id:</b></td><td><%=id %></td>
				 </tr>
				 <tr>
				 <td style="width:150px;"><b>Exam 

ID:</b></td><td><%=examid %></td>
				 </tr>
				 <tr>
				 <td style="width:150px;"><b>Total 

Marks:</b></td><td><%=resultarr.get(0) %></td>
				 </tr>
				 <tr>
				 <td 

style="width:150px;"><b>Marks:</b></td><td><%=resultarr.get(1) %></td>
				 </tr>
				 <tr>
				 <td 

style="width:150px;"><b>Percentage:</b></td><td><%=(resultarr.get

(1)*100)/resultarr.get(0) %>%</td>
				 </tr>
			     </table>
			<%}
else
{
%>   
	<div>
	
	<h6>No Result Available</h6>
	</div> 
	<%} %>
      <div>
    
      </div>
      
      
      
</body>
</html>