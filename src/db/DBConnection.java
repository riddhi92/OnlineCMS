package db;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.QuestionData;
import com.Student;
import com.Teacher;

public class DBConnection {

	static Connection con = null;
	static ResultSet rs = null;
	static PreparedStatement ps = null;
	static Statement st = null;
	static {

		try {

			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe",
					"SYSTEM", "Nishi1991");

		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	public static ResultSet selectQuery(String sql) {

		try {
			st = con.createStatement();
			rs = st.executeQuery(sql);
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
         
		return rs;

	}
	
	
	public static int updateScheduleExam(String eid, String edate,
			String venue, String rdate) 
	{
		int flg=0;
		ResultSet rs1 = convertStringToDate(edate);
		ResultSet rs2 = convertStringToDate(rdate);
		try {
			if (rs1.next()) {
				System.out.println(rs1.getDate(1));
			}

			if (rs2.next()) {
				System.out.println(rs2.getDate(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		String sql = "update examinfo set  exam_date=?, venue=? , result_date=? where exam_id="
				+eid;
		try {

			ps = con.prepareStatement(sql);
			ps.setDate(1, rs1.getDate(1));
			ps.setString(2, venue);
			ps.setDate(3,rs2.getDate(1));
			flg = ps.executeUpdate();
			con.commit();
			
		} catch (Exception e) 
		{
			e.printStackTrace();
		}
		return flg;
	}

	public static int updateQuestion(String qid, String stat, String opt1,
			String opt2, String opt3, String opt4, String ans, String qlevel,
			String mrks)
	{
		int flg=0;
		
		String sql = "update qbank set statement=?,opt1=?, opt2=?, opt3=?, opt4=?, ans=?, qlevel=? , marks=? where qid="
				+qid;
		try {

			ps = con.prepareStatement(sql);
			ps.setString(1, stat);
			ps.setString(2, opt1);
			ps.setString(3, opt2);
			ps.setString(4, opt3);
			ps.setString(5, opt4);
			ps.setString(6, ans);
			ps.setString(7, qlevel);
			ps.setString(8, mrks);
			flg = ps.executeUpdate();
			
			
		} catch (Exception e) 
		{
			e.printStackTrace();
		}
		return flg;
		}
	
	public static int updateQuestiontf(String qid, String stat, String ans,
			String qlevel, String mrks)
	{
		
		int flg=0;
		
		String sql = "update qbank set statement=?, ans=?, qlevel=? , marks=? where qid="
				+qid;
		try {

			ps = con.prepareStatement(sql);
			ps.setString(1, stat);
			ps.setString(2, ans);
			ps.setString(3, qlevel);
			ps.setString(4, mrks);
			flg = ps.executeUpdate();
			con.commit();
			
		} catch (Exception e) 
		{
			e.printStackTrace();
		}
		return flg;
	}



	
	public static DBConnection getObject() {
		return new DBConnection();
	}
	
	public static int deleteExam(String eidd) 
	{
		int flg=0;
		
		String sql = "delete examinfo where exam_id='" + eidd + "'";
		try {

			ps = con.prepareStatement(sql);
			flg = ps.executeUpdate();
			con.commit();
			
			
		} catch (Exception e)
		{	
			e.printStackTrace();
		}
		
		
		return flg;
	}
	
	public static int deleteQuestion(String qidd) 
	{
		int flg=0;
		
		String sql = "delete qbank where qid="+qidd;
		try {

			ps = con.prepareStatement(sql);
			flg = ps.executeUpdate();
			con.commit();
			
			
		} catch (Exception e)
		{	
			e.printStackTrace();
		}
		
		
		return flg;
	}


	public static int insertQueryTeacher(Teacher tec) {
		int flag = 0;
		String sql = "insert into teacher(tid,tregId,tname,tpwd,temail,tmobile,tsub,tcity,tstate) values(t_id.NEXTVAL,?,?,?,?,?,?,?,?)";
		try {
			ps = con.prepareStatement(sql);

			ps.setString(1, tec.getTregId());
			ps.setString(2, tec.gettName());
			ps.setString(3, tec.gettPwd());
			ps.setString(4, tec.gettEmail());
			ps.setString(5, tec.gettMobile());
			ps.setString(6, tec.gettSub());
			ps.setString(7, tec.gettCity());
			ps.setString(8, tec.gettState());
			flag = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return flag;
	}

	public static int insertQuestion(int tid, QuestionData qd) {
		int flag = 0;

		String sql = "INSERT INTO QBANK(tid, qid, sub, type, statement, imgpath, opt1, opt2, opt3, opt4, ans, qlevel, marks) VALUES (?,q_id.NEXTVAL ,?,?,?,q_id.NEXTVAL,?,?,?,?,?,?,?)";
		try {
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, tid);
			ps.setString(2, qd.getSubject());
			ps.setString(3, qd.getQtype());
			ps.setString(4, qd.getQue());
			ps.setString(5, qd.getOpt1());
			ps.setString(6, qd.getOpt2());
			ps.setString(7, qd.getOpt3());
			ps.setString(8, qd.getOpt4());
			ps.setString(9, qd.getCorrect());
			ps.setInt(10, qd.getHardness());
			ps.setInt(11, qd.getMarks());
			flag = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}

	public static int insertQueryStudentCsv(Student stu) {
		int flag = 0;
		String sql = "insert into student(SID,SFNAME,SLNAME,PASSWORD,DOB,EMAIL,MOBILENO,ADDRESS,CITY,STATE) values(?,?,?,?,?,?,?,?,?,?)";
		try {
			ps = con.prepareStatement(sql);

			ps.setInt(1, stu.getsId());
			ps.setString(2, stu.getFname());
			ps.setString(3, stu.getLname());
			ps.setString(4, stu.getPwd());
			ps.setString(5, stu.getDob());
			ps.setString(6, stu.getEmail());
			ps.setString(7, stu.getMobile());
			ps.setString(8, stu.getAddress());
			ps.setString(9, stu.getCity());
			ps.setString(10, stu.getState());
			flag = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally
		{
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return flag;
	}

	public static int insertQueryStud(int key, String pwd) {
		int flag = 0;

		String sql = "insert into student(sid,password) values(?,?)";

		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, key);
			ps.setString(2, pwd);
			flag = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally
		{
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return flag;

	}

	public static int loadCSV(String path, String acctype) {
		String csvFile = path;
		BufferedReader br = null;
		String line = "";
		String cvsSplitBy = ",";
		int result = 0;
		try {

			br = new BufferedReader(new FileReader(csvFile));
			while ((line = br.readLine()) != null) {

				// System.out.println(line);
				// use comma as separator
				String[] t_info = line.split(cvsSplitBy);

		System.out.println("t_info [id= " +t_info[0] + " , name=" +
				t_info[1] +
			 ""+t_info[2]+" "+t_info[3]+" "+t_info[4]+" "+t_info[5]+" "+t_info[6]+" "+t_info[7]);

				if (acctype.equals("teacher")) {
					boolean flag = checkTeacherId(t_info[1]);
					if (!flag) {

						Teacher teacher = new Teacher();
						teacher.setTregId(t_info[1]);
						teacher.settName(t_info[2]);
						teacher.settPwd(t_info[3]);
						teacher.settEmail(t_info[4]);
						teacher.settMobile(t_info[5]);
						teacher.settSub(t_info[6]);
						teacher.settCity(t_info[7]);
						teacher.settState(t_info[8]);
						result = insertQueryTeacher(teacher);
					}

					else {

						result = 0;
					}
				} else {

					try {
						Student stu = new Student();
						stu.setsId(Integer.parseInt(t_info[0]));
						stu.setFname(t_info[1]);
						stu.setLname(t_info[2]);
						stu.setPwd(t_info[3]);
						stu.setDob(t_info[4]);
						stu.setEmail(t_info[5]);
						stu.setMobile(t_info[6]);
						stu.setAddress(t_info[7]);
						stu.setCity(t_info[8]);
						stu.setState(t_info[9]);
						result = insertQueryStudentCsv(stu);
					} catch (Exception e) {
						System.out.println("Exception Occured");
					}

				}

			}

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		System.out.println("Done");

		return result;
	}

	public static ArrayList<Integer> CheckKey(int key) {
		int chk = 0, sid = 0;
		ArrayList<Integer> t = new ArrayList<Integer>();
		String sql = "select sid from student where sid=" + key;
		try {
			ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				sid = rs.getInt("sid");
				t.add(key);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return t;
	}

	public static boolean checkTeacherId(String key) {
		boolean flag = false;

		String sql = "select tregid from teacher where tregid='" + key + "'";
		try {
			ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {

				flag = true;

			} else {
				flag = false;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

	public static ResultSet selectStudent(int sid) {
		String sql = "select * from student where sid=" + sid;
		try {

			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return rs;
	}

	public static int updateStudentDetails(int sid, String fname, String lname,
			String newPwd, String dob, String email, String mobile,
			String address, String city, String state )
	{
		int flg=0;
		
		String sql = "update student set sfname=?, slname=?,password=?, dob=?, email=?, mobileno=?, address=?, city=? , state=? where sid="
				+sid;
		try {

			ps = con.prepareStatement(sql);

			
			ps.setString(1, fname);
			ps.setString(2, lname);
			ps.setString(3, newPwd);
			ps.setString(4, dob);
			ps.setString(5, email);
			ps.setString(6, mobile);
			ps.setString(7, address);
			ps.setString(8, city);
			ps.setString(9, state);
			flg = ps.executeUpdate();
			
			
		} catch (Exception e) 
		{
			e.printStackTrace();
		}
		return flg;
		
	}

	
	public static  void CreateTable(int exam_id)throws SQLException{
	    try{
	        
	        Connection dbConnection = null;
	        PreparedStatement preparedStatement = null;
	        
	        String createTableSQL = "CREATE TABLE e"+exam_id+"(s_id number(20),answer varchar(255),obtained_marks varchar(30))";
	        dbConnection = con;
	        preparedStatement = dbConnection.prepareStatement(createTableSQL);
	preparedStatement.executeUpdate();
	        System.out.println("Table Created");
	        con.commit();
	            
	    }catch(Exception e){
	    e.printStackTrace();
	    }    
	}

	public static String getMaxQid() {
		String sql = "select max(qid) MAXQID from qbank";
		String maxqid = "";
		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				maxqid = ""+rs.getInt("MAXQID");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return maxqid;
	}
	
	public static ArrayList<String> populateStudentDetails(int id)
	{
		ArrayList<String> arr=new ArrayList<String>();
		String sql="select * from student where sid="+id;
		try
		{
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next())
			{
			arr.add(rs.getString(2));
			arr.add(rs.getString(3));
			arr.add(rs.getString(4));
			arr.add(rs.getString(5));
			arr.add(rs.getString(6));
			arr.add(rs.getString(7));
			arr.add(rs.getString(8));
			arr.add(rs.getString(9));
			arr.add(rs.getString(10));
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return arr;
	}
	

	public static ResultSet getTotalquestion(String subject) {
		String sql = "select count(*) countval from qbank where sub='"
				+ subject + "'";

		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			System.out.println(rs.getString("countval") + "");

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rs;
	}
	
	public static int insertExamInfo(String Sub_name, int totalque,
			int hardness, String exam_date, String venue, String result_date) {
		ResultSet rs1 = convertStringToDate(exam_date);

		ResultSet rs2 = convertStringToDate(result_date);
		try {
			if (rs1.next()) {
				System.out.println(rs1.getDate(1));
			}

			if (rs2.next()) {
				System.out.println(rs2.getDate(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		int result1 = 0;
		int result2 = 0;
		int flag=0;
		String sql = "insert into examinfo(exam_id,subject,total_quest,exam_date,venue,result_date,hardness) values(exam_id.NEXTVAL,?,?,?,?,?,?)";
		try {
			ps = con.prepareStatement(sql);

			ps.setString(1, Sub_name);
			ps.setInt(2, totalque);
			ps.setDate(3, rs.getDate(1));
			ps.setString(4, venue);
			ps.setDate(5, rs1.getDate(1));
			ps.setInt(6, hardness);
			result1 = ps.executeUpdate();
			
			ResultSet rs3=selectQuery("select max(exam_id) MAXEID from examinfo");
			int question[]=null;
			String strquest="";
			int exam_id = 0;
			if(rs3.next())
			{
				 exam_id=rs3.getInt("MAXEID");
				 question = process.RandomQuestions.generate(exam_id);
				//question={3,2,4,7,8,};
			}
			strquest=strquest+question[0];
			for( int i=1; i<question.length;i++)
			{
				strquest=strquest+","+question[i];
			}
			System.out.println("strquest"+strquest);
			ResultSet rs4=null;
			String strAnsw="";
			
			boolean flag1 = true;
			for( int i=0; i<question.length;i++)
			{
				System.out.println("select ans from qbank where qid="+question[i]);
				rs4=selectQuery("select ans from qbank where qid="+question[i]);
			 
			 if(rs4.next())
				{
				 if(flag1)
					 strAnsw=rs4.getString("ans");
				 else
					 strAnsw=strAnsw+","+rs4.getString("ans");
				 
				}
			   flag1 = false;
			}
			
			System.out.println("Answ"+strAnsw);
			boolean flag2=true;
			String marks="";
			for( int i=0; i<question.length;i++)
			{
				
				 rs4=selectQuery("select marks from qbank where qid="+question[i]);
			 
			if(rs4.next())
				{
				   if(flag2)
					  marks =rs4.getString("marks");
				   else
					   marks =marks+","+rs4.getString("marks");
				}
			 flag2 = false;
			 
			}
			System.out.println("Marks"+marks);
			
			String sql11="update examinfo set question=?,ans_key=?,ques_marks=? where exam_id="+exam_id;
			try {

				ps = con.prepareStatement(sql11);
				ps.setString(1, strquest);
				ps.setString(2, strAnsw);
				ps.setString(3, marks);	
				result2=ps.executeUpdate();
				
				
			} catch (Exception e) 
			{
				e.printStackTrace();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
           
		if(result1==1 && result2==1)
		{
			flag=1;
		}
		 
		return flag;
	}

	public static ResultSet convertStringToDate(String str) {
		String sql = "select to_date('" + str + "','YYYY-MM-DD') from dual";
		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rs;

	}

	public static ResultSet getTotalStudent() {
		String sql = "select count(*) countval from student";

		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rs;
	}

	public static ResultSet getTotalteacher() {
		String sql = "select count(*) countval from teacher";

		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rs;
	}

	public static ResultSet getStudentExamId(int exam_id) {
		String sql = "select count(*) countval from e"+exam_id;

		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rs;
	}
	
	public static String sessionRandomFunction()
	{
		 List<Integer> numbers = new ArrayList<Integer>();
		    for(int i = 0; i < 10; i++){
		        numbers.add(i);
		    }

		    Collections.shuffle(numbers);

		    String result = "";
		    for(int i = 0; i < 4; i++){
		        result += numbers.get(i).toString();
		    }
		   return result;
	}

	
public static ArrayList<Integer> processResult(int exam_id,int studentId) {
	
		
		String q_str = "";
		String[] que_arr;
		String correct_str = "";
		String[] correct_arr;
		String marks = "";
		String[] obtained_marks;
		int total_student=0;
		int total=0;
		int total_marks = 0;
		ArrayList<Integer> result_arr=new ArrayList<Integer>();
		// for question array
		String sql = "select question from examinfo where exam_id="+exam_id;	
		try {
			ps = con.prepareStatement(sql);
			ResultSet rs1 = ps.executeQuery();
			if (rs1.next()) {
				q_str = rs1.getString("question");
				System.out.println(q_str);
			}

			que_arr = q_str.split(",");
			// for  Correct answer array
			String sql1 = "select ans_key from examinfo where exam_id="+exam_id;
			ResultSet rs2 = selectQuery(sql1);

			if (rs2.next()) {
				correct_str = rs2.getString("ans_key");
				System.out.println(correct_str);
			}
			correct_arr = correct_str.split(",");

			// for  marks array
			String sql3 = "select ques_marks from examinfo where exam_id="+exam_id;
			ResultSet rs3 = selectQuery(sql3);

			if (rs3.next()) {
				marks = rs3.getString("ques_marks");
				System.out.println(marks);
			}
			obtained_marks = marks.split(",");
            
			 for(int i=0;i<obtained_marks.length;i++)
			 {
				 total=total+Integer.parseInt(obtained_marks[i]);
			 }
			  result_arr.add(total);
			  System.out.println("Result"+total);
			
			//----- calculate students marks 
			String sql4 = "select * from e"+exam_id+" where s_id=121";
			ResultSet rs4 = selectQuery(sql4);
//			ResultSet rs5 = getStudentExamId();
//			if (rs5.next()) {
//				total_student = Integer.parseInt(rs.getString("countval"));
//				System.out.println(total_student);
//			}
//			int[] Stud_result = new int[total_student-2];
			
			
			if (rs4.next())

			{
				int stud_id = rs4.getInt("s_id");
				String stud_answer = rs4.getString("answer");
				String[] stud_arr = stud_answer.split(",");
				
				for (int i = 0; i < stud_arr.length; i++) {
					if (correct_arr[i].equals(stud_arr[i])) {
						total_marks = total_marks
								+ Integer.parseInt(obtained_marks[i]);

					} else {

						total_marks = total_marks + 0;
					}

				}
				  result_arr.add(total_marks);
				  System.out.println(stud_id + "----"+total_marks);
				  
				  
				  String sq = "update e"+exam_id+" set obtained_marks=? where s_id=122";
							
					try {

						ps = con.prepareStatement(sq);

						
						ps.setInt(1, total_marks);
					
						
						int flag= ps.executeUpdate();
						 System.out.println("status--------"+flag);
						
					} catch (Exception e) 
					{
						e.printStackTrace();
					}
					
			}
				
			/* for(int k=0;k<que_arr.length;k++)	
			  {
				
					String sql5 = "select s_id,substr(answer,0,1), from exam_result where s_id not in (-1,-2)";
					ResultSet rs6 = selectQuery(sql5);
					String ans_key="";
					int count1=0;
					int count2=0;
					int count3=0;
					int count4=0;
					int count5=0;
					int count6=0;
					int count7=0;
					
					while(rs6.next())
					{
						System.out.println("hii");
						String answer=rs.getString("answer");
						if(answer.equals("A"))
						{
							count1++;
						}else if(answer.equals("B")){
							count2++;
						}
                        else if(answer.equals("C")){
                        	count3++;
						}
                        else if(answer.equals("D")){
                        	count4++;
						}
                        else if(answer.equals("T")){
                        	count5++;
						}
                        else if(answer.equals("F")){
                        	count6++;
						}
                        else if(answer.equals("-")){
                        	count7++;
						}
						
						System.out.println(count1+count2+count3+count4+count5+count6+count7);
						
						
					}*/
					
//					for (int j = 0; j <total_student-2; j++)
//					{
//						Stud_result[j] = total_marks;
//					    System.out.println(stud_id + "----"+ Stud_result[j]);
//							
//					}
			    
			

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
       
		return result_arr;
	}


public static int[][] processAllResult(int exam_id) {
	
	
	String q_str = "";
	String[] que_arr;
	String correct_str = "";
	String[] correct_arr;
	String marks = "";
	String[] obtained_marks;
	int total_student=0;
	int total=0;
	int total_marks = 0;
	ResultSet rs4=null;
	int[][] Stud_result=null;
	// for question array
	String sql = "select question from examinfo where exam_id="+exam_id;	
	try {
		ps = con.prepareStatement(sql);
		ResultSet rs1 = ps.executeQuery();
		if (rs1.next()) {
			q_str = rs1.getString("question");
			System.out.println(q_str);
		}

		que_arr = q_str.split(",");
		// for  Correct answer array
		String sql1 = "select ans_key from examinfo where exam_id="+exam_id;
		ResultSet rs2 = selectQuery(sql1);

		if (rs2.next()) {
			correct_str = rs2.getString("ans_key");
			System.out.println(correct_str);
		}
		correct_arr = correct_str.split(",");

		// for  marks array
		String sql3 = "select ques_marks from examinfo where exam_id="+exam_id;
		ResultSet rs3 = selectQuery(sql3);

		if (rs3.next()) {
			marks = rs3.getString("ques_marks");
			System.out.println(marks);
		}
		obtained_marks = marks.split(",");
        
		 for(int i=0;i<obtained_marks.length;i++)
		 {
			 total=total+Integer.parseInt(obtained_marks[i]);
		 }
		 
		  System.out.println("Result"+total);
		
		//----- calculate students marks 
		String sql4 = "select * from e"+exam_id+"";
		 rs4 = selectQuery(sql4);
		ResultSet rs5 = getStudentExamId(exam_id);
		if (rs5.next()) {
			total_student = Integer.parseInt(rs.getString("countval"));
			System.out.println(total_student);
		}
		Stud_result = new int[total_student][2];
		
		int x=0;
		while (rs4.next())

		{
			
			int stud_id = rs4.getInt("s_id");
			String stud_answer = rs4.getString("answer");
			String[] stud_arr = stud_answer.split(",");
			
			for (int i = 0; i < stud_arr.length; i++) {
				
				if (correct_arr[i].equals(stud_arr[i])) {
					total_marks = total_marks
							+ Integer.parseInt(obtained_marks[i]);

				} else {

					total_marks = total_marks + 0;
				}
				   
				  
			 } 
			  
			   	Stud_result[x][0]=stud_id;
			    Stud_result[x][1]=total_marks;
			    System.out.println(Stud_result[x][0] + "----"+Stud_result[x][1]);
			    x++;
			    total_marks=0;
			
			 
		}
			
		/* for(int k=0;k<que_arr.length;k++)	
		  {
			
				String sql5 = "select s_id,substr(answer,0,1), from exam_result where s_id not in (-1,-2)";
				ResultSet rs6 = selectQuery(sql5);
				String ans_key="";
				int count1=0;
				int count2=0;
				int count3=0;
				int count4=0;
				int count5=0;
				int count6=0;
				int count7=0;
				
				while(rs6.next())
				{
					System.out.println("hii");
					String answer=rs.getString("answer");
					if(answer.equals("A"))
					{
						count1++;
					}else if(answer.equals("B")){
						count2++;
					}
                    else if(answer.equals("C")){
                    	count3++;
					}
                    else if(answer.equals("D")){
                    	count4++;
					}
                    else if(answer.equals("T")){
                    	count5++;
					}
                    else if(answer.equals("F")){
                    	count6++;
					}
                    else if(answer.equals("-")){
                    	count7++;
					}
					
					System.out.println(count1+count2+count3+count4+count5+count6+count7);
					
					
				}*/
				
				
		    
		

	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
   
	return Stud_result;
}
public static int calTotalMarks(int exam_id)
{
	String marks="";
	String[] total_marks;
	String sql = "select ques_marks from examinfo where exam_id="+exam_id;
	int total=0;
	ResultSet rs3 = selectQuery(sql);

	try {
		if (rs3.next()) {
			marks = rs3.getString("ques_marks");
			System.out.println(marks);
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	total_marks = marks.split(",");
	for(int i=0;i<total_marks.length;i++)
	{
		total=total+Integer.parseInt(total_marks[i]);
	}
	
	return total;
}

public static String checkExamresult(int exam_id) {
	String sql = "select * from  e"+exam_id+"";
     String msg="no result";
	try {
		ps = con.prepareStatement(sql);
		rs= ps.executeQuery();
		
		if(rs!=null){
		
		while(rs.next())
		{
		System.out.println(rs.getString(1)+"----------");
		}
		msg="<a href='studentsresult.jsp?exam_id="+exam_id+"'>"+"View Result"+"</a>";
		
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}

	return msg;
}

public static int[][] resultAnalysis(int exam_id)
{
	String q_str = "";
	String[] que_arr;
	String correct_str = "";
	String[] correct_arr;
	String marks = "";
	String[] obtained_marks;
	int total_student=0;
	int total=0;
	int total_marks = 0;
	ResultSet rs4=null;
	 int countarr [][]=null;
	// for question array
	String sql = "select question from examinfo where exam_id="+exam_id;	
	try {
		ps = con.prepareStatement(sql);
		ResultSet rs1 = ps.executeQuery();
		if (rs1.next()) {
			q_str = rs1.getString("question");
			System.out.println(q_str);
		}

		que_arr = q_str.split(",");
		// for  Correct answer array
		String sql1 = "select ans_key from examinfo where exam_id="+exam_id;
		ResultSet rs2 = selectQuery(sql1);

		if (rs2.next()) {
			correct_str = rs2.getString("ans_key");
			System.out.println(correct_str);
		}
		
		correct_arr = correct_str.split(",");
		System.out.println("split complete");
		for( int i=0;i<(correct_arr.length);i++)
		System.out.println(i+"   "+correct_arr[i]);
		
			String sql5 = "select answer from e"+exam_id+"";
			String arr[][]=new String[300][que_arr.length];
	       ResultSet rs6 =selectQuery(sql5);
		       
		      
				String ans_key="";
				int count1=0;
				int count2=0;
				int count3=0;
				int count4=0;
				int count5=0;
				int count6=0;
				int count7=0;
				int i=0;
				
				String answer="";
				String[] stud_arr=null;
				while(rs6.next())
				{
					
					answer=rs.getString("answer");
					 stud_arr=answer.split(",");
					 
					 for(int k=0;k<stud_arr.length;k++)
					 {
						// System.out.println(stud_arr[k]+"#####");
					 }
					 
					 
					 
					for(int j=0;j<stud_arr.length;j++){
						
						arr[i][j]=stud_arr[j];
					}
					i++;

		          } 
				
				int countA=0;
				int countB=0;
				int countC=0;
				int countD=0;
				int c=0;
				countarr=new int[stud_arr.length][4];				
				
				for(int j=0;j<stud_arr.length;j++){
					for(c=0;c<i;c++)
					{
						
						System.out.println(j+"  "+c+"    "+arr[c][j]);
						
						if(arr[c][j].equals("A")){
							
							countA++;
							
						}
						else if(arr[c][j].equals("B")){
							countB++;
						}
	                    else if(arr[c][j].equals("C")){
	                    	countC++;
						}
	                    else if(arr[c][j].equals("D")){
	                    	countD++;
						}
						
						
						
					}
						c=0;
						
						countarr[j][0]=countA;
						countarr[j][1]=countB;
						countarr[j][2]=countC;
						countarr[j][3]=countC;
						//System.out.println(countA+" ");
						countA=0;
						countB=0;
						countC=0;
						countD=0;
					//}
					
					System.out.println();
				}
				
				for(int k=0;k<stud_arr.length;k++)
				{
					for(int l=0;l<4;l++)
					{
						System.out.print(countarr[k][l]+" ");
					}
					System.out.println();
				}
				
				

	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	return countarr;
}

public static int insertAnswer(int eid, int sid, String ans_string) {
	String sql = "insert into E"+eid+"(S_ID, ANSWER, OBTAINED_MARKS) values (?,?,?)";
	int flag = 0;
	try 
	{
		ps = con.prepareStatement(sql);
		ps.setInt(1, sid);
		ps.setString(2, ans_string);
		ps.setString(3, "");
		flag = ps.executeUpdate();
	} 
	catch (Exception e) 
	{
		e.printStackTrace();
	}
	return flag;
}


public static void updateExamStatus(int exam_id){
	
	String sq = "update examinfo set status=? where exam_id="+exam_id;
	
	try {

		ps = con.prepareStatement(sq);

		
		ps.setInt(1, 1);
	
		
		int flag= ps.executeUpdate();
		 System.out.println("status--------"+flag);
		
	} catch (Exception e) 
	{
		e.printStackTrace();
	}
	
}



}


