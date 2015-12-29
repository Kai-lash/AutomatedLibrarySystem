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
	servlet_report amr = new servlet_report();
	amr.reportInactiveMem();
	Vector memId = amr.memIdV;
	Vector memPwd = amr.memPwdV;
	Vector memFname = amr.memFnameV;
	Vector memMname = amr.memMnameV;
	Vector memLname = amr.memLnameV;
	Vector memAddress = amr.memAddressV;
	Vector memEmailId = amr.memEmailIdV;
	Vector memCellNo = amr.memCellNoV;
	Vector memType = amr.memTypeV;
	Vector memStatus = amr.memStatusV;
	Vector memRegDate = amr.memRegDateV;
	String msg = request.getParameter("msg") == null ? "" : request
			.getParameter("msg");
%>
<body>
	<%
		response.setContentType("application/vnd.ms-excel");
	%>
	<table align="center" border="1">
	<tr>
			<td colspan="8" rowspan="1" align="center"><b><font
					color="RED" face="harrington" size="7">BOOK SHELF LIBRARY</font></b></td>
		</tr>
		<tr>
			<td colspan="8"></td>
		</tr>
		<tr>
			<td colspan="8" rowspan="1" align="center"><b>List of
					Inactive Members</b></td>
		</tr>
		<tr>
			<td colspan="8"></td>
		</tr>
		<tr>

			<td><b>Member Id</b></td>
			<td><b>Member Firstname</b></td>
			<td><b>Member Lastname</b></td>
			<td><b>Email Id</b></td>
			<td><b>Cell No.</b></td>
			<td><b>Membership Type</b></td>
			<td><b>Status</b></td>
			<td><b>Registration Date</b></td>
		</tr>
		<%
			for (int i = 0; i < memId.size(); i++) {
		%>
		<tr>
			<td><%=memId.elementAt(i)%></td>
			<td><%=memFname.elementAt(i)%></td>
			<td><%=memLname.elementAt(i)%></td>
			<td><%=memEmailId.elementAt(i)%></td>
			<td><%=memCellNo.elementAt(i)%></td>
			<td><%=memType.elementAt(i)%></td>
			<td><%=memStatus.elementAt(i)%></td>
			<td><%=memRegDate.elementAt(i)%></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>