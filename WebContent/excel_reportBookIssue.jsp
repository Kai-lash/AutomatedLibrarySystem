
<%@page import="report.servlet_report"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<%
	String issueReportType = request.getParameter("issueReportType") == null ? "all"
			: request.getParameter("issueReportType");
	String month = request.getParameter("month") == null ? "JAN"
			: request.getParameter("month");
	String year = request.getParameter("year") == null ? "2012"
			: request.getParameter("year");
	servlet_report rpt = new servlet_report();
	rpt.setissueReportType(issueReportType);
	rpt.setMonth(month);
	rpt.setYear(year);
	rpt.getIssueReport();

	Vector bookIssueId = rpt.bookIssueIdV;
	Vector memId = rpt.memIdV4;
	Vector bookId = rpt.bookIdV4;
	Vector bookIssueDate = rpt.bookIssueDateV;
	Vector bookExpRetDate = rpt.bookExpRetDateV;
	Vector bookActRetDate = rpt.bookActRetDateV;
	Vector noOfDaysDues = rpt.noOfDaysDuesV;

	String msg = request.getParameter("msg") == null ? "" : request
			.getParameter("msg");
%>
<%
	response.setContentType("application/vnd.ms-excel");
%>
<body>
	<table align="center" border="1">
	<tr>
			<td colspan="7" rowspan="1" align="center"><b><font
					color="RED" face="harrington" size="7">BOOK SHELF LIBRARY</font></b></td>
		</tr>
		<tr>
			<td colspan="7"></td>
		</tr>
		<tr>
			<td colspan="7" rowspan="1" align="center"><b>Book Issue Report</b></td>
		</tr>
		<tr>
			<td colspan="7"></td>
		</tr>
		<tr>
			<td align="center" colspan="7"><%if(issueReportType.equals("all")){%>Full Report<%} %></td>
		</tr>
		<%
			if (issueReportType.equals("monthwise")) {
		%>
		<tr>
			<td><%=month%></td>
			<td><%=year%></td>
			<td></td>
		</tr>
		<tr>
			<td><b>Book Issue Id</b></td>
			<td><b>Member ID</b></td>
			<td><b>Book Id</b></td>
			<td><b>Book Issue Date</b></td>
			<td><b>Expected Return Date</b></td>
			<td><b>Actual Return Date</b></td>
			<td><b>No. of Days Overdue</b></td>
		</tr>
		<%
			for (int i = 0; i < bookIssueId.size(); i++) {
		%>
		<tr>
			<td><%=bookIssueId.elementAt(i)%></td>
			<td><%=memId.elementAt(i)%></td>
			<td><%=bookId.elementAt(i)%></td>
			<td><%=bookIssueDate.elementAt(i)%></td>
			<td><%=bookExpRetDate.elementAt(i)%></td>
			<td><%=bookActRetDate.elementAt(i)%></td>
			<td><%=noOfDaysDues.elementAt(i)%></td>
		</tr>
		<%
			}
		%>

		<%
			}
		%>

		<%
			if (issueReportType.equals("yearwise")) {
		%>
		<tr>

			<td><%=year%></td>
			<td><input type="button" value="submit" onclick="refresh2()">
			</td>
		</tr>
		<tr>
			<td><b>Book Issue Id</b></td>
			<td><b>Member ID</b></td>
			<td><b>Book Id</b></td>
			<td><b>Book Issue Date</b></td>
			<td><b>Expected Return Date</b></td>
			<td><b>Actual Return Date</b></td>
			<td><b>No. of Days Overdue</b></td>
		</tr>
		<%
			for (int i = 0; i < bookIssueId.size(); i++) {
		%>
		<tr>
			<td><%=bookIssueId.elementAt(i)%></td>
			<td><%=memId.elementAt(i)%></td>
			<td><%=bookId.elementAt(i)%></td>
			<td><%=bookIssueDate.elementAt(i)%></td>
			<td><%=bookExpRetDate.elementAt(i)%></td>
			<td><%=bookActRetDate.elementAt(i)%></td>
			<td><%=noOfDaysDues.elementAt(i)%></td>
		</tr>
		<%
			}
		%>

		<%
			}
		%>

		<%
			if (issueReportType.equals("bookidwise")) {
		%>

		<tr>
			<td><b>Book Issue Id</b></td>
			<td><b>Member ID</b></td>
			<td><b>Book Id</b></td>
			<td><b>Book Issue Date</b></td>
			<td><b>Expected Return Date</b></td>
			<td><b>Actual Return Date</b></td>
			<td><b>No. of Days Overdue</b></td>
		</tr>
		<%
			for (int i = 0; i < bookIssueId.size(); i++) {
		%>
		<tr>
			<td><%=bookId.elementAt(i)%></td>
			<td><%=bookIssueId.elementAt(i)%></td>
			<td><%=memId.elementAt(i)%></td>
			<td><%=bookIssueDate.elementAt(i)%></td>
			<td><%=bookExpRetDate.elementAt(i)%></td>
			<td><%=bookActRetDate.elementAt(i)%></td>
			<td><%=noOfDaysDues.elementAt(i)%></td>
		</tr>
		<%
			}
		%>

		<%
			}
		%>

		<%
			if (issueReportType.equals("all")) {
		%>

		<tr>

			<td><b>Book Issue Id</b></td>
			<td><b>Member ID</b></td>
			<td><b>Book Id</b></td>
			<td><b>Book Issue Date</b></td>
			<td><b>Expected Return Date</b></td>
			<td><b>Actual Return Date</b></td>
			<td><b>No. of Days Overdue</b></td>
		</tr>
		<%
			for (int i = 0; i < bookIssueId.size(); i++) {
		%>
		<tr>

			<td><%=bookIssueId.elementAt(i)%></td>
			<td><%=memId.elementAt(i)%></td>
			<td><%=bookId.elementAt(i)%></td>
			<td><%=bookIssueDate.elementAt(i)%></td>
			<td><%=bookExpRetDate.elementAt(i)%></td>
			<td><%=bookActRetDate.elementAt(i)%></td>
			<td><%=noOfDaysDues.elementAt(i)%></td>
		</tr>
		<%
			}
		%>

		<%
			}
		%>
	</table>
</body>
</html>