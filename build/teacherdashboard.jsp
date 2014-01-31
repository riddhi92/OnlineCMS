<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Teacher DashBoard</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-theme.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
<link href="css/style.css" rel="stylesheet" type="text/css">
<%!
	String msg = "";
	String msg1 = "";
%>
<%
	if(request.getParameter("t") != null){
		msg = request.getParameter("t");
		if(msg.equals("invalid")){
			msg = "Username Password Mismatch!";
		}else if(msg.equals("false")){
			msg = "Please Login First";
		}
	}

	if(request.getParameter("s") != null){
		msg1 = request.getParameter("s");
		if(msg1.equals("invalid")){
			msg1 = "Username Password Mismatch!";
		}else if(msg1.equals("false")){
			msg1 = "Please Login First";
		}
	}
%>
<script type="text/javascript">
	function lcheck(){
		setTimeout("lchk()", 100);
	}

	function lchk(){
		var obj = new XMLHttpRequest();
		obj.open("GET", "CheckUserType.jsp", true);
		obj.onreadystatechange = function(){
			if(obj.readyState == 4 && obj.status == 200){
					var stat = obj.responseText;
					if(stat == "T"){
						window.top.location = "AddQuestions.jsp";
					}else if(stat == "S"){
						window.top.location = "studentDashBoard.jsp";
					}
			}
		};
		obj.send();
	}
</script>
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
</script>
</head>
<body onload="check(); lcheck();">

<div id="back" style="width:100%; height:100%; position: fixed; z-index:1; min-width: 1000px;">
<nav class="navbar navbar-default" role="navigation" style="min-width: 1000px;" >
  <!-- Brand and toggle get grouped for better mobile display -->
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="#">CMS(online Exams)</a>
  </div>
  
   <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" style="background-color:#F1EEEE">

    <ul class="nav navbar-nav navbar-right">
      <li><a href="#">Home</a></li>
      
    </ul>
	
  </div><!-- /.navbar-collapse -->
</nav>

  <div style="margin:0px auto;margin-left:100px; width:810px;"> 
  <ul class="nav nav-tabs" id="myTab" style=" width:400px; border:0px solid;">
  <li class="active" style=" width:200px;"><a href="#home" data-toggle="tab" style="color:#000;">Add Questions</a></li>
  <li style=" width:200px;"><a href="#profile" data-toggle="tab" style="color:#000;">Edit Questions</a></li>
  </ul>
  
<div class="tab-content" style="border:1px solid #ddd;width:810px;  border-radius:5px;">
	<div class="tab-pane fade in active" id="home" style="width:810px; height:211px; margin:0px auto;  margin-left:0px;" >
		<div style="position: absolute; color: #ff0000; text-align: center; width: 330px; font-weight: bold;"><%=msg1 %></div>
		
		
	</div>
	
	
	<div class="tab-pane fade" id="profile" style="width:810px; height:211px;  margin-left:0px;">
		<div style="position: absolute; color: #ff0000; text-align: center; width: 330px; font-weight: bold;"><%=msg %></div>
		
		
		
	</div>
</div>
</div>
</body>
<script src="https://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script src="js/tab.js" type="text/javascript"></script>
<%msg=""; %>
<%msg1=""; %>
</html>