<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="db.DBConnection,java.sql.* ;" %><%
String sub_name=request.getParameter("sub_name");
    ResultSet rs=DBConnection.getTotalquestion(sub_name);
if(rs.next())
{
int total_quest=Integer.parseInt(rs.getString("countval"));
out.print(total_quest);
} 
%>