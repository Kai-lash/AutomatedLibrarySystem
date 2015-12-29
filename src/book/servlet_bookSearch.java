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

public class servlet_bookSearch extends HttpServlet {
	String memId;
	String bookIDhidden;
	String booknamehidden;
	public String msg = "";
	public String issue = "";

	public servlet_bookSearch() {

	}

	private static final long serialVersionUID = 1L;
	public Vector book_NameV = new Vector();
	public Vector book_AuthorV = new Vector();
	public Vector book_PublisherV = new Vector();
	public Vector book_IDV = new Vector();

	// VECTORS FOR BOOK SEARCH BY NAME
	public Vector book_NameV2 = new Vector();
	public Vector book_AuthorV2 = new Vector();
	public Vector book_PublisherV2 = new Vector();
	public Vector book_IDV2 = new Vector();

	// VECTORS FOR BOOK SEARCH BY Author
	public Vector book_NameV3 = new Vector();
	public Vector book_AuthorV3 = new Vector();
	public Vector book_PublisherV3 = new Vector();
	public Vector book_IDV3 = new Vector();

	String book_cat = "";
	String varbook_name = "";
	String varbook_author = "";

	public void setBook_cat(String book_cat) {
		this.book_cat = book_cat;
	}

	public void setBook_name(String varbook_name) {
		this.varbook_name = varbook_name;
	}

	public void setBook_author(String varbook_author) {
		this.varbook_author = varbook_author;
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String pageOption = request.getParameter("pageOption") == null ? ""
				: request.getParameter("pageOption");
		bookIDhidden = request.getParameter("bookIDhidden") == null ? ""
				: request.getParameter("bookIDhidden");
		booknamehidden = request.getParameter("booknamehidden") == null ? ""
				: request.getParameter("booknamehidden");

		try {
			if (pageOption.equals("searchBook")) {
				bookSearch(request, response);
			}
		} catch (Exception e) {
			System.out.println("-" + e.getMessage());
			response.sendRedirect("jsp_errorPageN.jsp?errorMsg="
					+ e.getMessage());
		}
	}

	public void bookSearch(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		HttpSession hs = request.getSession();
		memId = (String) hs.getAttribute("Member_Id");
		System.out.println(memId);
		String msg = "";
		String bookName = request.getParameter("booknamehidden") == null ? ""
				: request.getParameter("booknamehidden");
		String authorName = request.getParameter("authornamehidden") == null ? ""
				: request.getParameter("authornamehidden");
		String category = request.getParameter("category") == null ? ""
				: request.getParameter("category");
		System.out.println("bookName" + bookName);
		System.out.println("authorName" + authorName);

		CharValidation cv = new CharValidation();

		if (bookName.equals("") && authorName.equals("")) {
			msg = "Both Book Name and Author Name cannot be blank !";
			response.sendRedirect("jsp_searchbook.jsp?msg=" + msg);
		} /*else if (cv.validate(bookName)) {
			msg = "Invalid Character in Book Name !";
			response.sendRedirect("jsp_searchbook.jsp?msg=" + msg);
		}*/ else if (cv.validate(authorName)) {
			msg = "Invalid Character in Author Name !";
			response.sendRedirect("jsp_searchbook.jsp?msg=" + msg);
		} else {
			// business logic will be applied here
			try {

				InitializeConnection inc = new InitializeConnection();
				Connection con = inc.initConnect();
				
				System.out.println("connection done");

				Statement st = con.createStatement();
				//for (int j = 0; j < copiesInt; j++) {

					ResultSet rs = st
							.executeQuery("select book_issueid.nextval from dual");
					String lmstr = "";
					int i = 0;
					String s1 = "";
					while (rs.next()) {
						i = rs.getInt(1);
					}
					System.out.println("i----" + i);
					if (i < 10) {
						lmstr = "BIID000";
					} else if ((i > 9) && (i < 100)) {
						lmstr = "BIID00";
					} else if ((i > 99) && (i < 1000)) {
						lmstr = "BIID0";
					}
				
					PreparedStatement st1 = con
							.prepareStatement("select concat(?," + i
									+ ") from dual");
					st1.setString(1, lmstr);
					ResultSet rs1 = st1.executeQuery();

					if (rs1.next()) {
						s1 = rs1.getString(1);
						System.out.println(s1);
					}

					
				PreparedStatement pstmt = con
						.prepareStatement("INSERT INTO ISSUE_BOOKS VALUES('"+s1+"',UPPER(?),?,sysdate,sysdate+5,null,?,'NA')");
				pstmt.setString(1, memId);
				pstmt.setString(2, bookIDhidden);
				pstmt.setString(3, null);

				int rs2 = pstmt.executeUpdate();

				System.out.println("Table updated");

				String q2 = "UPDATE BOOKS SET BOOK_QTY=(BOOK_QTY-1) WHERE BOOK_ID='"
						+ bookIDhidden + "'";
				// System.out.println(q2);
				Statement st2 = con.createStatement();
				int n2 = st2.executeUpdate(q2);
				if (n2 > 0) {
					System.out.println("book table updated");
				}
				pstmt.close();

				con.close();
				msg = "Book Issued Succcessfully !";
				response.sendRedirect("jsp_searchbook.jsp?msg=" + msg);
			} catch (Exception e) {
				e.printStackTrace();
			}

			msg = "Valid Fields";
		}

		msg = "Valid Fields";
	}

