package login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import util.CharValidation;
import util.InitializeConnection;

public class servlet_memberRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Vector memId = new Vector();
	public Vector memName = new Vector();

	public servlet_memberRegistration() {
		super();

	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String pageOption = request.getParameter("pageOption") == null ? ""
				: request.getParameter("pageOption");

		if (pageOption.equals("registrationForm")) {
			try {
				memRegister(request, response);
			} catch (Exception e) {

				System.out.println("-"+e.getMessage());
				response.sendRedirect("jsp_errorPageN.jsp?errorMsg="+e.getMessage());
			}
		} else if (pageOption.equals("memActivate")) {
			try {
				// memActivateList();
				memActivate(request, response);
			} catch (Exception e) {
				System.out.println("-"+e.getMessage());
				response.sendRedirect("jsp_errorPageN.jsp?errorMsg="+e.getMessage());
			}
		}

	}

	void memRegister(HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, ClassNotFoundException {
		HttpSession hs = request.getSession();
		String mem_Id = "";
		mem_Id = (String) hs.getAttribute("Member_Id") == null ? ""
				: (String) hs.getAttribute("Member_Id");
		System.out.println("mmm " + mem_Id);
		String msg = "";
		String firstName = request.getParameter("firstName") == null ? ""
				: request.getParameter("firstName");
		String middleName = request.getParameter("middleName") == null ? ""
				: request.getParameter("middleName");
		String lastName = request.getParameter("lastName") == null ? ""
				: request.getParameter("lastName");
		String password = request.getParameter("password") == null ? ""
				: request.getParameter("password");
		String cpassword = request.getParameter("cpassword") == null ? ""
				: request.getParameter("cpassword");
		String address = request.getParameter("address") == null ? "" : request
				.getParameter("address");
		String emailId = request.getParameter("emailId") == null ? "" : request
				.getParameter("emailId");
		String contactNo = request.getParameter("contactNo") == null ? ""
				: request.getParameter("contactNo");
		String membershipType = request.getParameter("membershipType") == null ? ""
				: request.getParameter("membershipType");
		String sec_que = request.getParameter("SecurityQuestion") == null ? ""
				: request.getParameter("SecurityQuestion");
		String sec_que_ans = request.getParameter("sec_que_ans") == null ? ""
				: request.getParameter("sec_que_ans");
		String amount = request.getParameter("amount") == null ? "" : request
				.getParameter("amount");
		CharValidation cv = new CharValidation();

		String paymode = request.getParameter("mode") == null ? "" : request
				.getParameter("mode");
		String cardno = request.getParameter("cardno") == null ? "" : request
				.getParameter("cardno");
		String cvvno = request.getParameter("cvvno") == null ? "" : request
				.getParameter("cvvno");
		String cardName = request.getParameter("cardName") == null ? ""
				: request.getParameter("cardName");
		String mem_Fees = request.getParameter("membershipType") == null ? ""
				: request.getParameter("membershipType");

		if (firstName.equals("")) {
			msg = "First Name cannot be blank !";
			response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
		} else if (cv.validate(firstName)) {
			msg = "Invalid Character in First Name !";
			response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
		} else if (password.equals("")) {
			msg = "Password cannot be blank !";
			response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
		} else if (!(password.equals(cpassword))) {
			msg = "Password not matching !";
			response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
		} else if (address.equals("")) {
			msg = "Address cannot be blank !";
			response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
		} else if (emailId.equals("")) {
			msg = "Email ID cannot be blank !";
			response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
		} else if (cv.validateEmail(emailId)) {
			msg = "Invalid Email ID !";
			response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
		} else if (contactNo.equals("")) {
			msg = "Contact number cannot be blank !";
			response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
		} else if (membershipType.equals("")) {
			msg = "Please select a Membership Type !";
			response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
		} else if (amount.equals("")) {
			msg = "Amount cannot be blank !";
			response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
		}

		/*
		 * else if (paymode.equals("")) { msg = "Select payment mode !";
		 * response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg); } else
		 * if (cv.validate(paymode)) { msg =
		 * "Invalid Character in First Name !";
		 * response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg); }else
		 * if (cardno.equals("")) { msg = "Card Number cannot be blank !";
		 * response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg); }else
		 * if ((cardno.length()>16) || (cardno.length()<16)) { msg =
		 * "Card Number Should Be 16 Digits !";
		 * response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg); } else
		 * if (cvvno.equals("")) { msg = "CVV Number cannot be blank !";
		 * response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg); } else
		 * if ((cvvno.length()>3) || (cvvno.length()<3)) { msg =
		 * "cvvno cannot be blank !";
		 * response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg); } else
		 * if (cardName.equals("")) { msg = "Card Name cannot be blank !";
		 * response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg); }
		 */

		else {
			try {
				long contactNoInt = Integer.parseInt(contactNo);

				InitializeConnection inc = new InitializeConnection();
				Connection con = inc.initConnect();
				Statement st = con.createStatement();

				// for
				// registration***********************************************

				ResultSet rs = st
						.executeQuery("select mem_id.nextval from dual");
				String lmstr = "";
				int j = 0;
				int i = 0;
				String s4 = "";
				while (rs.next()) {
					j = rs.getInt(1);
				}
				if (j < 10) {
					lmstr = "LM000";
				} else if ((j > 9) && (j < 100)) {
					lmstr = "LM00";
				} else if ((i > 99) && (i < 1000)) {
					lmstr = "LM0";
				}

				PreparedStatement st4 = con.prepareStatement("select concat(?,"
						+ j + ") from dual");
				st4.setString(1, lmstr);
				ResultSet rs4 = st4.executeQuery();

				if (rs4.next()) {
					s4 = rs4.getString(1);
					System.out.println(s4);
				}

				PreparedStatement pstmt4 = con
						.prepareStatement("Insert into ALS_MEMBERS values(UPPER(?),?,UPPER(?),UPPER(?),UPPER(?),UPPER(?),UPPER(?),?,UPPER(?),UPPER(?),sysdate,UPPER(?),UPPER(?))");
				pstmt4.setString(1, s4);
				pstmt4.setString(2, password);
				pstmt4.setString(3, firstName);
				pstmt4.setString(4, middleName);
				pstmt4.setString(5, lastName);
				pstmt4.setString(6, address);
				pstmt4.setString(7, emailId);
				pstmt4.setString(8, contactNo);
				pstmt4.setString(9, membershipType);
				pstmt4.setString(10, "INACTIVE");
				pstmt4.setString(11, sec_que);
				pstmt4.setString(12, sec_que_ans);

				// pstmt.setString(11,"sysdate");
				int n4 = pstmt4.executeUpdate();
				if (n4 > 0) {
					System.out.println("record inserted");
				}

				Statement stmt = con.createStatement();
				String sysd = "";
				ResultSet rset = stmt
						.executeQuery("select to_CHAR(sysdate,'dd-MON-YYYY') from dual");

				while (rset.next()) {
					sysd = rset.getString(1);
				}

				// for payment*************************************************

				ResultSet rs1 = st

				.executeQuery("select trans_id.nextval from dual");
				String trstr = "";
				i = 0;
				String s1 = "";
				while (rs1.next()) {
					i = rs1.getInt(1);
				}
				if (i < 10) {
					trstr = "TR000";
				} else if ((i > 9) && (i < 100)) {
					trstr = "TR00";
				} else if ((i > 99) && (i < 1000)) {
					trstr = "TR0";
				}

				PreparedStatement st1 = con.prepareStatement("select concat(?,"
						+ i + ") from dual");
				st1.setString(1, trstr);
				ResultSet rs2 = st1.executeQuery();

				if (rs2.next()) {
					s1 = rs2.getString(1);
					System.out.println(s1);
				}

				PreparedStatement pstmt = con
						.prepareStatement("Insert into payment values(?,?,?,?,sysdate,?)");
				pstmt.setString(1, s4);
				pstmt.setString(2, s1);
				pstmt.setString(3, paymode);
				pstmt.setString(4, amount);
				pstmt.setString(5, "MEMBERSHIP");

				int n = pstmt.executeUpdate();
				if (n > 0) {
					System.out.println("record inserted");
				}

				con.close();

				String msgSuccess = "Registered Successfully";
				String msgMemId = "" + s4;
				String msgMemName = "" + firstName;
				String msgTransId = "" + s1;
				String msgTransDate = "" + sysd;
				String msgTransAmount = "" + amount;
				String msgFeesType = "MEMBERSHIP";

				response.sendRedirect("jsp_paySlip.jsp?msgSuccess="
						+ msgSuccess + "&msgMemId=" + msgMemId + "&msgMemName="
						+ msgMemName + "&msgTransId=" + msgTransId
						+ "&msgTransDate=" + msgTransDate + "&msgTransAmount="
						+ msgTransAmount + "&msgFeesType=" + msgFeesType);

			} catch (NumberFormatException Ne) {
				msg = "Contact number should be numeric !";
				response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
			} catch (Exception e) {
				e.printStackTrace();
			}

			// business logic should be applied here

		}
	}

	public void memActivateList() throws IOException, SQLException,
			ClassNotFoundException, NamingException {

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();
		Statement stmt = con.createStatement();
		ResultSet rs = stmt
				.executeQuery("SELECT MEM_ID,MEM_FNAME FROM ALS_MEMBERS WHERE UPPER(MEM_STATUS)='INACTIVE'");

		while (rs.next()) {
			memId.add(rs.getString(1));
			memName.add(rs.getString(2));
		}
	}

	public void memActivate(HttpServletRequest request,
			HttpServletResponse response) throws IOException, SQLException,
			ClassNotFoundException, NamingException {

		String memId = request.getParameter("memId");

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();
		Statement stmt = con.createStatement();
		ResultSet rs = stmt
				.executeQuery("UPDATE ALS_MEMBERS SET MEM_STATUS='ACTIVE' WHERE MEM_ID='"
						+ memId + "'");

		con.commit();
		con.close();
		String msg = "Successfully Activated!!";
		response.sendRedirect("jsp_memStatusActivate.jsp?msg=" + msg);
	}
}
