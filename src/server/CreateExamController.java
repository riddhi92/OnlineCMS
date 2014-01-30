package server;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DBConnection;

/**
 * Servlet implementation class CreateExamController
 */
@WebServlet("/CreateExamController")
public class CreateExamController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String Sub_name=request.getParameter("selectSub");
		int totalque=Integer.parseInt(request.getParameter("totalque"));
		int hardness=Integer.parseInt(request.getParameter("hardness"));
		String exam_date=request.getParameter("exam_date");
		String venue=request.getParameter("venue");
		String result_date=request.getParameter("result_date");
		
		System.out.println(Sub_name+totalque+hardness);

		if(Sub_name==null||Sub_name.isEmpty()||totalque==0|| hardness==0|| exam_date==null||exam_date.isEmpty()||venue==null||venue.isEmpty()||result_date==null||result_date.isEmpty())
		{
			response.sendRedirect("createexam.jsp?status=exam_fail");
		}
			
		int result=DBConnection.insertExamInfo(Sub_name,totalque,hardness,exam_date,venue,result_date);
		
		if(result==1)
		{
			response.sendRedirect("dashboard.jsp?status=exam_success");
		}
		else{
			response.sendRedirect("createexam.jsp?status=exam_fail");
		}
	}

}
