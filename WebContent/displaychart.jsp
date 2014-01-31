<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
  <%@page import="db.DBConnection"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Result Analysis</title>
	<link href="css/examples.css" rel="stylesheet" type="text/css">
	<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="../../excanvas.min.js"></script><![endif]-->
	<script language="javascript" type="text/javascript" src="js/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="js/jquery.flot.js"></script>
	<script language="javascript" type="text/javascript" src="js/jquery.flot.stack.js"></script>
	<script type="text/javascript">
	
<%	
       int [][]ResultArr=DBConnection.resultAnalysis(5);
	

	%>
	var d1 = [];
	var d2 = [];
	var d3 = [];
	var d4 = [];
	$(function() {
		<% for(int  i = 0 ; i <ResultArr.length; i++){ %>d1.push([<%=i+1%>, <%=ResultArr[i][0]%>]);
		d2.push([<%=i+1%>, <%=ResultArr[i][1]%>]);
		d3.push([<%=i+1%>, <%=ResultArr[i][2]%>]);
		d4.push([<%=i+1%>, <%=ResultArr[i][3]%>]);
		<%   } %>
	
		/* for (var i = 1; i <= 11; i += 1) {
			d2.push([i, parseInt(Math.random() * 30)]);
		}

		for (var i = 1; i <= 11; i += 1) {
			d3.push([i, parseInt(Math.random() * 30)]);
		}

		for (var i = 1; i <= 11; i += 1) {
			d4.push([i, parseInt(Math.random() * 30)]);
		} */
		var stack = 0,
			bars = true,
			lines = false,
			steps = false;

		function plotWithOptions() {
			$.plot("#placeholder", [ d1, d2, d3, d4 ], {
				series: {
					stack: stack,
					lines: {
						show: lines,
						fill: true,
						steps: steps
					},
					bars: {
						show: bars,
						barWidth: 0.6
					}
				}
			});
		}

		plotWithOptions();

		$(".stackControls button").click(function (e) {
			e.preventDefault();
			stack = $(this).text() == "With stacking" ? true : null;
			plotWithOptions();
		});

		$(".graphControls button").click(function (e) {
			e.preventDefault();
			bars = $(this).text().indexOf("Bars") != -1;
			lines = $(this).text().indexOf("Lines") != -1;
			steps = $(this).text().indexOf("steps") != -1;
			plotWithOptions();
		});

		// Add the Flot version string to the footer

		$("#footer").prepend("Flot " + $.plot.version + " &ndash; ");
	});

	</script>
</head>
<body>

	<div id="header">
	
	</div>

	<div id="content">

		<div class="demo-container">
			<div id="placeholder" class="demo-placeholder"></div>
		</div>

		

		<p class="graphControls">
		<div style=" margin-left:100px;">
			<div style="background-color:yellow; width:60px; height: 30px;float: left; "></div><div style="float: left;" >option A</div>
			<div style="background-color:blue; width:60px; height: 30px; float: left;margin-left:60px; "></div><div style="float: left;">option B</div>
		    <div style="background-color:red; width:60px; height: 30px; float: left ;margin-left:60px;"></div><div style="float: left;">option C</div>
		    <div style="background-color:green; width:60px; height: 30px;float: left;margin-left:60px; "></div><div style="float: left;">option D</div>
		    </div>
		</p>

	</div>

	

</body>
</html>