package server;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DBConnection;


@WebServlet("/updateQuestionController")
public class updateQuestionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String flg=request.getParameter("flg");
		int status=0;
		String qid="";
		String ans="";
		String stat="";
		String opt1="";
		String opt2="";
		String opt3="";
		String opt4="";
		String qlevel="";
		String mrks="";
		if(flg.equals("mcq"))
		{
			qid=request.getParameter("qid");
			stat=request.getParameter("stat");
			opt1=request.getParameter("opt1");		
			opt2=request.getParameter("opt2");		
			opt3=request.getParameter("opt3");		
			opt4=request.getParameter("opt4");	
			ans=request.getParameter("ans");
			qlevel=request.getParameter("qlevel");		
			mrks=request.getParameter("mrks");	
			
			
			
			String path = getServletContext().getRealPath("");
			path += "\\que_images\\"+qid+"temp"+".jpg";
			System.out.println("path"+path);
			Boolean imgstatus = process.TextToImage.convert(stat,path);
			
			String newpath = getServletContext().getRealPath("");
			newpath += "\\que_images\\"+qid+".jpg";
			
			File f=new File(path);
			File f1=new File(newpath);
			
			System.out.println("===="+f1.getName());
			if(imgstatus)
			{
				status=DBConnection.updateQuestion(qid,stat,opt1,opt2,opt3,opt4,ans,qlevel,mrks);
				if(status==1)
				{
				if(f.exists())
				{
					
				f.renameTo(f1);
				
				}
				System.out.println("rename"+f.getName());
				response.sendRedirect("editquestion.jsp?s=1");
				}
			}
			else
			{
					
					response.sendRedirect("editquestion.jsp?s=0");
			}
		}
		else
		{
			qid=request.getParameter("qid2");
			stat=request.getParameter("stat");
			ans=request.getParameter("op");
			qlevel=request.getParameter("qlevel");		
			mrks=request.getParameter("mrks");
			String path = getServletContext().getRealPath("");
			path += "\\que_images\\"+qid+".jpg";
			Boolean imgstatus = process.TextToImage.convert(stat,path);
			status=DBConnection.updateQuestiontf(qid,stat,ans,qlevel,mrks);
				if(status==1 && imgstatus==true)
				{
					response.sendRedirect("editquestion.jsp?s=1");
				}
				else
				{
					response.sendRedirect("editquestion.jsp?s=0");
				}
		}
		
	}

}
