<%@page import="db.DBConnection"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Edit Question</title>
	<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
	<link href="css/bootstrap-theme.css" rel="stylesheet" type="text/css">
	<link href="css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
	<link href="css/style.css" rel="stylesheet" type="text/css">
	<script>
		function editmcq(id)
		{
				document.getElementById("modalqid").value=document.getElementById(id).childNodes[1].innerHTML;
				document.getElementById("modalqid1").value=document.getElementById(id).childNodes[1].innerHTML;
				document.getElementById("modalstat").value=document.getElementById(id).childNodes[7].innerHTML;
				document.getElementById("modalopt1").value=document.getElementById(id).childNodes[9].innerHTML;
				document.getElementById("modalopt2").value=document.getElementById(id).childNodes[11].innerHTML;
				document.getElementById("modalopt3").value=document.getElementById(id).childNodes[13].innerHTML;
				document.getElementById("modalopt4").value=document.getElementById(id).childNodes[15].innerHTML;
				document.getElementById("modalans").value=document.getElementById(id).childNodes[17].innerHTML;
				document.getElementById("modalqlevel").value=document.getElementById(id).childNodes[19].innerHTML;
				document.getElementById("modalmrks").value=document.getElementById(id).childNodes[21].innerHTML;
		
		}
		function edittf(id)
		{
			document.getElementById("mmodalqid").value=document.getElementById(id).childNodes[1].innerHTML;
			document.getElementById("mmodalqid2").value=document.getElementById(id).childNodes[1].innerHTML;
			document.getElementById("mmodalstat").value=document.getElementById(id).childNodes[7].innerHTML;
			var op=document.getElementById(id).childNodes[17].innerHTML;
			if(op=="T")
				document.getElementById("mmodalopt1").checked=true;
			else 
				document.getElementById("mmodalopt2").checked=true;
			document.getElementById("mmodalqlevel").value=document.getElementById(id).childNodes[19].innerHTML;
			document.getElementById("mmodalmrks").value=document.getElementById(id).childNodes[21].innerHTML;
			
		}
		
		function deleteq(id)
		{
			document.getElementById("mmodalqiddel").value=document.getElementById(id).childNodes[1].innerHTML;
			
			
		}
		function closeDiv()
		{
			document.getElementById('infoDiv').style.display="none";
		}
	
	</script>
	
</head>
<%
 String teacher_name=(String)session.getAttribute("t_name") ;
String reg=request.getParameter("s");
String del=request.getParameter("d");
%>

<% 
		int tid=(Integer)session.getAttribute("t_id");

		String qid="";
		String subject="";
		String type="";
		String statement="";
		String opt1="";
		String opt2="";
		String opt3="";
		String opt4="";
		String ans="";
		String qlevel="";
		String marks="";
		String tname="";
		 
		
	
