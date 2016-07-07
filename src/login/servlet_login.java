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
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import util.InitializeConnection;

public class servlet_login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public servlet_login() {
		super();
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String pageOption = request.getParameter("pageOption") == null ? ""
				: request.getParameter("pageOption");
		String loginOption = request.getParameter("loginOption") == null ? ""
				: request.getParameter("loginOption");

		if (pageOption.equals("memLogin")) {
			try {
				if (loginOption.equals("member")) {
					memLogin(request, response);
					
				} else if (loginOption.equals("librarian")) {
					libLogin(request, response);
				}

			} catch (Exception e) {
				//e.printStackTrace();
				System.out.println("-"+e.getMessage());
				response.sendRedirect("jsp_errorPageN.jsp?errorMsg="+e.getMessage());
			}
		}
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String pageOption = request.getParameter("pageOption") == null ? ""
				: request.getParameter("pageOption");

		if (pageOption.equals("memLogin")) {
			try {
				memLogin(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (pageOption.equals("libLogin")) {
			try {
				libLogin(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (pageOption.equals("LogOut")) {
			try {
				logOut(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
	}

	void memLogin(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ClassNotFoundException, SQLException,
			NamingException {

		String msg = "";
		String loginId = request.getParameter("loginId") == null ? "" : request
				.getParameter("loginId");
		String password = request.getParameter("password") == null ? ""
				: request.getParameter("password");
		String remember = request.getParameter("remember") == null ? ""
				: request.getParameter("remember");
		System.out.println("++++++" + remember);
		if (loginId.equals("")) {
			msg = "Login ID cannot be blank !";
			response.sendRedirect("jsp_memlogin.jsp?msg=" + msg);
		} else if (password.equals("")) {
			msg = "Password cannot be blank !";
			response.sendRedirect("jsp_memlogin.jsp?msg=" + msg);
		} else {
			InitializeConnection inc = new InitializeConnection();
			Connection con = inc.initConnect();

			Statement stmt = con.createStatement();
			msg = "Your Account is yet to be Activated by Librarian!!";

			String q = "SELECT MEM_STATUS FROM ALS_MEMBERS WHERE MEM_ID=UPPER('"
					+ loginId + "') AND MEM_PWD='" + password
					+ "' AND MEM_STATUS NOT IN ('ACTIVE','Active','active')";
			System.out.println("g " + q);
			ResultSet rs = stmt.executeQuery(q);

			if (rs.next()) {
				response.sendRedirect("jsp_memlogin.jsp?msg=" + msg);
			} else {

				q = "SELECT MEM_FNAME FROM ALS_MEMBERS WHERE MEM_ID=UPPER('"
						+ loginId + "') AND MEM_PWD='" + password
						+ "' AND MEM_STATUS IN('ACTIVE','Active','active')";
				System.out.println("g " + q);
				rs = stmt.executeQuery(q);

				if (rs.next()) {
					String fname = rs.getString(1);
					HttpSession hs = request.getSession();
					hs.setAttribute("Member_Name", fname);
					hs.setAttribute("Member_Id", loginId);
					if (remember.equals("yes")) {
						Cookie ck = new Cookie("Member_Id", loginId);
						response.addCookie(ck);
						Cookie ck1 = new Cookie("password", password);
						response.addCookie(ck1);
					}
					msg = "Welcome ";
					response.sendRedirect("jsp_memOptions.jsp?msg=" + msg);
				} else {
					msg = "Invalid Username or Password!!";
					response.sendRedirect("jsp_memlogin.jsp?msg=" + msg);
				}
			}
		}
	}

	void libLogin(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ClassNotFoundException, SQLException,
			NamingException {

		String msg = "";
		String loginId = request.getParameter("loginId") == null ? "" : request
				.getParameter("loginId");
		String password = request.getParameter("password") == null ? ""
				: request.getParameter("password");
		String remember = request.getParameter("remember") == null ? ""
				: request.getParameter("remember");
		if (loginId.equals("")) {
			msg = "Login ID cannot be blank !";
			response.sendRedirect("jsp_memlogin.jsp?msg=" + msg);
		} else if (password.equals("")) {
			msg = "Password cannot be blank !";
			response.sendRedirect("jsp_memlogin.jsp?msg=" + msg);
		} else {

			// business logic will be applied here

			InitializeConnection inc = new InitializeConnection();
			Connection con = inc.initConnect();
			Statement stmt = con.createStatement();
			ResultSet rs = stmt
					.executeQuery("SELECT LIB_NAME FROM LIBRARIAN WHERE LIB_ID= UPPER('"
							+ loginId + "') AND LIB_PWD='" + password + "'");

			if (rs.next()) {
				String libName = rs.getString(1);
				HttpSession hs = request.getSession();
				hs.setAttribute("Lib_Name", libName);
				hs.setAttribute("Lib_ID", loginId);
				System.out.println("7777" + remember);
				if (remember.equals("yes")) {
					Cookie ck = new Cookie("Member_Id", loginId);
					response.addCookie(ck);
					Cookie ck1 = new Cookie("password", password);
					response.addCookie(ck1);
				}
				msg = "Welcome ";
				response.sendRedirect("jsp_libOptions.jsp?msg=" + msg);
				// logIn(request,response,loginId);
				con.close();

			} else {
				con.close();
				msg = "Invalid Username or Password";
				response.sendRedirect("jsp_memlogin.jsp?msg=" + msg);
			}
		}

	}

	public void logIn(HttpServletRequest request, HttpServletResponse response,
			String loginId) throws ClassNotFoundException, SQLException,
			NamingException {

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();
		Statement stmt1 = con.createStatement();
		String q = "INSERT INTO LIB_LOGIN(LOGIN_ID,LOGIN_DATE,LOGIN_TIME) VALUES ('"
				+ loginId + "',SYSDATE,TO_CHAR(SYSDATE,'HH:MI:SS'))";
		System.out.println(q);
		int n = stmt1.executeUpdate(q);
		if (n > 0) {
			System.out.println("Login time recorded");
		}
		stmt1.close();
		con.close();

	}

	public void logOut(HttpServletRequest request, HttpServletResponse response)
			throws ClassNotFoundException, SQLException, IOException,
			NamingException {

		HttpSession hs = request.getSession();
		hs.invalidate();

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();
		Statement stmt = con.createStatement();
		String q1 = "UPDATE LIB_LOGIN SET LOGOUT_TIME=(TO_CHAR(SYSDATE,'HH:MI:SS')) WHERE LOGIN_DATE=(SELECT MAX(LOGIN_DATE) FROM LIB_LOGIN)";
		System.out.println(q1);
		int n1 = stmt.executeUpdate(q1);
		if (n1 > 0) {

			System.out.println("Logout time recorded");
		}
		response.sendRedirect("jsp_welcome.jsp");
	}

	public void memLogOut(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException, IOException {

		HttpSession hs = request.getSession();
		hs.invalidate();

		response.sendRedirect("jsp_welcome.jsp");
	}

}
