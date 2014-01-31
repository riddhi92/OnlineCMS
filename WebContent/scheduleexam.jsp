<%@page import="db.DBConnection"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Schedule Exam</title>
	<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
	<link href="css/bootstrap-theme.css" rel="stylesheet" type="text/css">
	<link href="css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
	<link href="css/style.css" rel="stylesheet" type="text/css">
	
	<script>
		function modal(id)
		{
			
			document.getElementById("modaleid").value= document.getElementById(id).childNodes[1].innerHTML;
			document.getElementById("modaleid1").value= document.getElementById(id).childNodes[1].innerHTML;
			document.getElementById("modalsub").value= document.getElementById(id).childNodes[3].innerHTML;
			document.getElementById("modaledate").value= document.getElementById(id).childNodes[5].innerHTML;
			document.getElementById("modalvenue").value= document.getElementById(id).childNodes[7].innerHTML;
			document.getElementById("modalrdate").value= document.getElementById(id).childNodes[9].innerHTML;
			
		}
		
		function deleteexam(id)
		{
			document.getElementById("modaleidd").value= document.getElementById(id).childNodes[1].innerHTML;
		}
		
		function closeDiv()
		{
			document.getElementById('infoDiv').style.display="none";
		}
	
	</script>
	</head>
<% 
		String reg=request.getParameter("s");
		String del=request.getParameter("d");
		String eid="";
		String esub="";
		String evenue="";
		ResultSet rs = DBConnection.selectQuery("select * from scheduleExam");
	%>
<body>
	<!-- Button trigger modal -->	
	<!-- Modal -->
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    <form action="cancelExamController" method="post">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="myModalLabel">Cancel Exam</h4>
	      </div>
	      <div class="modal-body" style=" height:50px;">
		</div>
		<div style="margin-top:0px;"> <h4 class="modal-title" id="myModalLabel"><center>Are you sure you want to cancel exam?<center></center></h4>
		<input type="hidden" name="eidd" id="modaleidd" />
		</div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <input type="submit" class="btn btn-primary" value="Cancel">
	      </div>
	      </form>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    <form action="scheduleExamHandler" method="post">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="myModalLabel">Reschedule Of Exam</h4>
	      </div>
	      <div class="modal-body" style=" height:270px">
	    	<table class="table table-hover" style="background-color:#fff; border-radius:3px;">
			    <thead>
				    <tbody>
			    		<tr>
			    			<th>Exam id</th>
			    			<td><input type="text" class="form-control" style="width:170px;" id="modaleid" disabled/></td>
			    			<td><input type="hidden" name="eid" id="modaleid1" /></td>			    			
			    		</tr>
			    		<tr>
			    			<th>Subject</th>
			    			<td><input type="text" class="form-control" style="width:170px;" name="sub" id="modalsub" disabled/></td>	
			    		</tr>
			    		<tr>
			    			<th>Exam Date</th>
			    			<td> <input type="date"
								class="form-control" style="width:170px;"name="edate" id="modaledate" required ></td>			    			
			    		</tr>
			    		<tr>
			    			<th>Venue</th>
			    			<td><input type="text" class="form-control" style="width:170px;" name="venue" id="modalvenue"/></td>			    			
			    		</tr>
			    		<tr>
			    			<th>Result Date</th>
			    			<td><input type="date"
								class="form-control" style="width:170px;"name="rdate" id="modalrdate" required ></td>			
			    		</tr>
		       		</tbody>
			   </thead>
			</table>
		</div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="submit" class="btn btn-primary">Save changes</button>
	      </div>
	      </form>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	
	<div id="back" style="width:100%; height:100%; position: absolute; z-index:1;">
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
			  <a class="navbar-brand" >Schedule Of Exam</a>
		  </div>
		
		  <div class="btn-group" style="float:right; padding-right:60px; margin-top:10px;">
		  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" style="">
		    admin <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" role="menu" style="width:60px; ">
		    <li><a href="#">Edit Account</a></li>
		    <li><a href="#">Logout</a></li>  
		  </ul>
		</div>
		</nav>
		
<%if(reg!=null)
{
if(reg.equals("1"))
{
	%>
	<div  id="infoDiv" class="alert alert-success"  style="font-size: 18px;line-height: 1.5;"> <center>Exam rescheduled successfully!</center><span id="cross" style="float:right ;position: absolute;top: 70px; right: 15px; cursor:pointer;" onclick="closeDiv()" ><h3>X</h3></span></div>
	<%
}
else if(reg.equals("0"))
{
	%>
	<div  id="infoDiv" class="alert alert-success"  style="font-size: 18px;line-height: 1.5;"> <center>Exam rescheduling failed!</center><span id="cross" style="float:right ;position: absolute;top: 70px;right: 15px;  cursor:pointer;" onclick="closeDiv()" ><h3>X</h3></span></div>
	<%
}
} %>

<%if(del!=null)
{
if(del.equals("1"))
{
	%>
	<div  id="infoDiv" class="alert alert-success"  style="font-size: 18px;line-height: 1.5;"> <center>Exam deleted successfully!</center><span id="cross" style="float:right ;position: absolute;top: 70px; right: 15px; cursor:pointer;" onclick="closeDiv()" ><h3>X</h3></span></div>
	<%
}
else if(del.equals("0"))
{
	%>
	<div  id="infoDiv" class="alert alert-success"  style="font-size: 18px;line-height: 1.5;"> <center>Exam deletion failed!</center><span id="cross" style="float:right ;position: absolute;top: 70px;right: 15px;  cursor:pointer;" onclick="closeDiv()" ><h3>X</h3></span></div>
	<%
}
} %>
		
		<div style=" margin:0px auto; padding:50px; min-width:1000px; max-width:1000px; padding:20px;">
		<table class="table table-hover" style="background-color:#fff; border-radius:3px;">
		    <thead>
		       <tr>
		          <th>Exam Id</th>
		          <th>Subject</th>
		          <th>Exam Date</th>
				  <th>Venue</th>
				  <th>Result Date</th>
				  
		       </tr>
		    </thead>
		      <tbody>
		        <% 
		        ResultSet rs1 = DBConnection.selectQuery("select * from examinfo");
		        while(rs1.next()) {
		        	String edate[]=rs1.getString("exam_date").split(" ");
		        	String rdate[]=rs1.getString("result_date").split(" ");
		    		eid = rs1.getString("exam_id");
		    		esub = rs1.getString("subject");
		    		evenue = rs1.getString("venue");
		    		System.out.println(eid);
		    	%>	
		    	<tr id="<%=eid %>">
		            <td><%=eid %></td>
		            <td><%=esub %></td>
		            <td><%=edate[0] %></td>
		            <td><%=evenue %></td>
		            <td><%=rdate[0] %></td>
					<td><button class="btn btn-info " data-toggle="modal" data-target="#myModal" id="<%=eid%>" onclick="modal(<%=eid%>)">
		  			Reschedule
					</button></td>
					<td>
					<button class="btn btn-danger" data-toggle="modal" data-target="#myModal2" style="margin-left:20px;" id="<%=eid%>"  onclick="deleteexam(<%=eid%>)">
		  			Cancel
					</button></td>
		        </tr>
		   <%  } %>     
		       </tbody>
		      </table>
		</div>
	
	</div>
</body>
<script src="js/jquery.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
</html>