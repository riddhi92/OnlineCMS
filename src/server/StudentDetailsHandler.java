package server;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.DBConnection;

@WebServlet("/StudentDetailsHandler")
public class StudentDetailsHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String fname=request.getParameter("fname");
		String lname=request.getParameter("lname");
		String newPwd=request.getParameter("newPwd");
		String dob=request.getParameter("dob");
		String email=request.getParameter("email");
		String mobile=request.getParameter("mobile");
		String address=request.getParameter("address");
		String city=request.getParameter("city");
		String state=request.getParameter("state");
		
		HttpSession session=request.getSession();
		session.setAttribute("newPwd", newPwd);
		int sid = (Integer)session.getAttribute("sId");
		int flg=DBConnection.updateStudentDetails(sid, fname, lname, newPwd, dob, email, mobile, address, city, state);
		if(flg==1)
		{
			response.sendRedirect("studentdashboard.jsp");
		}
		else
		{
			response.sendRedirect("studentdetails.jsp");
		}
		
	}

}
