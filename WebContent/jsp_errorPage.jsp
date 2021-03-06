<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="book.servlet_bookReturn"%>
<%@page import="book.servlet_bookSearch"%>
<%@page import="java.util.Vector" isErrorPage="true"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252" />
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<%
	
%>

<body>
	<div id="wrap">

		<jsp:include page="jsp_welcomeHeader.jsp" />


		<div class="center_content">
			<div class="left_content">
				<div class="title">
					<span class="title_icon"><img src="images/bullet1.gif"
						alt="" title="" /> </span>Library
				</div>

				<div class="feat_prod_box_details">
					<p class="details"></p>

					<div class="contact_form">
						<div class="form_subtitle">Error</div>
						<h3 align="center">
							<font color="red">An Unexpected Error has Occurred</font>
						</h3>
						<h3 align="center">
							<font color="red">
								<%
									out.write(exception.getMessage() == null ? "" : exception
											.getMessage());
								%>
							</font>
						</h3>
						<a href="javascript:history.back();" class="contact">Back </a>
					</div>
				</div>

				<div class="clear"></div>
			</div>
			<!--end of left content-->

			<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>
