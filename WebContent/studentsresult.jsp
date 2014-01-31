<%@ page language="java"  errorPage="error.jsp" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,db.DBConnection"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Student Results</title>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://cdn.jquerytools.org/1.2.7/full/jquery.tools.min.js"></script>
<script src="js/highcharts.js" type="text/javascript"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>

<script type="text/javascript" src="js/bootstrap.js"></script>

<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-theme.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
<link href="css/style.css" rel="stylesheet" type="text/css">

</head>
<% 
  int exam_id=Integer.parseInt(request.getParameter("exam_id"));


  int  resultarr [][]=DBConnection.processAllResult(exam_id);
  int total_marks=DBConnection.calTotalMarks(exam_id);

  Boolean validateResult=(Boolean)session.getAttribute("login_success");
  if(validateResult==null ){
  	response.sendRedirect("adminlogin.jsp?s=false");
  }
  String admin_name=(String)session.getAttribute("admin_name");
  String reg=request.getParameter("status");


  
%>
<body id="back">
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
    <a class="navbar-brand" href="#">Dashboard</a>
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
</div>
</nav>
<div style=" margin:0px auto; padding:50px; min-width:1000px; max-width:1000px; padding:20px;">
 <ul class="nav nav-tabs" id="myTab" style=" border:0px solid;">
  <li class="active" style=" width:200px;"><a href="#studentResult" data-toggle="tab" style="color:#000;">Student Result</a></li>
  <li style=" width:200px;"><a href="#ResultAnalysis" data-toggle="tab" style="color:#000;">Result Analysis</a></li>
  
 </ul>
<div class="tab-content" style="width:810px;height:390px;  border-radius:5px;">
	<div   class="tab-pane fade in active" id="studentResult" style="width:810px; height:0px auto; margin:0px auto;  margin-left:-20px;margin-top:-20px" >
		<div style="margin: 0px auto; padding: 50px; min-width: 850px; max-width: 850px; padding: 20px;"> 
		  
			<table class="table table-hover" style="background-color:#fff; border-radius:3px;">
			
			        <thead>
			          <tr>
			            <th>Student Id</th>
			            <th>Obtained Marks</th>
			            <th>Percentage</th>
			          </tr>
			        </thead>
			        <tbody>
			        <% 
			        for(int i=0;i<resultarr.length;i++)
			        {
			      	 
			      		  //System.out.println(resultarr[i][j]);
			      		%>  
			      		<tr>
			            <td><%=resultarr[i][0] %></td>
			            <td><%=resultarr[i][1] %></td>
			            <td><%=(resultarr[i][1]*100)/total_marks %></td>
			           </tr>
				    <%  
			       }
			        %>  </tbody>
			     </table>
			     </div>
			     </div>
			     <div  class="tab-pane fade" id="ResultAnalysis" style="width:810px; height:0px auto; margin:0px auto;  margin-left:-20px;margin-top:-20px" >
		              <div style="margin: 0px auto; padding: 50px; min-width: 850px; max-width: 850px; padding: 20px;"> 
		                 <div class="panel panel-default" style=" height:370px; width:900px;">
		                 
		                 </div>
			
			     </div>
			     </div>
			     
		</div>
   </div>
</body>

</html>