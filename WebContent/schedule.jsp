<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Schedule Exam</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-theme.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="back" style="width:100%; height:100%; position: fixed; z-index:1;">

<nav class="navbar navbar-default" role="navigation" >
  <!-- Brand and toggle get grouped for better mobile display -->
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="dashboard.jsp">ExamCMS</a>
	
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
<div style=" margin:0px auto; padding:50px; min-width:1000px; max-width:1000px; padding:20px;">

<table class="table table-hover" style="background-color:#fff; border-radius:3px;">
        <thead>
          <tr>
            <th>Exam Id</th>
            <th>Subject</th>
            <th>Exam Date</th>
			<th>Venue</th>
			<th>Option</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>1</td>
            <td>DBT</td>
            <td>12/12/2013</td>
            <td>Cdac</td>
			<td><button type="button" class="btn btn-info">reshdeule</button><button type="button" class="btn btn-danger" style="margin-left:20px;">cancel</button></td>
          </tr>
           <tr>
            <td>1</td>
            <td>DBT</td>
            <td>12/12/2013</td>
            <td>Cdac</td>
			<td><button type="button" class="btn btn-info">reshdeule</button><button type="button" class="btn btn-danger" style="margin-left:20px;">cancel</button></td>
          </tr>
           <tr>
            <td>1</td>
            <td>DBT</td>
            <td>12/12/2013</td>
            <td>Cdac</td>
			<td><button type="button" class="btn btn-info">reshdeule</button><button type="button" class="btn btn-danger" style="margin-left:20px;">cancel</button></td>
          </tr>
        </tbody>
      </table>
</div>

</div>
</body>
<script src="js/jquery.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>