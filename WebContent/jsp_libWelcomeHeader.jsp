<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="style.css" />
<link type="text/css" href="css/ui-lightness/jquery-ui-1.8.23.custom.css" rel="stylesheet" />
		<script type="text/javascript" src="js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui-1.8.23.custom.min.js"></script>

<body>
	<%
		String libName = (String) session.getAttribute("Lib_Name") == null ? ""
				: (String) session.getAttribute("Lib_Name");
	%>
	<div class="header">
		<div class="logo">
			<a href="index.html"><img src="images/techy2.gif" alt="" title=""
				border="0" /> </a>
		</div>
		<div id="menu">
			<ul>
				
				<li><a href="jsp_libOptions.jsp">Home</a></li>
				<li><a href="jsp_newBookDetails.jsp">Add/Delete Books</a></li>
				<li><a href="jsp_memStatusActivate.jsp">Member Status
						Activation</a></li>
				<li><a href="jsp_libReportOptions.jsp">Reports</a></li>
				<li><a href="jsp_logout.jsp">Logout</a></li>
				<li><a href="#"></a></li>
				<li><a href="#"></a></li>
				<li><a href="#"></a></li>
				<li><a href="#"></a></li>
				<li><a href="#"></a></li>
				<li><a href="#"></a></li>
				<li><a href="#"></a></li>
				<li> <a href="#"><font face="lucida calligraphy" size="4" color="WHITE">Hi  
							<%=libName%></font></a>
				</li>
				
			</ul>
		</div>
	</div>
</body>
</html>