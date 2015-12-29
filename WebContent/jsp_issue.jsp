<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" errorPage="jsp_errorPageMem.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="welcomeMsg.jsp"></jsp:include>
	<a href="jsp_memOptions.jsp">Back</a>
	&nbsp;&nbsp;&nbsp;
	<a href="jsp_memOptions.jsp">Home</a>
	<form action="">
	<h4 align="center">Search for a Book</h4>
		<table background="Blue hills.jpg" align="center">
			<tr>
				<td>Book Name</td>
				<td><select name="bookName1">
						<option value="0">--Select--</option>
						<option value="1">Book1</option>
						<option value="2">Book2</option>
				</select>
				</td>
				<td>Author Name</td>
				<td><select name="authorName1">
						<option value="0">--Select--</option>
						<option value="1">Author1</option>
						<option value="2">Author2</option>
				</select>
				</td>
			</tr>
			<tr>
				<td>Book Name</td>
				<td><input type="text" name="bookName">
				</td>
			</tr>
			<tr>
				<td>Author Name</td>
				<td><input type="text" name="authorName">
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="Issue">
				</td>
			</tr>
		</table>
		<input type="hidden" name="pageOption" value="bookSearch">
	</form>
</body>
</html>