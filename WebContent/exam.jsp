<%@page import="java.util.ArrayList"%>
<%@page import="com.QuestionData"%>
<%@page import="process.RandomQuestions"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="db.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Random" %>

<%
	int id=(Integer)session.getAttribute("sId"); 
	
	if(session.getAttribute("sId")==null){
		response.sendRedirect("login.jsp?s=false");
	}
	String eid = request.getParameter("examId");
	int examId = Integer.parseInt(eid);
	//int question[] = null;
	ResultSet rs1 = DBConnection.selectQuery("select question from examinfo where exam_id="+eid); //<============ Till DB Connection error;
	String que = "";
	String strque[] = null;
	if(rs1.next())
	{
		que = rs1.getString("question"); 
	}
	strque = que.split(",");
	/* for(int i = 0; i < strque.length;i++)
	{
		question[i] = Integer.parseInt(strque[i]);
	} */
	int question[] = {1,2,3,4,5,6,7/* ,8,9,10,11,12,13,14,15,16 */};
	session.setAttribute("maxquestions", question.length);
	DBConnection.updateExamStatus(examId);
%>
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
	<script>
		var totalquestions = <%=question.length %>;
		var arr= new Array();
		var review = new Array();
		for(var i=0; i<totalquestions; i++)
		{
			arr[i] = 0;
			review[i] = 0;
		}
		function ajaxcall(qid,option)
		{
		 	if(option=="Flag")
			{
		 		var totalreview = 0;
		 		review[qid -1] = 1;
		 		for(var k = 0; k < totalquestions; k++)
				{
					totalreview += review[k];
				}
		 		document.getElementById("review").innerHTML = totalreview;
		 		document.getElementById("f"+qid).style.display = "none";
		 		document.getElementById("uf"+qid).style.display = "inline";
		 		document.getElementById("flg"+qid).style.display = "inline";
				return;
			}
		 	else if(option == "Unflag")
	 		{
		 		var totalreview = 0;
		 		review[qid -1] = 0;
		 		for(var k = 0; k < totalquestions; k++)
				{
					totalreview += review[k];
				}
		 		document.getElementById("review").innerHTML = totalreview;
		 		document.getElementById("f"+qid).style.display = "inline";
		 		document.getElementById("uf"+qid).style.display = "none";
		 		document.getElementById("flg"+qid).style.display = "none";
				return;
	 		}
			var xmlRequest = new XMLHttpRequest();
			xmlRequest.open("POST", "LogAnswer", true);
			xmlRequest.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlRequest.onreadystatechange = function()
			{
				if(xmlRequest.readyState == 2 )
				{
					document.getElementsByName("q"+qid)[0].disabled = true;
					document.getElementsByName("q"+qid)[1].disabled = true;
					document.getElementsByName("q"+qid)[2].disabled = true;
					document.getElementsByName("q"+qid)[3].disabled = true;
				}

				if(xmlRequest.readyState == 4)
				{
					if(xmlRequest.responseText == "ok" && xmlRequest.status == 200)
					{
						var total = 0;
						var flag = true;
						if(option=="Clear")
						{
							document.getElementsByName("q"+qid)[0].checked = false;
							document.getElementsByName("q"+qid)[1].checked = false;
							document.getElementsByName("q"+qid)[2].checked = false;
							document.getElementsByName("q"+qid)[3].checked = false;
							flag = false;
							arr[qid-1] = 0;
						}
						else
						{
							arr[qid-1] = 1;
						}
						
						for(var j = 0; j < totalquestions; j++)
						{
							total += arr[j]; 
						}
						
						document.getElementById("attemptd").innerHTML = total;
						document.getElementById("unattemptd").innerHTML = (totalquestions - total);
						if(flag)
							document.getElementById("crrt"+qid).style.display = "inline";
						else
							document.getElementById("crrt"+qid).style.display = "none";
						document.getElementsByName("q"+qid)[0].disabled = false;
						document.getElementsByName("q"+qid)[1].disabled = false;
						document.getElementsByName("q"+qid)[2].disabled = false;
						document.getElementsByName("q"+qid)[3].disabled = false;
					}
					else
					{
						document.getElementsByName("q"+qid)[0].checked = false;
						document.getElementsByName("q"+qid)[1].checked = false;
						document.getElementsByName("q"+qid)[2].checked = false;
						document.getElementsByName("q"+qid)[3].checked = false;
						document.getElementsByName("q"+qid)[0].disabled = false;
						document.getElementsByName("q"+qid)[1].disabled = false;
						document.getElementsByName("q"+qid)[2].disabled = false;
						document.getElementsByName("q"+qid)[3].disabled = false;
						
					}
				}
			};
			xmlRequest.send("qid="+qid+"&option="+option+"&total="+totalquestions);
		}
	</script>
