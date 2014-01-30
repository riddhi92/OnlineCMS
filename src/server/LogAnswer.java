package server;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LogAnswer")
public class LogAnswer extends HttpServlet  {
	private static final long serialVersionUID = 1L;
	public static int cnt=0;
	public String question="";
	public String ans_key="";
	
    public LogAnswer() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		HttpSession session = request.getSession();
		
		String qid = request.getParameter("qid");
		String option = request.getParameter("option");
		String total = request.getParameter("total");
		int totalno = Integer.parseInt(total);

		char arr[] = new char[totalno];
		String check = (String)session.getAttribute("ftime");
		if(check != null)
		{
			arr = (char[])session.getAttribute("sdata");
		}
		else // first time
		{
				session.setAttribute("ftime","set");
				for(int i = 0; i < totalno; i++)
				{
					arr[i] = '-';
				}		
		}
		
		if(option.equals("Clear"))
			arr[Integer.parseInt(qid)-1] = '-';
		else
			arr[Integer.parseInt(qid)-1] = option.charAt(0);
		
		session.setAttribute("sdata",arr);
		PrintWriter out = response.getWriter();
	    out.print("ok");
	}

}
