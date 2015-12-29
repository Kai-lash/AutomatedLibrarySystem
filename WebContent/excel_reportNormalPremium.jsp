<%@page import="java.util.Vector"%>
<%@page import="report.servlet_report"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<%
	String memType = request.getParameter("memType") == null ? "all"
			: request.getParameter("memType");
	servlet_report rpt = new servlet_report();
	rpt.setMemType(memType);
	rpt.getNormalPremium();
	Vector memId = rpt.memId;
	Vector memName = rpt.memName;
	Vector cellNo = rpt.cellNo;
	Vector emailId = rpt.emailId;
	Vector membership = rpt.membership;
	String msg = request.getParameter("msg") == null ? "" : request
			.getParameter("msg");
%>
<body>
	<%
		response.setContentType("application/vnd.ms-excel");
	%>
	<table align="center" border="1">
		<tr>
			<td colspan="5" rowspan="1"><b>List of <%=memType%> members</b>
			</td>
		</tr>
		<tr>
			<td colspan="5"></td>
		</tr>
		<tr>

			<td><b>Member Name</b></td>
			<td><b>Member ID</b></td>
			<td><b>Email ID</b></td>
			<td><b>Contact No.</b></td>
			<td><b>Membership Type</b></td>
		</tr>
		<%
			for (int i = 0; i < memId.size(); i++) {
		%>
		<tr>
			<td><%=memName.elementAt(i)%></td>
			<td><%=memId.elementAt(i)%></td>
			<td><%=emailId.elementAt(i)%></td>
			<td><%=cellNo.elementAt(i)%></td>
			<td><%=membership.elementAt(i)%></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>