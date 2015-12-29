package book;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.InitializeConnection;

public class servlet_bookReturn extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Vector book_IdV1 = new Vector();
	public Vector book_NameV1 = new Vector();
	public Vector book_AuthorV1 = new Vector();
	public Vector book_issueDateV1 = new Vector();
	public Vector book_ExpReturnDateV1 = new Vector();
	public Vector no_OverdueV1 = new Vector();
	public Vector book_FineV1 = new Vector();

	public Vector book_IdV = new Vector();
	public Vector book_NameV = new Vector();
	public Vector book_AuthorV = new Vector();
	public Vector book_issueDateV = new Vector();
	public Vector book_ExpReturnDateV = new Vector();
	public Vector no_OverdueV = new Vector();
	public Vector book_FineV = new Vector();
	public String msg = "";
	String memId;

	public servlet_bookReturn() {
		super();

	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String pageOption = request.getParameter("pageOption") == null ? ""
				: request.getParameter("pageOption");

		if (pageOption.equals("bookReturn")) {
			try {
				returnUpdate(request, response);
			} catch (Exception e) {
				System.out.println("-" + e.getMessage());
				response.sendRedirect("jsp_errorPageN.jsp?errorMsg="
						+ e.getMessage());
			}
		}

	}

	public void bookReturn(HttpServletRequest request,
			HttpServletResponse response) throws IOException,
			ClassNotFoundException, SQLException {

		// business logic will be applied here
		HttpSession hs = request.getSession();
		memId = (String) hs.getAttribute("Member_Id") == null ? ""
				: (String) hs.getAttribute("Member_Id");
		System.out.println(memId);

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();

		Statement st = con.createStatement();
		String queryString = "SELECT B.BOOK_ID,B.BOOK_NAME,B.BOOK_AUTHOR,TO_CHAR(I.BOOK_ISSUE_DATE,'DD-MM-YYYY') ,TO_CHAR(I.BOOK_EXP_RET_DATE,'DD-MM-YYYY') FROM BOOKS B,ISSUE_BOOKS I WHERE B.BOOK_ID=I.BOOK_ID AND I.MEM_ID=UPPER('"
				+ memId + "') AND I. BOOK_ACT_RET_DATE IS NULL";
		System.out.println(queryString);
		if (!(memId.equals(""))) {
			ResultSet rs = st.executeQuery(queryString);
			// System.out.println("-----" + memId);
			while (rs.next()) {
				book_IdV.add(rs.getString(1));
				book_NameV.add(rs.getString(2));
				book_AuthorV.add(rs.getString(3));
				book_issueDateV.add(rs.getString(4));
				book_ExpReturnDateV.add(rs.getString(5));
			}

			String queryString2 = "SELECT B.BOOK_ID,B.BOOK_NAME,B.BOOK_AUTHOR,TO_CHAR(I.BOOK_ISSUE_DATE,'DD-MM-YYYY') ,TO_CHAR(I.BOOK_EXP_RET_DATE,'DD-MM-YYYY') FROM BOOKS B,ISSUE_BOOKS I WHERE B.BOOK_ID=I.BOOK_ID AND I.MEM_ID=UPPER('"
					+ memId
					+ "') AND (I. BOOK_ACT_RET_DATE IS NULL) AND FINE_STATUS='NA'";
			System.out.println(queryString2);
			if (!(memId.equals(""))) {
				ResultSet rs2 = st.executeQuery(queryString2);
				// System.out.println("-----" + memId);
				while (rs2.next()) {
					book_IdV1.add(rs2.getString(1));
					book_NameV1.add(rs2.getString(2));
					book_AuthorV1.add(rs2.getString(3));
					book_issueDateV1.add(rs2.getString(4));
					book_ExpReturnDateV1.add(rs2.getString(5));
				}

				Statement st1 = con.createStatement();
				String query = "SELECT TO_CHAR(BOOK_EXP_RET_DATE,'DD-MM-YYYY'),ROUND(SYSDATE-BOOK_EXP_RET_DATE) FROM ISSUE_BOOKS WHERE MEM_ID=UPPER('"
						+ memId + "') AND BOOK_ACT_RET_DATE IS NULL";
				System.out.println(query);
				ResultSet rs1 = st1.executeQuery(query);
				while (rs1.next()) {
					String s1 = rs1.getString(1);
					int n = rs1.getInt(2);
					if (n < 0) {
						no_OverdueV.add(0);
						book_FineV.add(0);
					} else {
						no_OverdueV.add(n);
						book_FineV.add(n * 1);
					}
				}

				String query3 = "SELECT TO_CHAR(BOOK_EXP_RET_DATE,'DD-MM-YYYY'),ROUND(SYSDATE-BOOK_EXP_RET_DATE) FROM ISSUE_BOOKS WHERE MEM_ID=UPPER('"
						+ memId
						+ "') AND BOOK_ACT_RET_DATE IS NULL AND FINE_STATUS='NA'";
				System.out.println(query3);
				ResultSet rs3 = st1.executeQuery(query3);
				while (rs3.next()) {
					String s1 = rs3.getString(1);
					int n = rs3.getInt(2);
					if (n < 0) {
						no_OverdueV1.add(0);
						book_FineV1.add(0);
					} else {
						no_OverdueV1.add(n);
						book_FineV1.add(n * 1);
					}
				}

				st1.close();
			}
			st.close();

		}
		con.close();
	}

	public void returnUpdate(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException, IOException {
		int n = 0;
		HttpSession hs = request.getSession();
		memId = (String) hs.getAttribute("Member_Id");
		System.out.println("+++" + memId);
		String bookId = request.getParameter("Return") == null ? "" : request
				.getParameter("Return");
		System.out.println("id:" + bookId);

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();
		
		String fineStatus="";
		boolean flag=false;
		Statement st = con.createStatement();
		ResultSet rs = st
				.executeQuery("SELECT ROUND(SYSDATE-BOOK_EXP_RET_DATE),FINE_STATUS FROM ISSUE_BOOKS WHERE BOOK_ID='"
						+ bookId + "' AND MEM_ID=UPPER('" + memId + "') AND BOOK_ACT_RET_DATE IS NULL");
		while (rs.next()) {
			n = rs.getInt(1);
			fineStatus=rs.getString(2);
			if(fineStatus.equalsIgnoreCase("PAID") || n<0){
				flag=true;
			}
			if (n < 0){
				n = 0;
			}
		}
		
		
		if(flag==true){

		String q1 = "UPDATE ISSUE_BOOKS SET BOOK_ACT_RET_DATE=SYSDATE,NO_DAYS_OVERDUE="
				+ n
				+ " WHERE BOOK_ID='"
				+ bookId
				+ "' AND MEM_ID=UPPER('"
				+ memId + "')";
		Statement st1 = con.createStatement();
		System.out.println(q1);
		int n1 = st1.executeUpdate(q1);
		if (n1 > 0) {
			System.out.println("issue table updated");
		}
		String q2 = "UPDATE BOOKS SET BOOK_QTY=(BOOK_QTY+1) WHERE BOOK_ID='"
				+ bookId + "'";
		// System.out.println(q2);
		Statement st2 = con.createStatement();
		int n2 = st1.executeUpdate(q2);
		if (n2 > 0) {
			System.out.println("book table updated");
		}
		msg = "Book Returned Succcessfully !";
		st.close();
		st1.close();
		con.close();
		response.sendRedirect("jsp_return.jsp?msg=" + msg);
		}
		else
		{
			msg="Please pay the fine for this book before returning it!";
			st.close();
			con.close();
			response.sendRedirect("jsp_return.jsp?msg=" + msg);
		}
	}
}
