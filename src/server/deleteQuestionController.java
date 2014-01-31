package server;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DBConnection;


@WebServlet("/deleteQuestionController")
public class deleteQuestionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		
		String qidd=request.getParameter("qidd");
		int status=DBConnection.deleteQuestion(qidd);
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
