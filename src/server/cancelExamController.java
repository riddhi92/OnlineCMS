package server;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DBConnection;

/**
 * Servlet implementation class cancelExamController
 */
@WebServlet("/cancelExamController")
public class cancelExamController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String eid=request.getParameter("eidd");
		int status=DBConnection.deleteExam(eid);
		if(status==1)
		{
			response.sendRedirect("scheduleexam.jsp?d=1");
		}
		else
		{
			response.sendRedirect("scheduleexam.jsp?d=0");
		}
	}

}
