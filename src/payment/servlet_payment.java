package payment;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import util.InitializeConnection;

public class servlet_payment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public String msg = "";
	public String msg1 = "";
	public Vector mem_IdV = new Vector();
	public Vector trans_IdV = new Vector();
	public Vector mode_Of_PaymentV = new Vector();
	public Vector amountV = new Vector();
	public Vector payment_DateV = new Vector();
	public Vector fees_TypeV = new Vector();

	public servlet_payment() {
		super();

	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String pageOption = request.getParameter("pageOption") == null ? ""
				: request.getParameter("pageOption");

		if (pageOption.equals("makePayment")) {
			try {
				insertPayment(request, response);
			} catch (Exception e) {

				System.out.println("-" + e.getMessage());
				response.sendRedirect("jsp_errorPageN.jsp?errorMsg="
						+ e.getMessage());
			}
		} else if (pageOption.equals("makeFinePayment")) {
			try {
				payFine(request, response);
			} catch (Exception e) {

				System.out.println("-" + e.getMessage());
				response.sendRedirect("jsp_errorPageN.jsp?errorMsg="
						+ e.getMessage());
			}
		}
	}

	public void showPrevPayment(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException {
		HttpSession hs = request.getSession();
		String memId = (String) hs.getAttribute("Member_Id");

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();
		Statement st = con.createStatement();
		String query = "SELECT MEM_ID,TRANS_ID,MODE_OF_PAYMENT,NVL(AMOUNT,0),TO_CHAR(PAYMENT_DATE,'DD-MON-YY'),FEES_TYPE FROM PAYMENT WHERE MEM_ID=UPPER('"
				+ memId + "') ORDER BY PAYMENT_DATE DESC";
		ResultSet rs = st.executeQuery(query);
		while (rs.next()) {
			mem_IdV.add(rs.getString(1));
			trans_IdV.add(rs.getString(2));
			mode_Of_PaymentV.add(rs.getString(3));
			amountV.add(rs.getString(4));
			payment_DateV.add(rs.getString(5));
			fees_TypeV.add(rs.getString(6));
		}
		st.close();
		con.close();
	}

	public void payFine(HttpServletRequest request, HttpServletResponse response)
			throws ClassNotFoundException, SQLException, IOException {
		HttpSession hs = request.getSession();
		String memId = (String) hs.getAttribute("Member_Id") == null ? ""
				: (String) hs.getAttribute("Member_Id");
		System.out.println("=====" + memId);
		String amount = request.getParameter("amount") == null ? "" : request
				.getParameter("amount");

		String payment_Mode = request.getParameter("payment_Mode") == null ? ""
				: request.getParameter("payment_Mode");

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();

		Statement st = con.createStatement();
		String query = "UPDATE ISSUE_BOOKS SET NO_DAYS_OVERDUE=0, FINE_STATUS='PAID' WHERE MEM_ID=UPPER('"
				+ memId + "')";
		int rs = st.executeUpdate(query);

		Statement st1 = con.createStatement();
		String str = "";
		String str1 = "";
		int id = 0;
		ResultSet rs1 = st
				.executeQuery("SELECT BOOK_ISSUEID.NEXTVAL FROM DUAL");
		while (rs1.next()) {
			id = rs1.getInt(1);
		}
		if (id < 10) {
			str = "TR0000";
		}
		if (id >= 10 && id < 100) {
			str = "TR000";
		}
		if (id >= 100 && id < 1000) {
			str = "TR00";
		}
		if (id >= 1000 && id < 10000) {
			str = "TR0";
		}

		PreparedStatement ps = con.prepareStatement("SELECT CONCAT(?," + id
				+ ") FROM DUAL");
		ps.setString(1, str);
		// ps.setString
		ResultSet rs2 = ps.executeQuery();
		while (rs2.next()) {
			str1 = rs2.getString(1);
			System.out.println(str);
		}

		String query1 = "INSERT INTO PAYMENT VALUES(UPPER('" + memId + "'),'"
				+ str1 + "','" + payment_Mode + "','" + amount
				+ "',SYSDATE,'FINE')";
		int rs3 = st1.executeUpdate(query1);

		String msg = "Fine Successfully Paid!";

		st.close();
		st1.close();
		con.close();

		response.sendRedirect("jsp_bookFine.jsp?msg=" + msg);
	}

	public void showPaymentDetails(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException, IOException, NamingException {
		boolean flag = false;
		HttpSession hs = request.getSession();
		String memId = (String) hs.getAttribute("Member_Id");
		System.out.println("=====" + memId);

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();

		Statement st = con.createStatement();
		String query = "SELECT FEES_TYPE FROM PAYMENT WHERE MEM_ID=UPPER('"
				+ memId
				+ "') AND TO_CHAR(PAYMENT_DATE,'YYYY')=TO_CHAR(SYSDATE,'YYYY')";
		System.out.println(query);
		ResultSet rs = st.executeQuery(query);
		while (rs.next()) {

			if (rs.getString(1).equalsIgnoreCase("ANNUAL")) {
				msg = "P";
				flag = true;
			}
		}
		System.out.println(flag);

		if (flag == false) {
			System.out.println("flag1 " + flag);
			Statement s1 = con.createStatement();
			ResultSet r1 = s1
					.executeQuery("SELECT MEM_TYPE FROM ALS_MEMBERS WHERE MEM_ID=UPPER('"
							+ memId + "')");
			while (r1.next()) {
				if ((r1.getString(1)).equalsIgnoreCase("NORMAL")) {
					Statement st1 = con.createStatement();
					String query1 = "SELECT MEM_ID FROM PAYMENT WHERE MEM_ID=UPPER('"
							+ memId + "')AND PAYMENT_DATE<(SYSDATE-365)";
					System.out.println("HH : " + query1);
					ResultSet rs1 = st1.executeQuery(query1);
					if (rs1.next()) {
						System.out.println("normal");
						msg = "Your annual fee RS.1000/- is to be paid";
					} else {
						msg = "Already paid";
						
					}
					st1.close();
				} else {
					Statement st2 = con.createStatement();
					String query2 = "SELECT M.MEM_ID FROM ALS_MEMBERS M,PAYMENT P WHERE M.MEM_ID=P.MEM_ID AND M.MEM_ID=UPPER('"
							+ memId
							+ "')AND UPPER(M.MEM_TYPE)='PREMIUM' AND P.PAYMENT_DATE<(SYSDATE-(365*5))";
					ResultSet rs2 = st2.executeQuery(query2);
					System.out.println("HH : " + query2);
					if (rs2.next()) {
						System.out.println("premium ");
						msg = "Your annual fee RS.1000/- is to be paid";
					} else {
						msg = "You have already paid";
						
					}
					st2.close();
				}
			}
			st.close();
			con.close();
		}// if cond.
	}

	public void insertPayment(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException, IOException, NamingException {
		int trans_Id = 0;
		String mode = request.getParameter("payment_Mode") == null ? "Net_Banking"
				: request.getParameter("payment_Mode");
		HttpSession hs = request.getSession();
		String memId = (String) hs.getAttribute("Member_Id");
		System.out.println("=====" + memId);

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();

		Statement st1 = con.createStatement();
		ResultSet rs1 = st1

		.executeQuery("select trans_id.nextval from dual");
		String trstr = "";
		int i = 0;
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

		PreparedStatement st2 = con.prepareStatement("select concat(?," + i
				+ ") from dual");
		st2.setString(1, trstr);
		ResultSet rs2 = st2.executeQuery();

		if (rs2.next()) {
			s1 = rs2.getString(1);
			System.out.println(s1);
		}

		String query3 = "INSERT INTO PAYMENT VALUES(upper(?),'" + s1
				+ "',?,1000,SYSDATE,'ANNUAL')";
		PreparedStatement st = con.prepareStatement(query3);
		st.setString(1, memId);
		st.setString(2, mode);
		int m = st.executeUpdate();
		if (m > 0) {
			String paymentDoneMsg = "Your payment of Rs.1000/- is done successfully";
			System.out.println("record inserted");
			response.sendRedirect("jsp_paymentDone.jsp?paymentDoneMsg="
					+ paymentDoneMsg);
		}
		st.close();
		con.close();

	}
}