%>
<body>
	<!-- Button trigger modal -->	
	<!-- Modal -->
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    <form action="deleteQuestionController" method="post">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="myModalLabel">Delete Question</h4>
	      </div>
	      <div class="modal-body" style=" height:0px auto">
		</div>
		<div style="margin-top:0px;"> <h4 class="modal-title" id="myModalLabel"><center>Are you sure you want to delete question?<center></center></h4>
		<input type="hidden" name="qidd" id="mmodalqiddel"/>
		</div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <input type="submit" class="btn btn-primary" value="Delete">
	      </div>
	      </form>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	
	<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    <form action="updateQuestionController" method="post">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="myModalLabel">Edit Question</h4>
	      </div>
	      <div class="modal-body" style="height:500px;">
	     
	    	<table class="table table-hover" style="background-color:#fff; border-radius:3px;">
			  		<tr>
				  		<td><input type="hidden" name="flg" value="mcq" /></td>
			  		</tr>
			  		<tr>
				  		<th>Qid</th>
				  		<td><input type="text" class="form-control" style="width:170px;"name="qid1" id="modalqid" disabled/></td>				  	
			  		</tr>
			  		<tr>
			  			<td><input type="hidden" name="qid" id="modalqid1" /></td>
			  		</tr>			  		
			  		<tr>
				  		<th>Statement</th>
				  		<td><textarea name="stat" class="form-control" id="modalstat" style="width:170px;max-width:180px;" /></textarea></td>
				  	</tr>
				  	<tr>
				  		<th>A</th>
				  		<td><input type="text" class="form-control" style="width:170px;" name="opt1" id="modalopt1" /></td>
				  	</tr>
				  	<tr>
				  		<th>B</th>
				  		<td><input type="text" class="form-control" style="width:170px;" name="opt2" id="modalopt2" /></td>
				  	</tr>
				  	<tr>
				  		<th>C</th>
				  		<td><input type="text" class="form-control" style="width:170px;" name="opt3" id="modalopt3" /></td>
				  	</tr>
				  	<tr>
				  		<th>D</th>
				  		<td><input type="text" class="form-control" style="width:170px;" name="opt4" id="modalopt4" /></td>
				  	</tr>
				  	<tr>				  	
				  		<th>Answer</th>
				  		<td>
				  		<select name="ans" class="form-control" style="width:170px;" id="modalans"  Style="width:155px;">
				  			<option>A</option>
				  			<option>B</option>
				  			<option>C</option>
				  			<option>D</option>
				  		</select>
				  		</td>
				  	</tr>
				  	<tr>
				  		<th>Qlevel</th>
				  		<td><input type="text" class="form-control" style="width:170px;" name="qlevel" id="modalqlevel" /></td>
				  	</tr>
				  	<tr>
				  		<th>Marks</th>
				  		<td><input type="text" class="form-control" style="width:170px;" name="mrks" id="modalmrks" /></td>
				  	</tr>
				  	
				  	
			</table>
		</div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <input type="submit" class="btn btn-primary" value="Save changes">
	      </div>
	      </form>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    <form action="updateQuestionController" method="post">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="myModalLabel">Edit Question</h4>
	      </div>
	      <div class="modal-body" style=" height:0px auto">
	    	<table class="table table-hover" style="background-color:#fff; border-radius:3px;">
			  		<tr>
			  			<input type="hidden" name="flg" value="tf" /></td>
			  		</tr>
			  		<tr>
				  		<th>Qid</th>
				  		<td><input type="text"  class="form-control" style="width:170px;" id="mmodalqid" disabled/></td>
			  		</tr>
			  		<tr>
				  		<td><input type="hidden" name="qid2" id="mmodalqid2" /></td>
			  		</tr>
			  		<tr>
				  		<th>Statement</th>
				  		<td><textarea name="stat"  class="form-control" id="mmodalstat" style="width:170px;max-width:180px;" /></textarea></td>
				  	</tr>
				  	<tr>
				  		<th>True</th>
				  		<td><input type="radio" name="op" value="T" id="mmodalopt1" /></td>
				  	</tr>
				  	<tr>				  	
				  		<th>False</th>
				  		<td><input type="radio" name="op" value="F" id="mmodalopt2" /></td>
				  	</tr>
				  	<tr>
				  		<th>Qlevel</th>
				  		<td><input type="text" class="form-control" style="width:170px;"name="qlevel" id="mmodalqlevel" /></td>
				  	</tr>
				  	<tr>
				  		<th>Marks</th>
				  		<td><input type="text" class="form-control" style="width:170px;" name="mrks" id="mmodalmrks" /></td>
				  	</tr>
			</table>
		</div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <input type="submit" class="btn btn-primary" value="Save changes">
	      </div>
	      </form>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<div id="back" style="width:100%; height:100%;  z-index:-666; position: fixed;"></div>
		<nav class="navbar navbar-default" role="navigation" >
		  <!-- Brand and toggle get grouped for better mobile display -->
		  <div class="navbar-header">
		    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
		      <span class="sr-only">Toggle navigation</span>
		      <span class="icon-bar"></span>
		      <span class="icon-bar"></span>
		      <span class="icon-bar"></span>
		    </button>
			  <a class="navbar-brand" href="addquestion.jsp">ExamCMS</a>
			  <a class="navbar-brand" >Edit Question</a>
		  </div>
		  <div class="btn-group" style="float:right; padding-right:90px; margin-top:10px;">
		  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" >
		    <%=teacher_name %><span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" role="menu" style="width:60px; ">
		    <li><a href="#">Edit Account</a></li>
		    <li><a href="#" onclick="logout.submit();">Logout</a></li>  
		  </ul>
		</div>
		</nav>
