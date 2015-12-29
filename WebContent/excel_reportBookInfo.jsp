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
	amr.reportBookInfo();
	Vector bookId = amr.bookIdV;
	Vector bookName = amr.bookNameV;
	Vector authorName = amr.authorNameV;
	Vector bookQty = amr.bookQtyV;
	Vector bookPub = amr.bookPubV;
	Vector bookPubYear = amr.bookPubYearV;
	Vector bookPurDate = amr.bookPurDateV;
	Vector bookPages = amr.bookPagesV;
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
					color="RED" face="harrington" size="8">BOOK SHELF LIBRARY</font></b></td>
		</tr>
		<tr>
			<td colspan="8"></td>
		</tr>
		<tr>
			<td colspan="8" rowspan="1"><b>List of Books</b></td>
		</tr>

		<tr>
			<td colspan="8"></td>
		</tr>
		<tr>
			<td><b>Book Name</b></td>
			<td><b>Book ID</b></td>
			<td><b>Author Name</b></td>
			<td><b>Book Quantity</b></td>
			<td><b>Publisher</b></td>
			<td><b>Publishing Year</b></td>
			<td><b>Purchase Date </b></td>
			<td><b>Book Pages</b></td>
		</tr>
		<%
			for (int i = 0; i < bookId.size(); i++) {
		%>
		<tr>
			<td><%=bookId.elementAt(i)%></td>
			<td><%=bookName.elementAt(i)%></td>
			<td><%=authorName.elementAt(i)%></td>
			<td><%=bookQty.elementAt(i)%></td>
			<td><%=bookPub.elementAt(i)%></td>
			<td><%=bookPubYear.elementAt(i)%></td>
			<td><%=bookPurDate.elementAt(i)%></td>
			<td><%=bookPages.elementAt(i)%></td>
		</tr>

		<%
			}
		%>
	</table>
</body>
</html>