<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<%
	String msgSuccess = request.getParameter("msgSuccess") == null ? ""
			: request.getParameter("msgSuccess");
	String msgMemName = request.getParameter("msgMemName") == null ? ""
			: request.getParameter("msgMemName");
	String msgTransId = request.getParameter("msgTransId") == null ? ""
			: request.getParameter("msgTransId");
	String msgMemId = request.getParameter("msgMemId") == null ? ""
			: request.getParameter("msgMemId");
	String msgTransDate = request.getParameter("msgTransDate") == null ? ""
			: request.getParameter("msgTransDate");
	String msgTransAmount = request.getParameter("msgTransAmount") == null ? ""
			: request.getParameter("msgTransAmount");
	String msgFeesType = request.getParameter("msgFeesType") == null ? ""
			: request.getParameter("msgFeesType");
%>
<body>
	<%
		response.setContentType("application/vnd.ms-excel");
	%>
	<table align="center" border="1">
	<tr>
			<td colspan="8" rowspan="1" align="center"><b><font
					color="RED" face="harrington" size="8">BOOK SHELF LIBRARY</font></b></td>
		</tr>
		<tr>
			<td colspan="8"></td>
		</tr>
	
		<tr>
			<td colspan="8" align="center"><b>Payment Slip</b>
			</td>
		</tr>
		<tr>
			<td colspan="8"></td>
		</tr>
		<tr>
			<td colspan="4"><b>Member ID </b></td>
			<td colspan="4"><%=msgMemId%></td>
		</tr>
		<tr>
			<td colspan="4"><b>Member Name</b></td>
			<td colspan="4"><%=msgMemName%></td>
		</tr>
		<tr>
			<td colspan="4"><b>Transaction ID</b></td>
			<td colspan="4"><%=msgTransId%></td>
		</tr>
		<tr>
			<td colspan="4"><b>Transaction Date</b></td>
			<td colspan="4" align="left"><%=msgTransDate%></td>
		</tr>
		<tr>
			<td colspan="4"><b>Amount Paid</b></td>
			<td colspan="4" align="left"><%=msgTransAmount%></td>
		</tr>
		<tr>
			<td colspan="4"><b>Payment Type</b></td>
			<td colspan="4"><%=msgFeesType%></td>
		</tr>
		<tr>
		</tr>

	</table>
</body>
</html>