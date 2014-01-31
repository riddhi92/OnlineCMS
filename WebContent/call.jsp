<%@page import="db.DBConnection"%>
<%@page import="process.MethodClass"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Call</title>
</head>
<body>

<%
	DBConnection db=new DBConnection();

		db.resultAnalysis(39);

%>

IN JSP PAGE
</body>
</html>