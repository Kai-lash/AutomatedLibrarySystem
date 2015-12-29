package login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import util.InitializeConnection;

public class servlet_reset extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public servlet_reset() {
		super();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String pageOption = request.getParameter("pageOption") == null ? ""
				: request.getParameter("pageOption");
		try {
			if (pageOption.equals("jsp_forgotPass")) {
				compareAns(request, response);
			}
			if (pageOption.equals("jsp_resetPass")) {

				try {
					confirmPass(request, response);
				} catch (NamingException e) {
					System.out.println("-" + e.getMessage());
					response.sendRedirect("jsp_errorPageN.jsp?errorMsg="
							+ e.getMessage());
				}
			}
		} catch (Exception e) {
			System.out.println("-" + e.getMessage());
			response.sendRedirect("jsp_errorPageN.jsp?errorMsg="
					+ e.getMessage());
		}

	}

	public void compareAns(HttpServletRequest request,
			HttpServletResponse response) {
		String msg;
		String memId = request.getParameter("Member_Id") == null ? "" : request
				.getParameter("Member_Id");
		String ans = request.getParameter("Answer") == null ? "" : request
				.getParameter("Answer");
		System.out.println(memId + "    " + ans);

		try {

			InitializeConnection inc = new InitializeConnection();
			Connection con = inc.initConnect();
			Statement stmt = con.createStatement();
			String q1 = "SELECT MEM_ANS FROM ALS_MEMBERS WHERE UPPER(MEM_ID)=UPPER('"
					+ memId + "')";
			System.out.println(q1);
			ResultSet rs = stmt.executeQuery(q1);
			if (rs.next()) {

				if (rs.getString(1).equals(ans)) {
					msg = "Valid Member";
					response.sendRedirect("jsp_resetPass.jsp?msg1=" + msg);

				}
			} else {
				msg = "No Matching Data";
				response.sendRedirect("jsp_forgotPass.jsp?msg1=" + msg);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void confirmPass(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException, IOException, NamingException {
		String memId = request.getParameter("Member_Id") == null ? "" : request
				.getParameter("Member_Id");
		String password = request.getParameter("password") == null ? ""
				: request.getParameter("password");
		String password1 = request.getParameter("password1") == null ? ""
				: request.getParameter("password1");
		if (password.equals(password1)) {

			InitializeConnection inc = new InitializeConnection();
			Connection con = inc.initConnect();
			Statement stmt = con.createStatement();
			String q2 = "UPDATE ALS_MEMBERS SET MEM_PWD='" + password
					+ "' WHERE MEM_ID='" + memId + "'";
			System.out.println(q2);
			int n = stmt.executeUpdate(q2);
			if (n > 0) {
				System.out.println("password updated");
				String msg = "Password Updated";
				response.sendRedirect("jsp_resetPass.jsp?msg1=" + msg);
			}
		}
	}
}
