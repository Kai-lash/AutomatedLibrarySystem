<%@page import="book.servlet_bookRequest"%>
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
	servlet_bookRequest amr = new servlet_bookRequest();
	amr.reportBookRequest();
	Vector memId = amr.memIdV;
	Vector memName = amr.memNameV;
	Vector bookName = amr.bookNameV;
	Vector authorName = amr.authorNameV;
%>
<body>
	<%
		response.setContentType("application/vnd.ms-excel");
	%>
	<table align="center" border="1">
		<tr>
			<td colspan="4" rowspan="1" align="center"><b>List of Book
					Requests</b>
			</td>
		</tr>
		<tr>
			<td colspan="4"></td>
		</tr>
		<tr>
			<td><b>Member ID</b>
			</td>
			<td><b>Member Name</b>
			</td>
			<td><b>Book Name</b>
			</td>
			<td><b>Author Name</b>
			</td>
		</tr>

		<%
			for (int i = 0; i < memId.size(); i++) {
		%>
		<tr>
			<td align="left"><%=memId.elementAt(i)%></td>
			<td><%=memName.elementAt(i)%></td>
			<td><%=bookName.elementAt(i)%></td>
			<td><%=authorName.elementAt(i)%></td>
		</tr>

		<%
			}
		%>

	</table>
</body>
</html>