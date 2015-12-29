<%@page import="java.util.Vector"%>
<%@page import="report.servlet_report"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
	
</script>
</head>
<%
	String msg = request.getParameter("msg") == null ? "" : request
			.getParameter("msg");
	String span = request.getParameter("span") == null ? "all"
			: request.getParameter("span");
	String month = request.getParameter("month") == null ? "JAN"
			: request.getParameter("month");
	String year = request.getParameter("year") == null ? "2012"
			: request.getParameter("year");
%>
<%
	servlet_report rpt = new servlet_report();
	rpt.setSpan6(span);
	rpt.setMemCollMonth6(month);
	rpt.setMemCollYear6(year);
	rpt.reportFineCollection();
	Vector memIdV1 = rpt.memIdV6;
	Vector memNameV1 = rpt.memNameV6;
	Vector memFeesTypeV1 = rpt.memFeesTypeV6;
	Vector memFeesV1 = rpt.memFeesV6;
	String memTotalCollection = rpt.memTotalCollection6;
%>
<body>
	<%
		response.setContentType("application/vnd.ms-excel");
	%>
	<table align="center" border="1">
	<tr>
			<td colspan="3" rowspan="1" align="center"><b><font
					color="RED" face="harrington" size="7">BOOK SHELF LIBRARY</font></b></td>
		</tr>
		<tr>
			<td colspan="3"></td>
		</tr>
	
		<tr>
			<td colspan="3" rowspan="1" align="center"><b>Fine Collection Report : <%if(span.equals("all")){%>Full Report<%} else if(span.equals("monthwise")){%>Monthwise Report<%} else if(span.equals("yearwise")){%>Yearwise Report<%}%></b></td>
		</tr>
		<tr>
			<td colspan="3"></td>
		</tr>

		<%
			if (span.equals("monthwise")) {
		%>
		<tr>
			<td><%=month%></td>
			<td colspan="2"><%=year%></td>
		</tr>
		<tr>
			<td><b>Member Name</b></td>
			<td><b>Member ID</b></td>
			<td><b>Fine</b></td>
		</tr>
		<%
			for (int i = 0; i < memIdV1.size(); i++) {
		%>
		<tr>
			<td><%=memNameV1.elementAt(i)%></td>
			<td><%=memIdV1.elementAt(i)%></td>
			<td><%=memFeesV1.elementAt(i)%></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="2">Total</td>
			<td><%=memTotalCollection%></td>
		</tr>

		<%
			} else if (span.equals("yearwise")) {
		%>
		<tr>
			<td colspan="3"><%=year%></td>

		</tr>
		<%
			for (int i = 0; i < memIdV1.size(); i++) {
		%>
		<tr>
			<td><%=memNameV1.elementAt(i)%></td>
			<td><%=memIdV1.elementAt(i)%></td>
			<td><%=memFeesV1.elementAt(i)%></td>

		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="2">Total</td>
			<td><%=memTotalCollection%></td>
		</tr>
		<%
			} else if (span.equals("all")) {
		%>

		
		<tr>
			<td><b>Member Name</b></td>
			<td><b>Member ID</b></td>
			<td><b>Fine</b></td>
		</tr>
		<%
			for (int i = 0; i < memIdV1.size(); i++) {
		%>
		<tr>
			<td><%=memNameV1.elementAt(i)%></td>
			<td><%=memIdV1.elementAt(i)%></td>
			<td><%=memFeesV1.elementAt(i)%></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="2">Total</td>
			<td><%=memTotalCollection%></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>