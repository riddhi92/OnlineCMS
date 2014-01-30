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
					"jdbc:oracle:thin:@202.141.152.20:1521:xe",
					"DAC13_130840320049", "Nishi1991");

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
	
	public static DBConnection getObject() {
		return new DBConnection();
	}
	
	public static boolean deleteQuery(String sql)
	{
		boolean status = false;
		int flag;
		try {
			flag = ps.executeUpdate(sql);
			if(flag == 1)
				status = true;
			else
				status = false;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return status; 
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
		int flag = 0;
		String sql = "insert into examinfo(exam_id,subject,total_quest,exam_date,venue,result_date,hardness) values(exam_id.NEXTVAL,?,?,?,?,?,?)";
		try {
			ps = con.prepareStatement(sql);

			ps.setString(1, Sub_name);
			ps.setInt(2, totalque);
			ps.setDate(3, rs.getDate(1));
			ps.setString(4, venue);
			ps.setDate(5, rs1.getDate(1));
			ps.setInt(6, hardness);
			flag = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
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

	public static ResultSet getStudentExamId() {
		String sql = "select count(*) countval from exam_result";

		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rs;
	}

	public static int updateExamResponse(String question) {
		// TODO Auto-generated method stub
		int flg=0;
		
		String sql = "update examinfo set question=? where exam_id=33";
				
		try {

			ps = con.prepareStatement(sql);
			ps.setString(1, question);
			flg = ps.executeUpdate();
			
			
		} catch (Exception e) 
		{
			e.printStackTrace();
		}
		return flg;
	}

}
