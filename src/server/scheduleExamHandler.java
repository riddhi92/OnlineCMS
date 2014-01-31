package server;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DBConnection;


@WebServlet("/scheduleExamHandler")
public class scheduleExamHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String eid=request.getParameter("eid");
		String edate=request.getParameter("edate");
		String venue=request.getParameter("venue");
		String rdate=request.getParameter("rdate");
		
		int status=DBConnection.updateScheduleExam(eid,edate,venue,rdate);
		if(status==1)
		{
			response.sendRedirect("scheduleexam.jsp?s=1");
		}
		else
		{
			response.sendRedirect("scheduleexam.jsp?s=0");
		}
		
		
	}

}
