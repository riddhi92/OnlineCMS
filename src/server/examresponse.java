package server;

import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.DBConnection;

@WebServlet("/examresponse")
public class examresponse extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public examresponse() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		HttpSession session=request.getSession();
		int sid = (Integer)session.getAttribute("sId");
		int eid = (Integer)session.getAttribute("examId");
		int totalque = (Integer)session.getAttribute("maxquestions");
		char arr[] = (char[])session.getAttribute("sdata");
		String ans_string = "";
		for(int i = 0; i < totalque-1; i++)
		{
			ans_string += arr[i];
		}
		int stat = DBConnection.insertAnswer(eid, sid, ans_string);
		PrintWriter out = response.getWriter();
		if(stat == 1)
		{			
			response.sendRedirect("studentdashboard.jsp");
		}
		else
		{
			out.write("Data Insert Failed!");
		}
	}

}
