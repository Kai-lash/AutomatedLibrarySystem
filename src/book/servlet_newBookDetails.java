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

import util.CharValidation;
import util.InitializeConnection;

public class servlet_newBookDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public String deleteBookId = "";
	public String deleteBookCopyId = "";
	public Vector deleteBookIdV = new Vector();
	public Vector deleteBookCopyIdV = new Vector();
	Connection con;

	public servlet_newBookDetails() {
		super();

	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String pageOption = request.getParameter("pageOption") == null ? ""
				: request.getParameter("pageOption");
		String bookOptionHid = request.getParameter("bookOptionHid") == null ? ""
				: request.getParameter("bookOptionHid");
		System.out.println("bookOptionHid---" + bookOptionHid);
		try {
			if (pageOption.equals("newBookDetails")) {
				if (bookOptionHid.equals("delete")) {

					deleteBooks(request, response);

				} else {
					newBookDetails(request, response);
				}
			}
		} catch (Exception e) {
			System.out.println("-" + e.getMessage());
			response.sendRedirect("jsp_errorPageN.jsp?errorMsg="
					+ e.getMessage());

		}
	}

	void newBookDetails(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		String msg = "";
		int copiesInt = 0;
		String bookName = request.getParameter("bookName") == null ? ""
				: request.getParameter("bookName");
		String version = request.getParameter("version") == null ? "" : request
				.getParameter("version");
		String category = request.getParameter("category") == null ? ""
				: request.getParameter("category");
		String authorName = request.getParameter("authorName") == null ? ""
				: request.getParameter("authorName");
		String publisherName = request.getParameter("publisherName") == null ? ""
				: request.getParameter("publisherName");
		String publishYear = request.getParameter("publishYear") == null ? ""
				: request.getParameter("publishYear");
		String pages = request.getParameter("pages") == "" ? "0" : request
				.getParameter("pages");
		String copies = request.getParameter("copies") == null ? "" : request
				.getParameter("copies");

		CharValidation cv = new CharValidation();

		if (bookName.equals("")) {
			msg = "First Name cannot be blank !";
			response.sendRedirect("jsp_newBookDetails.jsp?msg=" + msg);
		} else if (cv.validate(bookName)) {
			msg = "Invalid Character in Book Name !";
			response.sendRedirect("jsp_newBookDetails.jsp?msg=" + msg);
		} else if (authorName.equals("")) {
			msg = "Author Name cannot be blank !";
			response.sendRedirect("jsp_newBookDetails.jsp?msg=" + msg);
		} else if (cv.validate(authorName)) {
			msg = "Invalid character in Author Name !";
			response.sendRedirect("jsp_newBookDetails.jsp?msg=" + msg);
		} else if (publisherName.equals("")) {
			msg = "Publisher Name cannot be blank !";
			response.sendRedirect("jsp_newBookDetails.jsp?msg=" + msg);
		} else if (publishYear.equals("")) {
			msg = "Please select a publishing year !";
			response.sendRedirect("jsp_newBookDetails.jsp?msg=" + msg);
		} else if (copies.equals("")) {
			msg = "Number of Copies cannot be blank !";
			response.sendRedirect("jsp_newBookDetails.jsp?msg=" + msg);
		} else {
			try {
				int pagesInt = Integer.parseInt(pages);
			} catch (NumberFormatException Ne) {
				msg = "Page number should be numeric !";
				response.sendRedirect("jsp_newBookDetails.jsp?msg=" + msg);
			}
			try {
				copiesInt = Integer.parseInt(copies);
			} catch (NumberFormatException Ne) {
				msg = "Number of Copies should be numeric !";
				response.sendRedirect("jsp_newBookDetails.jsp?msg=" + msg);
			}

			// business logic should be applied here
			try {
				InitializeConnection inc = new InitializeConnection();
				Connection con = inc.initConnect();

				Statement st = con.createStatement();
				// for (int j = 0; j < copiesInt; j++) {

				ResultSet rs = st
						.executeQuery("select book_id.nextval from dual");
				String lmstr = "";
				int i = 0;
				String s1 = "";
				while (rs.next()) {
					i = rs.getInt(1);
				}
				System.out.println("i----" + i);
				if (i < 10) {
					lmstr = "BID000";
				} else if ((i > 9) && (i < 100)) {
					lmstr = "BID00";
				} else if ((i > 99) && (i < 1000)) {
					lmstr = "BID0";
				}

				PreparedStatement st1 = con.prepareStatement("select concat(?,"
						+ i + ") from dual");
				st1.setString(1, lmstr);
				ResultSet rs1 = st1.executeQuery();

				if (rs1.next()) {
					s1 = rs1.getString(1);
					System.out.println(s1);
				}

				PreparedStatement pstmt = con
						.prepareStatement("Insert into books values(?,UPPER(?),UPPER(?),?,UPPER(?),?,sysdate,?,?,UPPER(?))");
				pstmt.setString(1, s1);
				pstmt.setString(2, bookName);
				pstmt.setString(3, authorName);
				pstmt.setString(4, copies);
				pstmt.setString(5, publisherName);
				pstmt.setString(6, publishYear);
				pstmt.setString(7, pages);
				pstmt.setString(8, version);
				pstmt.setString(9, category);

				int n = pstmt.executeUpdate();
				if (n > 0) {
					System.out.println("record inserted");
				}
				// }

				for (int j = 0; j < copiesInt; j++) {

					rs = st.executeQuery("select book_copyid.nextval from dual");
					lmstr = "";
					i = 0;
					String s2 = "";
					while (rs.next()) {
						i = rs.getInt(1);
					}
					System.out.println("i----" + i);
					if (i < 10) {
						lmstr = "BCID000";
					} else if ((i > 9) && (i < 100)) {
						lmstr = "BCID00";
					} else if ((i > 99) && (i < 1000)) {
						lmstr = "BCID0";
					}

					st1 = con.prepareStatement("select concat(?," + i
							+ ") from dual");
					st1.setString(1, lmstr);
					rs1 = st1.executeQuery();

					if (rs1.next()) {
						s2 = rs1.getString(1);
						System.out.println(s2);
					}

					pstmt = con
							.prepareStatement("Insert into book_copies values(?,?)");
					pstmt.setString(1, s1);
					pstmt.setString(2, s2);

					n = pstmt.executeUpdate();
					if (n > 0) {
						System.out.println("record inserted");
					}
				}

				con.close();
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			msg = "New Book Added !";
			response.sendRedirect("jsp_newBookDetails.jsp?msg=" + msg);
		}
	}

	void deleteBooks(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ClassNotFoundException {

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();

		String deleteBookId = request.getParameter("deleteBookId") == null ? ""
				: request.getParameter("deleteBookId");
		String deleteBookCopyId = request.getParameter("deleteBookCopyId") == null ? ""
				: request.getParameter("deleteBookCopyIdV");

		Statement st = con.createStatement();
		String query1 = "DELETE FROM BOOK_COPIES WHERE BOOK_ID='"
				+ deleteBookId + "' AND BOOK_COPY_ID='" + deleteBookCopyId
				+ "'";
		System.out.println(query1);
		int rs1 = st.executeUpdate(query1);

		String query2 = "UPDATE BOOKS SET BOOK_QTY=BOOK_QTY-1 WHERE BOOK_ID='"
				+ deleteBookId + "'";
		System.out.println(query2);
		int rs2 = st.executeUpdate(query2);
		String msg = "Book Successfully Deleted";
		response.sendRedirect("jsp_newBookDetails.jsp?msg=" + msg
				+ "&bookOption=" + "delete");

	}

	public void deleteBookDetails() throws SQLException, ClassNotFoundException {

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();

		Statement st = con.createStatement();

		String query = "SELECT DISTINCT BOOK_ID FROM BOOKS";
		System.out.println(query);
		ResultSet rs = st.executeQuery(query);
		while (rs.next()) {
			deleteBookIdV.add(rs.getString(1));
		}

		String query1 = "SELECT BOOK_COPY_ID FROM BOOK_COPIES WHERE BOOK_ID='"
				+ deleteBookId + "'";
		System.out.println(query1);
		ResultSet rs1 = st.executeQuery(query1);
		while (rs1.next()) {
			deleteBookCopyIdV.add(rs1.getString(1));
		}
		con.close();
	}

}