<%if(reg!=null)
{
if(reg.equals("1"))
{
	%>
	<div  id="infoDiv" class="alert alert-success"  style="font-size: 18px;line-height: 1.5;"> <center>Question edited successfully!</center><span id="cross" style="float:right ;position: absolute;top: 70px; right: 15px; cursor:pointer;" onclick="closeDiv()" ><h3>X</h3></span></div>
	<%
}
else if(reg.equals("0"))
{
	%>
	<div  id="infoDiv" class="alert alert-success"  style="font-size: 18px;line-height: 1.5;"> <center>Question not edited successfully!</center><span id="cross" style="float:right ;position: absolute;top: 70px;right: 15px;  cursor:pointer;" onclick="closeDiv()" ><h3>X</h3></span></div>
	<%
}
} %>

<%if(del!=null)
{
if(del.equals("1"))
{
	%>
	<div  id="infoDiv" class="alert alert-success"  style="font-size: 18px;line-height: 1.5;"> <center>Question deleted successfully!</center><span id="cross" style="float:right ;position: absolute;top: 70px; right: 15px; cursor:pointer;" onclick="closeDiv()" ><h3>X</h3></span></div>
	<%
}
else if(del.equals("0"))
{
	%>
	<div  id="infoDiv" class="alert alert-success"  style="font-size: 18px;line-height: 1.5;"> <center>Question not deleted successfully!</center><span id="cross" style="float:right ;position: absolute;top: 70px;right: 15px;  cursor:pointer;" onclick="closeDiv()" ><h3>X</h3></span></div>
	<%
}
} %>
		<div style=" margin:0px auto; padding:50px; min-width:100%; max-width:100%; padding:20px;">
		<table class="table table-hover" style="background-color:#fff; border-radius:3px;">
		    <thead>
		       <tr >
		          <th>Qid</th>
		          <th>Subject</th>
		          <th>Type</th>
				  <th>Statement</th>
				  <th>A</th>
				  <th>B</th>
				  <th>C</th>
				  <th>D</th>
				  <th>Answer</th>
				  <th>Qlevel</th>
				  <th>Marks</th>
		       </tr>
		    </thead>
		      <tbody>
		        <% 
		        ResultSet rs = DBConnection.selectQuery("select * from qbank where tid ="+tid);             
		        
		        
		        while(rs.next()) {
		        	qid = rs.getString("qid");
		        	subject = rs.getString("sub");
		        	type = rs.getString("type");
		    		statement = rs.getString("statement");
		    		qlevel = rs.getString("qlevel");
		    		marks = rs.getString("marks");
		    		ans = rs.getString("ans");
		        	if(rs.getString("type").equals("tf"))
		        	{
			    		opt1 = "-";
			    		opt2 = "-";
			    		opt3 = "-";
			    		opt4 = "-";
		    		
		        	}
		        	else
		        	{
			    		opt1 = rs.getString("opt1");
			    		opt2 = rs.getString("opt2");
			    		opt3 = rs.getString("opt3");
			    		opt4 = rs.getString("opt4");
		        	}
		    		
		    	%>	
		    	<tr id="<%=qid %>">
		    		<td><%=qid %></td>
		            <td><%=subject %></td>
		            <td><%=type %></td>
		            <td><%=statement %></td>
		            <td><%=opt1 %></td>
		            <td><%=opt2 %></td>
		            <td><%=opt3 %></td>
		            <td><%=opt4 %></td>
		            <td><%=ans %></td>
		            <td><%=qlevel %></td>
		            <td><%=marks %></td>
		            <%
		            	if(type.equals("tf"))
		            	{
		            %>
					<td><button class="btn btn-info " data-toggle="modal" data-target="#myModal" id="<%=qid%>" onclick="edittf(<%=qid%>)">
		  			Edit</button></td>
		  			<%
		            	}
		            	else
		            	{
		  			%>
		  			<td><button class="btn btn-info " data-toggle="modal" data-target="#myModal1" id="<%=qid%>" onclick="editmcq(<%=qid%>)">
		  			Edit</button></td>
		  			<%
		  			}
		  			%>
					<td><button class="btn btn-danger " data-toggle="modal" data-target="#myModal2" id="<%=qid%>" onclick="deleteq(<%=qid%>)">
		  			Delete</button></td>
		        </tr>
		   <%  } %>     
		       </tbody>
		      </table>
		</div>
</body>
<script src="js/jquery.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
</html>