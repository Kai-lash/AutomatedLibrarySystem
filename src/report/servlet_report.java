package report;

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
import javax.sql.DataSource;

import util.InitializeConnection;

public class servlet_report extends HttpServlet {

	// BOOK ISSUE REPORT
	public Vector bookIssueIdV = new Vector();
	public Vector memIdV4 = new Vector();
	public Vector bookIdV4 = new Vector();
	public Vector bookIssueDateV = new Vector();
	public Vector bookExpRetDateV = new Vector();
	public Vector bookActRetDateV = new Vector();
	public Vector noOfDaysDuesV = new Vector();

	// NORMAL/PREMIUM
	public Vector memId = new Vector();
	public Vector memName = new Vector();
	public Vector cellNo = new Vector();
	public Vector emailId = new Vector();
	public Vector membership = new Vector();

	// MEMBERSHIP COLLECTION
	public Vector memIdV1 = new Vector();
	public Vector memNameV1 = new Vector();
	public Vector memFeesV1 = new Vector();
	public Vector memFeesTypeV1 = new Vector();
	public String memTotalCollection = "";
	String memCollMonth = "";

	public void setMemCollMonth(String memCollMonth) {
		this.memCollMonth = memCollMonth;
	}

	public void setMemCollYear(String memCollYear) {
		this.memCollYear = memCollYear;
	}

	String memCollYear = "";
	int totalMemColl = 0;

	// FINE COLLECTION

	public Vector memIdV6 = new Vector();
	public Vector memNameV6 = new Vector();
	public Vector memFeesV6 = new Vector();
	public Vector memFeesTypeV6 = new Vector();
	public String memTotalCollection6 = "";
	String memCollMonth6 = "";

	public void setMemCollMonth6(String memCollMonth6) {
		this.memCollMonth6 = memCollMonth6;
	}

	public void setMemCollYear6(String memCollYear6) {
		this.memCollYear6 = memCollYear6;
	}

	String memCollYear6 = "";
	int totalMemColl6 = 0;

	// BOOKINFO
	public Vector bookIdV = new Vector();
	public Vector bookNameV = new Vector();
	public Vector authorNameV = new Vector();
	public Vector bookQtyV = new Vector();
	public Vector bookPubV = new Vector();
	public Vector bookPubYearV = new Vector();
	public Vector bookPurDateV = new Vector();
	public Vector bookPagesV = new Vector();

	// ACTIVEMEMBERINFO
	public Vector memIdV = new Vector();
	public Vector memPwdV = new Vector();
	public Vector memFnameV = new Vector();
	public Vector memMnameV = new Vector();
	public Vector memLnameV = new Vector();
	public Vector memAddressV = new Vector();
	public Vector memEmailIdV = new Vector();
	public Vector memCellNoV = new Vector();
	public Vector memTypeV = new Vector();
	public Vector memStatusV = new Vector();
	public Vector memRegDateV = new Vector();

	private static final long serialVersionUID = 1L;
	String memType = "";
	String span = "";
	String span6 = "";

	public void setMemType(String memType) {
		this.memType = memType;
	}

	public void setSpan(String span) {
		this.span = span;
	}

	public void setSpan6(String span6) {
		this.span6 = span6;
	}

	public servlet_report() {
		super();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
	}

	String issueReportType = "";
	String month = "";
	String year = "";

