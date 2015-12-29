<%@page import="java.util.Vector"%>
<%@page import="book.servlet_bookRequest"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" errorPage="jsp_errorPageMem.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<%
	String fname = (String) session.getAttribute("Member_Name") == null ? ""
			: (String) session.getAttribute("Member_Name");
	if (fname.equals("")) {
		response.sendRedirect("jsp_memlogin.jsp");
	}

	servlet_bookRequest br = new servlet_bookRequest();
	br.requestStatus(request);

	Vector bookStatus = br.reqBookStatusV2;
	Vector bookName = br.reqBookNameV2;
	Vector authorName = br.reqAuthorNameV2;
	Vector requestId = br.requestIdV2;
%>
<body>
	<jsp:include page="welcomeMsg.jsp"></jsp:include>
	<h4 align="center">Status for the Requested Books</h4>
	<a href="jsp_memOptions.jsp">Back</a> &nbsp;&nbsp;&nbsp;
	<a href="jsp_memOptions.jsp">Home</a>
	<table background="Blue hills.jpg" align="center" border="1">

		<%
			if (bookName.size() > 0) {
		%>
		<tr>
			<td>Request ID</td>
			<td>Book Name</td>
			<td>Author Name</td>
			<td>Status</td>

		</tr>
		<%
			for (int i = 0; i < bookName.size(); i++) {
		%>

		<tr>
			<td><%=requestId.elementAt(i)%></td>
			<td><%=bookName.elementAt(i)%></td>
			<td><%=authorName.elementAt(i)%></td>
			<td><%=bookStatus.elementAt(i)%></td>


		</tr>

		<%
			}
		%>
		<%
			} else {
		%>
		
		
	<br><br></br></br>
		<div class="ui-widget">
			<div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
				<p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
				<strong></strong>No Request Made!!</p>
			</div>
		</div>
	
<br></br>

		<%
			}
		%>
	</table>
</body>
</html>