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

import util.CharValidation;
import util.InitializeConnection;

public class servlet_bookRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Vector memIdV = new Vector();
	public Vector memNameV = new Vector();
	public Vector bookNameV = new Vector();
	public Vector authorNameV = new Vector();
	public Vector requestIdV = new Vector();

	// for book status display

	public Vector reqBookNameV2 = new Vector();
	public Vector reqAuthorNameV2 = new Vector();
	public Vector requestIdV2 = new Vector();
	public Vector reqBookStatusV2 = new Vector();

	public servlet_bookRequest() {
		super();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String pageOption = request.getParameter("pageOption") == null ? ""
				: request.getParameter("pageOption");
		try {
			if (pageOption.equals("newBookRequest")) {
				newBookRequest(request, response);
			} else if (pageOption.equals("jsp_reportBookRequest")) {

				approveRequest(request, response);
			}
		} catch (Exception e) {

			System.out.println("-" + e.getMessage());
			response.sendRedirect("jsp_errorPageN.jsp?errorMsg="
					+ e.getMessage());
		}
	}

	void newBookRequest(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		String msg = "";
		String reqBookName = request.getParameter("reqBookName") == null ? ""
				: request.getParameter("reqBookName");
		String reqBookAuthor = request.getParameter("reqBookAuthor") == null ? ""
				: request.getParameter("reqBookAuthor");
		String reqBookPub = request.getParameter("reqBookPub") == null ? ""
				: request.getParameter("reqBookPub");
		String reqBookVersion = request.getParameter("reqBookVersion") == null ? ""
				: request.getParameter("reqBookVersion");
		CharValidation cv = new CharValidation();

		if (reqBookName.equals("")) {
			msg = "Book Name cannot be blank !";
			response.sendRedirect("jsp_request.jsp?msg=" + msg);
		} else if (cv.validate(reqBookName)) {
			msg = "Invalid Character in Book Name !";
			response.sendRedirect("jsp_request.jsp?msg=" + msg);
		} else if (reqBookAuthor.equals("")) {
			msg = "Author Name cannot be blank !";
			response.sendRedirect("jsp_request.jsp?msg=" + msg);
		} else if (cv.validate(reqBookAuthor)) {
			msg = "Invalid Character in Author Name !";
			response.sendRedirect("jsp_request.jsp?msg=" + msg);
		} else if (reqBookPub.equals("")) {
			msg = "Publisher Name cannot be blank !";
			response.sendRedirect("jsp_request.jsp?msg=" + msg);
		} else {
			// business logic will be applied here
			String str = "";
			String str1 = "";
			int id = 0;
			int reqBookVersion1 = 0;
			try {

				reqBookVersion1 = Integer.parseInt(reqBookVersion);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}

			try {
				String memId = "";

				HttpSession hs = request.getSession();
				memId = (String) hs.getAttribute("Member_Id") == null ? ""
						: (String) hs.getAttribute("Member_Id");
				System.out.println(memId);

				InitializeConnection inc = new InitializeConnection();
				Connection con = inc.initConnect();
				
				Statement st = con.createStatement();
				ResultSet rs = st
						.executeQuery("SELECT BOOK_ISSUEID.NEXTVAL FROM DUAL");
				while (rs.next()) {
					id = rs.getInt(1);
				}
				if (id < 10) {
					str = "BRID0000";
				}
				if (id >= 10 && id < 100) {
					str = "BRID000";
				}
				if (id >= 100 && id < 1000) {
					str = "BRID00";
				}
				if (id >= 1000 && id < 10000) {
					str = "BRID0";
				}

				PreparedStatement ps = con.prepareStatement("SELECT CONCAT(?,"
						+ id + ") FROM DUAL");
				ps.setString(1, str);
				// ps.setString
				ResultSet rs1 = ps.executeQuery();
				while (rs1.next()) {
					str1 = rs1.getString(1);
					System.out.println(str);
				}

				PreparedStatement ps1 = con
						.prepareStatement("INSERT INTO BOOK_REQUEST VALUES (UPPER(?),?,UPPER(?),UPPER(?),UPPER(?),?,?,SYSDATE)");
				ps1.setString(1, memId);
				ps1.setString(2, str1);
				ps1.setString(3, reqBookName);
				ps1.setString(4, reqBookAuthor);
				ps1.setString(5, reqBookPub);
				ps1.setInt(6, reqBookVersion1);
				ps1.setString(7, "PENDING");
				int n = ps1.executeUpdate();
				if (n > 0) {
					System.out.println("record inserted");
				}

				ps.close();
				ps1.close();
				st.close();

				con.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			msg = "Request Successfully Placed";
			response.sendRedirect("jsp_request.jsp?msg=" + msg);
		}
	}

	public void reportBookRequest() throws ClassNotFoundException, SQLException {

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();

		Statement stmt = con.createStatement();
		String q = "SELECT M.MEM_FNAME,BR.MEM_ID,BR.BOOK_NAME,BR.BOOK_AUTHOR,BR.BOOK_REQUEST_ID FROM ALS_MEMBERS M, BOOK_REQUEST BR WHERE BR.MEM_ID=M.MEM_ID AND BR.BOOK_STATUS='PENDING'";
		System.out.println("l " + q);
		ResultSet rs = stmt.executeQuery(q);
		while (rs.next()) {

			memNameV.add(rs.getString(1));
			memIdV.add(rs.getString(2));
			bookNameV.add(rs.getString(3));
			authorNameV.add(rs.getString(4));
			requestIdV.add(rs.getString(5));

		}
		con.commit();
		con.close();

	}

	public void approveRequest(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException, IOException {

		String memId = request.getParameter("memId") == null ? "" : request
				.getParameter("memId");
		System.out.println("br memid " + memId);

		String requestId = request.getParameter("requestId") == null ? ""
				: request.getParameter("requestId");

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();

		Statement stmt = con.createStatement();
		String msg = "Book request could not be Approved";
		String q = "UPDATE BOOK_REQUEST SET BOOK_STATUS='APPROVED' WHERE MEM_ID='"
				+ memId + "' AND BOOK_REQUEST_ID='" + requestId + "'";
		System.out.println("k " + q);
		int rs = stmt.executeUpdate(q);
		if (rs > 0) {

			msg = "Book Request Approved";
			response.sendRedirect("jsp_reportBookRequest.jsp?msg=" + msg);
		}
		con.commit();
		con.close();

	}

	public void requestStatus(HttpServletRequest request)
			throws ClassNotFoundException, SQLException, IOException {

		String memId = "";
		HttpSession hs = request.getSession();
		memId = (String) hs.getAttribute("Member_Id") == null ? ""
				: (String) hs.getAttribute("Member_Id");
		System.out.println(memId);

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();

		Statement stmt = con.createStatement();
		// String msg="Book request could not be Approved";
		ResultSet rs = stmt
				.executeQuery("SELECT BOOK_NAME,BOOK_AUTHOR,BOOK_REQUEST_ID,BOOK_STATUS FROM BOOK_REQUEST WHERE MEM_ID=UPPER('"
						+ memId + "')");
		while (rs.next()) {

			reqBookNameV2.add(rs.getString(1));
			reqAuthorNameV2.add(rs.getString(2));
			requestIdV2.add(rs.getString(3));
			reqBookStatusV2.add(rs.getString(4));

		}
		con.commit();
		con.close();

	}

}