</head>
<body onresize="winresize();" onload="winresize();">
<div id="back" style="width:100%; height:100%; position: fixed; z-index:-666; min-width: 1000px;">
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
						<td>Attempted</td><td>:</td><td><span id="attemptd">0</span></td><td>&nbsp;&nbsp;|&nbsp;&nbsp;</td>
						<td>Review</td><td>:</td><td><span id="review">0</span></td><td>&nbsp;&nbsp;|&nbsp;&nbsp;</td>
						<td>Unattempted</td><td>:</td><td><span id="unattemptd"><%=question.length %></span></td><td>&nbsp;&nbsp;|&nbsp;&nbsp;</td>
					</tr>
				</table>
				<table class="examinfo" style="margin:0px auto; display:inline-block;">
					<tr>
						<td>ID</td><td>:</td><td><%=id %></td><td>&nbsp;&nbsp;|&nbsp;&nbsp;</td>
						
					</tr>
				</table>
		</div>
		<div style="margin:0px auto; width:950px;">
			<div id="queindex" style="display:inline-block; margin:0px auto; width:200px; vertical-align: top;  height: 520px; background-color: #ffffff; margin-left: 3px;">
				<div id="indexholder" style="margin:10px auto; width:180px; padding:6px 0px 0px 0px; min-height:300px; max-height:500px; overflow:auto; border-radius:5px; border:5px solid #A2A2A2; ">
					<center>
					<%//Generate Question Indexes
					//ResultSet rs1 = DBConnection.selectQuery("select count(*) CNT from qbank where type='mcq'");
					String allquestions = question[0]+"";
					for(int i = 1; i <= question.length-1; i++)
						allquestions += ("," + question[i]);

					ResultSet rs = DBConnection.selectQuery("select qid, opt1, opt2, opt3, opt4, type from qbank where qid in ("+allquestions+")");

					int j = question.length;
					for(int i = 1; i <= j; i++)
					{
						%>
							<a href="#<%=i %>"><div id="indx<%=i %>" class="indx"><%=i %>&nbsp;<img id="crrt<%=i %>" src="images/correct.png" style="display: none;"/><img id="flg<%=i %>" src="images/flag_red.png" style="display: none;"/></div></a>
						<%
					}
					
					%>
					</center>
				</div>
			</div>
			<div id="quepanel" style="display:inline-block; margin:0px auto; padding:2px; width:740px; vertical-align: top; overflow-y:scroll;  height: 520px; background-color: #ffffff; margin-right: -3px;">
				<%
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
							<% if(rs.getString("type").equals("mcq"))
								{	
							%>
								<tr>
									<td style="padding:10px;"><input type="radio" name="q<%=i %>" id="A<%=i %>" value="A" onchange="ajaxcall(<%=i %>,this.value)" />&nbsp;<label for="A<%=i %>"><%=rs.getString("OPT1") %></label></td>
									<td style="padding:10px;"><input type="radio" name="q<%=i %>" id="B<%=i %>" value="B" onchange="ajaxcall(<%=i %>,this.value)"/>&nbsp;<label for="B<%=i %>"><%=rs.getString("OPT2") %></label></td>
								</tr>
								<tr>
									<td style=" padding: 10px;"><input type="radio" name="q<%=i %>" id="C<%=i %>" value="C"  onchange="ajaxcall(<%=i %>,this.value)" />&nbsp;<label for="C<%=i %>"><%=rs.getString("OPT3")%></label></td>
									<td style=" padding: 10px;"><input type="radio" name="q<%=i %>" id="D<%=i %>" value="D"  onchange="ajaxcall(<%=i %>,this.value)"/>&nbsp;<label for="D<%=i %>"><%=rs.getString("OPT4") %></label></td>
								</tr>
								<tr>
									<td colspan="2"><input type="button" value="Clear" onclick="ajaxcall(<%=i %>,this.value)"/>&nbsp;<input type="button" id="f<%=i %>" value="Flag" onclick="ajaxcall(<%=i %>,this.value)"/><input type="button" id="uf<%=i %>" value="Unflag" style="display:none;" onclick="ajaxcall(<%=i %>,this.value)"/></td>
								</tr>
							<%
								}
								else if(rs.getString("type").equals("tf"))
								{
							%>
								<tr>
									<td style="padding:10px;"><input type="radio" name="q<%=i %>" id="A<%=i %>" value="A" onchange="ajaxcall(<%=i %>,this.value)" />&nbsp;<label for="A<%=i %>">True</label></td>
									<td style="padding:10px;"><input type="radio" name="q<%=i %>" id="B<%=i %>" value="B" onchange="ajaxcall(<%=i %>,this.value)"/>&nbsp;<label for="B<%=i %>">False</label></td>
								</tr>
								<tr><td><input type="hidden" name="q<%=i %>" /></td><td><input type="hidden" name="q<%=i %>" /></td></tr>
								<tr>
									<td colspan="2"><input type="button" value="Clear" onclick="ajaxcall(<%=i %>,this.value)"/>&nbsp;<input type="button" id="f<%=i %>" value="Flag" onclick="ajaxcall(<%=i %>,this.value)"/><input type="button" id="uf<%=i %>" value="Unflag" style="display:none;" onclick="ajaxcall(<%=i %>,this.value)"/></td>
								</tr>
							<%
								}
							%>
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
						<td><button onclick="window.top.location = 'examresponse';">Save & End Exam</button></td>
					</tr>
				</table>
		</div>
	</div>
</div>
</body>
</html>