	public void bookSearchInit() throws IOException {

		// business logic will be applied here
		try {

			InitializeConnection inc = new InitializeConnection();
			Connection con = inc.initConnect();

			
			Statement st = con.createStatement();
			String queryString = "SELECT BOOK_NAME , BOOK_AUTHOR , BOOK_PUBLISHER , BOOK_ID FROM BOOKS WHERE BOOK_CAT='"
					+ book_cat + "'";
			System.out.println(queryString);
			ResultSet rs = st.executeQuery(queryString);
			System.out.println("-----" + book_cat);
			while (rs.next()) {
				book_NameV.add(rs.getString(1));
				book_AuthorV.add(rs.getString(2));
				book_PublisherV.add(rs.getString(3));
				book_IDV.add(rs.getString(4));

			}
			for (int i = 0; i < book_NameV.size(); i++) {
				System.out.println(book_NameV.elementAt(i));
			}
			st.close();

			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public boolean checkIssuedBooks(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException

	{
		boolean flag = false;
		HttpSession hs = request.getSession();
		memId = (String) hs.getAttribute("Member_Id");
		System.out.println("memid===" + memId);
		
		
		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();
		
		Statement st = con.createStatement();
		String q1 = "SELECT BOOK_ID FROM ISSUE_BOOKS WHERE MEM_ID=UPPER('" + memId
				+ "') AND  BOOK_ACT_RET_DATE IS NULL";
		System.out.println(q1);
		ResultSet rs = st.executeQuery(q1);
		int i = 0;
		while (rs.next()) {
			String id = rs.getString(1);

			i++;
		}
		System.out.println("======" + i);
		if (i < 2) {
			issue = "yes";
		} else {
			msg = "Your limit for the maximum books allowed to be issued has been reached!";
			System.out.println(msg);
		}

		st.close();
		con.close();
		return flag;

	}

	public void bookSearchName() throws IOException {

		// business logic will be applied here
		try {
			
			InitializeConnection inc = new InitializeConnection();
			Connection con = inc.initConnect();

			Statement st = con.createStatement();
			String queryString = "SELECT BOOK_NAME , BOOK_AUTHOR , BOOK_PUBLISHER , BOOK_ID FROM BOOKS WHERE BOOK_NAME LIKE UPPER('"
					+ varbook_name + "%')";
			System.out.println(queryString);
			if (!(varbook_name.equals(""))) {
				ResultSet rs = st.executeQuery(queryString);

				System.out.println("-----" + book_cat);
				while (rs.next()) {
					book_NameV2.add(rs.getString(1));
					book_AuthorV2.add(rs.getString(2));
					book_PublisherV2.add(rs.getString(3));
					book_IDV2.add(rs.getString(4));

				}
				for (int i = 0; i < book_NameV.size(); i++) {
					System.out.println(book_NameV.elementAt(i));
				}
			}
			st.close();

			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void bookSearchAuthor() throws IOException {

		// business logic will be applied here
		try {
			
			
			InitializeConnection inc = new InitializeConnection();
			Connection con = inc.initConnect();

			Statement st = con.createStatement();
			String queryString = "SELECT BOOK_NAME , BOOK_AUTHOR , BOOK_PUBLISHER , BOOK_ID FROM BOOKS WHERE BOOK_AUTHOR LIKE UPPER('"
					+ varbook_author + "%')";
			System.out.println(queryString);
			if (!(varbook_author.equals(""))) {
				ResultSet rs = st.executeQuery(queryString);
				System.out.println("-----" + book_cat);
				while (rs.next()) {
					book_NameV3.add(rs.getString(1));
					book_AuthorV3.add(rs.getString(2));
					book_PublisherV3.add(rs.getString(3));
					book_IDV3.add(rs.getString(4));

				}
			}
			st.close();

			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
