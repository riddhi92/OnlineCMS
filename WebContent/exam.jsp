<%@page import="java.sql.ResultSet"%>
<%@page import="db.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Exam</title>
	<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
	<link href="css/bootstrap-theme.css" rel="stylesheet" type="text/css">
	<link href="css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
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
	
%>
<body onresize="winresize();" onload="winresize();">
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
			<a class="navbar-brand" href="#">CMS(online Exams)</a>
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
						<td>Attempted</td><td>:</td><td>0</td><td>&nbsp;&nbsp;|&nbsp;&nbsp;</td>
						<td>Review</td><td>:</td><td>0</td><td>&nbsp;&nbsp;|&nbsp;&nbsp;</td>
						<td>Unattempted</td><td>:</td><td>All</td><td>&nbsp;&nbsp;|&nbsp;&nbsp;</td>
					</tr>
				</table>
				<table class="examinfo" style="margin:0px auto; display:inline-block;">
					<tr>
						<td>ID</td><td>:</td><td>130840320004</td><td>&nbsp;&nbsp;|&nbsp;&nbsp;</td>
						<td>TIMELEFT</td><td>:</td><td>-:--</td>
					</tr>
				</table>
		</div>
		<div style="margin:0px auto; width:950px;">
			<div id="queindex" style="display:inline-block; margin:0px auto; width:200px; vertical-align: top;  height: 520px; background-color: #ffffff; margin-left: 3px;">
				<div id="indexholder" style="margin:10px auto; width:180px; padding:6px 0px 0px 0px; min-height:300px; max-height:500px; overflow:auto; border-radius:5px; border:5px solid #A2A2A2; ">
					<center>
					<%//Generate Question Indexes
					ResultSet rs1 = DBConnection.selectQuery("select count(*) CNT from qbank where type='mcq'");
					if(rs1.next()){	
						int j = rs1.getInt("CNT");
						for(int i = 1; i <= j; i++){
					%>
						<a href="#<%=i %>"><div class="indx"><%=i %></div></a>
					<%
						}
					}
					%>
					</center>
				</div>
			</div>
			<div id="quepanel" style="display:inline-block; margin:0px auto; padding:2px; width:740px; vertical-align: top; overflow-y:scroll;  height: 520px; background-color: #ffffff; margin-right: -3px;">
				<%
					ResultSet rs = DBConnection.selectQuery("select * from qbank where type='mcq' order by qid");
					int i = 0;
					while(rs.next()){
						i++;
				%>		
				<div id="<%=i %>" style="width:720px; border:0px;">
					<a href="#<%=i %>"></a>
					<div style="background-image: url('que_images/<%=rs.getString("QID") %>.jpg'); background-repeat:no-repeat; height:35px; width:710px; margin-left: 10px;"></div>
					<div style="text-align: center; width:45px; z-index:200; background-color: orange; font-size: 22px; padding:2px; padding-right:5px; border: 1px solid; border-bottom-right-radius: 30px; border-top-right-radius: 30px;"><%=i %></div>
					<div style="margin-top: -37px; z-index: 199; height: 100px;">
						<div style="width:700px; margin-left: 20px; font-weight: bold; font-size: 13px;">
							<table style="width:650px; margin-left:50px; min-height:100px; text-align: left;">
								<tr><td style=" padding: 10px;"><input type="radio" name="q<%=i %>" value="A" />&nbsp;<%=rs.getString("OPT1") %></td><td style=" padding: 10px;"><input type="radio" name="q<%=i %>"  value="B" />&nbsp;<%=rs.getString("OPT2") %></td></tr>
								<tr><td style=" padding: 10px;"><input type="radio" name="q<%=i %>" value="C" />&nbsp;<%=rs.getString("OPT3")%></td><td style=" padding: 10px;"><input type="radio" name="q<%=i %>" value="D" />&nbsp;<%=rs.getString("OPT4") %></td></tr>
							</table>
						</div>
					</div>
				</div>
				<hr/>
				<%		
					}
				%>
			</div>
		</div>
		<div id="innerfooter" style="margin:0px auto; padding:5px 0px; width:950px;  background-color:rgba(55,55,55,0.5); border-radius:5px; text-align:center; color:#ffffff; font-weight:bold;">
				<table style="margin:0px auto; display:inline-block;">
					<tr>
						<td><a href="" style="color:#ffffff;" target="_blank">Instructions</a></td><td>&nbsp;&nbsp;|&nbsp;&nbsp;</td>
						<td><a href="" style="color:#ffffff;" target="_blank">Help</a></td>
					</tr>
				</table>
		</div>
	</div>
</div>
</body>
</html>