	public void setissueReportType(String issueReportType) {
		this.issueReportType = issueReportType;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getMonth() {
		System.out.println(month);
		return month;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getYear() {
		System.out.println(year);
		return year;
	}

	public void getNormalPremium() throws SQLException, ClassNotFoundException,
			NamingException {

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();

		Statement stmt = con.createStatement();
		ResultSet rs;
		if (memType.equals("normal")) {
			rs = stmt
					.executeQuery("SELECT MEM_FNAME,MEM_ID,MEM_EMAILID,MEM_CELLNO,MEM_TYPE FROM ALS_MEMBERS WHERE UPPER(MEM_TYPE)='NORMAL'");
		} else if (memType.equals("premium")) {
			rs = stmt
					.executeQuery("SELECT MEM_FNAME,MEM_ID,MEM_EMAILID,MEM_CELLNO,MEM_TYPE FROM ALS_MEMBERS WHERE UPPER(MEM_TYPE)='PREMIUM'");
		} else {
			rs = stmt
					.executeQuery("SELECT MEM_FNAME,MEM_ID,MEM_EMAILID,MEM_CELLNO,MEM_TYPE FROM ALS_MEMBERS");
		}
		while (rs.next()) {
			memName.add(rs.getString(1));
			memId.add(rs.getString(2));
			emailId.add(rs.getString(3));
			cellNo.add(rs.getString(4));
			membership.add(rs.getString(5));
		}
		con.close();
	}

	public void reportBookInfo() throws ClassNotFoundException, SQLException,
			NamingException {

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();

		Statement stmt = con.createStatement();
		ResultSet rs = stmt
				.executeQuery("SELECT  BOOK_ID,BOOK_NAME,BOOK_AUTHOR, BOOK_QTY, BOOK_PUBLISHER , BOOK_PUBYEAR, TO_CHAR(BOOK_PUR_DATE,'DD-MM-YYYY'),BOOK_PAGES FROM BOOKS");
		while (rs.next()) {
			bookIdV.add(rs.getString(1));
			bookNameV.add(rs.getString(2));
			authorNameV.add(rs.getString(3));
			bookQtyV.add(rs.getString(4));
			bookPubV.add(rs.getString(5));
			bookPubYearV.add(rs.getString(6));
			bookPurDateV.add(rs.getString(7));
			bookPagesV.add(rs.getString(8).equals("0") ? "-" : rs.getString(8));

		}

		con.close();
	}

	// code for active member report
	public void reportActiveMem() throws ClassNotFoundException, SQLException,
			NamingException {

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();

		Statement stmt = con.createStatement();
		ResultSet rs = stmt
				.executeQuery("SELECT MEM_ID,MEM_PWD,MEM_FNAME,MEM_MNAME,MEM_LNAME,MEM_ADDRESS,MEM_EMAILID,MEM_CELLNO,MEM_TYPE,MEM_STATUS,TO_CHAR(MEM_REGDATE,'DD-MON-YY') FROM ALS_MEMBERS WHERE UPPER (MEM_STATUS)='ACTIVE' ORDER BY MEM_ID");
		while (rs.next()) {
			memIdV.add(rs.getString(1));
			memPwdV.add(rs.getString(2));
			memFnameV.add(rs.getString(3));
			memMnameV.add(rs.getString(4));
			memLnameV.add(rs.getString(5));
			memAddressV.add(rs.getString(6));
			memEmailIdV.add(rs.getString(7));
			memCellNoV.add(rs.getString(8));
			memTypeV.add(rs.getString(9));
			memStatusV.add(rs.getString(10));
			memRegDateV.add(rs.getString(11));
		}

		con.close();
	}

	// code for inactive member report
	public void reportInactiveMem() throws ClassNotFoundException,
			SQLException, NamingException {

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();

		Statement stmt = con.createStatement();
		ResultSet rs = stmt
				.executeQuery("SELECT MEM_ID,MEM_PWD,MEM_FNAME,MEM_MNAME,MEM_LNAME,MEM_ADDRESS,MEM_EMAILID,MEM_CELLNO,MEM_TYPE,MEM_STATUS,TO_CHAR(MEM_REGDATE,'DD-MON-YY') FROM ALS_MEMBERS WHERE UPPER (MEM_STATUS)='INACTIVE' ORDER BY MEM_ID");
		while (rs.next()) {
			memIdV.add(rs.getString(1));
			memPwdV.add(rs.getString(2));
			memFnameV.add(rs.getString(3));
			memMnameV.add(rs.getString(4));
			memLnameV.add(rs.getString(5));
			memAddressV.add(rs.getString(6));
			memEmailIdV.add(rs.getString(7));
			memCellNoV.add(rs.getString(8));
			memTypeV.add(rs.getString(9));
			memStatusV.add(rs.getString(10));
			memRegDateV.add(rs.getString(11));
		}

		con.close();
	}

	public void getIssueReport() throws ClassNotFoundException, SQLException,
			NamingException {

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();

		if (issueReportType.equals("monthwise")) {

			String query = "SELECT BOOK_ISSUEID,MEM_ID,BOOK_ID,TO_CHAR(BOOK_ISSUE_DATE,'DD-MON-YYYY'),TO_CHAR(BOOK_EXP_RET_DATE,'DD-MON-YYYY'),NVL(TO_CHAR(BOOK_ACT_RET_DATE,'DD-MON--YYYY'),'NOT RETURNED'),NVL(NO_DAYS_OVERDUE,0) FROM ISSUE_BOOKS WHERE TO_CHAR(BOOK_ISSUE_DATE,'YYYY')='"
					+ year
					+ "'AND TO_CHAR(BOOK_ISSUE_DATE,'MON')='"
					+ month
					+ "'";
			System.out.println(query);
			PreparedStatement stmt = con.prepareStatement(query);
			ResultSet rs;
			rs = stmt.executeQuery();
			while (rs.next()) {
				bookIssueIdV.add(rs.getString(1));
				memIdV4.add(rs.getString(2));
				bookIdV4.add(rs.getString(3));
				bookIssueDateV.add(rs.getString(4));
				bookExpRetDateV.add(rs.getString(5));
				bookActRetDateV.add(rs.getString(6));
				noOfDaysDuesV.add(rs.getString(7));

			}
			stmt.close();
			con.close();
		} else if (issueReportType.equals("yearwise")) {
			String query = "SELECT BOOK_ISSUEID,MEM_ID,BOOK_ID,TO_CHAR(BOOK_ISSUE_DATE,'DD-MON-YYYY'),TO_CHAR(BOOK_EXP_RET_DATE,'DD-MON-YYYY'),NVL(TO_CHAR(BOOK_ACT_RET_DATE,'DD-MON--YYYY'),'NOT RETURNED'),NVL(NO_DAYS_OVERDUE,0) FROM ISSUE_BOOKS WHERE TO_CHAR(BOOK_ISSUE_DATE,'YYYY')='"
					+ year + "'";
			System.out.println(query);
			PreparedStatement stmt = con.prepareStatement(query);
			ResultSet rs;
			rs = stmt.executeQuery();
			while (rs.next()) {
				bookIssueIdV.add(rs.getString(1));
				memIdV4.add(rs.getString(2));
				bookIdV4.add(rs.getString(3));
				bookIssueDateV.add(rs.getString(4));
				bookExpRetDateV.add(rs.getString(5));
				bookActRetDateV.add(rs.getString(6));
				noOfDaysDuesV.add(rs.getString(7));

			}
			stmt.close();
			con.close();
		} else if (issueReportType.equals("bookidwise")) {
			String query = "SELECT BOOK_ISSUEID,MEM_ID,BOOK_ID,TO_CHAR(BOOK_ISSUE_DATE,'DD-MON-YYYY'),TO_CHAR(BOOK_EXP_RET_DATE,'DD-MON-YYYY'),NVL(TO_CHAR(BOOK_ACT_RET_DATE,'DD-MON--YYYY'),'NOT RETURNED'),NVL(NO_DAYS_OVERDUE,0) FROM ISSUE_BOOKS ORDER BY BOOK_ID";
			System.out.println(query);
			PreparedStatement stmt = con.prepareStatement(query);
			ResultSet rs;
			rs = stmt.executeQuery();
			while (rs.next()) {
				bookIssueIdV.add(rs.getString(1));
				memIdV4.add(rs.getString(2));
				bookIdV4.add(rs.getString(3));
				bookIssueDateV.add(rs.getString(4));
				bookExpRetDateV.add(rs.getString(5));
				bookActRetDateV.add(rs.getString(6));
				noOfDaysDuesV.add(rs.getString(7));

			}
			stmt.close();
			con.close();
		}

		else if (issueReportType.equals("all")) {
			String query = "SELECT BOOK_ISSUEID,MEM_ID,BOOK_ID,TO_CHAR(BOOK_ISSUE_DATE,'DD-MON-YYYY'),TO_CHAR(BOOK_EXP_RET_DATE,'DD-MON-YYYY'),NVL(TO_CHAR(BOOK_ACT_RET_DATE,'DD-MON--YYYY'),'NOT RETURNED'),NVL(NO_DAYS_OVERDUE,0) FROM ISSUE_BOOKS ORDER BY BOOK_ISSUEID";
			System.out.println(query);
			PreparedStatement stmt = con.prepareStatement(query);
			ResultSet rs;
			rs = stmt.executeQuery();
			while (rs.next()) {
				bookIssueIdV.add(rs.getString(1));
				memIdV4.add(rs.getString(2));
				bookIdV4.add(rs.getString(3));
				bookIssueDateV.add(rs.getString(4));
				bookExpRetDateV.add(rs.getString(5));
				bookActRetDateV.add(rs.getString(6));
				noOfDaysDuesV.add(rs.getString(7));

			}
			stmt.close();
			con.close();
		}

		else {
			System.out.println("Enter valid option");
		}
	}

	public void reportMemCollection() throws ClassNotFoundException,
			SQLException, NamingException {
		String query = "";

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();

		Statement stmt = con.createStatement();
		Statement stmt1 = con.createStatement();
		ResultSet rs;
		ResultSet rs1;
		if (span.equals("yearwise")) {
			query = "SELECT M.MEM_FNAME,M.MEM_ID,P.FEES_TYPE,NVL(P.AMOUNT,0) FROM ALS_MEMBERS M,PAYMENT P WHERE "
					+ "UPPER (P.FEES_TYPE)='MEMBERSHIP' AND TO_CHAR(PAYMENT_DATE,'YYYY')='"
					+ memCollYear + "' AND M.MEM_ID=P.MEM_ID";
			System.out.println(query);
			rs = stmt.executeQuery(query);

			rs1 = stmt1
					.executeQuery("SELECT NVL(SUM(P.AMOUNT),0) FROM ALS_MEMBERS M,PAYMENT P WHERE "
							+ "UPPER (P.FEES_TYPE)='MEMBERSHIP' AND TO_CHAR(PAYMENT_DATE,'YYYY')='"
							+ memCollYear + "' AND M.MEM_ID=P.MEM_ID");

		} else if (span.equals("monthwise")) {
			query = "SELECT M.MEM_FNAME,M.MEM_ID,P.FEES_TYPE,NVL(P.AMOUNT,0) FROM ALS_MEMBERS M,PAYMENT P WHERE "
					+ "UPPER (P.FEES_TYPE)='MEMBERSHIP' AND TO_CHAR(PAYMENT_DATE,'MON')='"
					+ memCollMonth
					+ "' "
					+ " AND TO_CHAR(PAYMENT_DATE,'YYYY')='"
					+ memCollYear
					+ "' AND M.MEM_ID=P.MEM_ID";
			System.out.println(query);
			rs = stmt.executeQuery(query);
			rs1 = stmt1
					.executeQuery("SELECT NVL(SUM(P.AMOUNT),0) FROM ALS_MEMBERS M,PAYMENT P WHERE "
							+ "UPPER (P.FEES_TYPE)='MEMBERSHIP' AND TO_CHAR(PAYMENT_DATE,'MON')='"
							+ memCollMonth
							+ "' "
							+ " AND TO_CHAR(PAYMENT_DATE,'YYYY')='"
							+ memCollYear + "' AND M.MEM_ID=P.MEM_ID");

		} else {
			query = "SELECT M.MEM_FNAME,M.MEM_ID,P.FEES_TYPE,NVL(P.AMOUNT,0) FROM ALS_MEMBERS M,PAYMENT P WHERE "
					+ "UPPER (P.FEES_TYPE)='MEMBERSHIP'"
					+ " AND M.MEM_ID=P.MEM_ID";
			System.out.println(query);
			rs = stmt.executeQuery(query);
			rs1 = stmt1
					.executeQuery("SELECT NVL(SUM(P.AMOUNT),0) FROM ALS_MEMBERS M,PAYMENT P WHERE "
							+ "UPPER (P.FEES_TYPE)='MEMBERSHIP'"
							+ " AND M.MEM_ID=P.MEM_ID");
		}
		while (rs.next()) {

			memNameV1.add(rs.getString(1));
			memIdV1.add(rs.getString(2));
			memFeesTypeV1.add(rs.getString(3));
			memFeesV1.add(rs.getString(4));

		}
		while (rs1.next()) {
			memTotalCollection = rs1.getString(1);

		}

		con.commit();
		con.close();
	}

	public void reportFineCollection() throws ClassNotFoundException,
			SQLException, NamingException {
		String query = "";

		InitializeConnection inc = new InitializeConnection();
		Connection con = inc.initConnect();

		Statement stmt = con.createStatement();
		Statement stmt1 = con.createStatement();
		ResultSet rs;
		ResultSet rs1;
		if (span6.equals("yearwise")) {
			query = "SELECT M.MEM_FNAME,M.MEM_ID,P.FEES_TYPE,NVL(P.AMOUNT,0) FROM ALS_MEMBERS M,PAYMENT P WHERE "
					+ "UPPER (P.FEES_TYPE)='FINE' AND TO_CHAR(PAYMENT_DATE,'YYYY')='"
					+ memCollYear6 + "' AND M.MEM_ID=P.MEM_ID";
			System.out.println(query);
			rs = stmt.executeQuery(query);

			rs1 = stmt1
					.executeQuery("SELECT SUM(P.AMOUNT) FROM ALS_MEMBERS M,PAYMENT P WHERE "
							+ "UPPER (P.FEES_TYPE)='FINE' AND TO_CHAR(PAYMENT_DATE,'YYYY')='"
							+ memCollYear6 + "' AND M.MEM_ID=P.MEM_ID");

		} else if (span6.equals("monthwise")) {
			query = "SELECT M.MEM_FNAME,M.MEM_ID,P.FEES_TYPE,NVL(P.AMOUNT,0) FROM ALS_MEMBERS M,PAYMENT P WHERE "
					+ "UPPER (P.FEES_TYPE)='FINE' AND TO_CHAR(PAYMENT_DATE,'MON')='"
					+ memCollMonth6
					+ "' "
					+ " AND TO_CHAR(PAYMENT_DATE,'YYYY')='"
					+ memCollYear6
					+ "' AND M.MEM_ID=P.MEM_ID";
			System.out.println(query);
			rs = stmt.executeQuery(query);
			rs1 = stmt1
					.executeQuery("SELECT SUM(P.AMOUNT) FROM ALS_MEMBERS M,PAYMENT P WHERE "
							+ "UPPER (P.FEES_TYPE)='FINE' AND TO_CHAR(PAYMENT_DATE,'MON')='"
							+ memCollMonth6
							+ "' "
							+ " AND TO_CHAR(PAYMENT_DATE,'YYYY')='"
							+ memCollYear6 + "' AND M.MEM_ID=P.MEM_ID");

		} else {
			query = "SELECT M.MEM_FNAME,M.MEM_ID,P.FEES_TYPE,NVL(P.AMOUNT,0) FROM ALS_MEMBERS M,PAYMENT P WHERE "
					+ "UPPER (P.FEES_TYPE)='FINE'" + " AND M.MEM_ID=P.MEM_ID";
			System.out.println(query);
			rs = stmt.executeQuery(query);
			rs1 = stmt1
					.executeQuery("SELECT NVL(SUM(P.AMOUNT),0) FROM ALS_MEMBERS M,PAYMENT P WHERE "
							+ "UPPER (P.FEES_TYPE)='FINE'"
							+ " AND M.MEM_ID=P.MEM_ID");
		}
		while (rs.next()) {

			memNameV6.add(rs.getString(1));
			memIdV6.add(rs.getString(2));
			memFeesTypeV6.add(rs.getString(3));
			memFeesV6.add(rs.getString(4));

		}
		while (rs1.next()) {
			memTotalCollection6 = rs1.getString(1);

		}
		con.commit();
		con.close();
	}

}
