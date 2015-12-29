<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@page import="java.util.Vector" errorPage="jsp_errorPageLib.jsp"%>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252" />
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<%
	String libName = (String) session.getAttribute("Lib_Name") == null ? ""
			: (String) session.getAttribute("Lib_Name");
	if (libName.equals("")) {
		response.sendRedirect("jsp_libLogin.jsp");
	}
%>
<%
	String msg = request.getParameter("msg") == null ? "Welcome" : request
			.getParameter("msg");
%>

<body>
	<div id="wrap">

		<jsp:include page="jsp_libWelcomeHeader.jsp" />


		<div class="center_content">
			<div class="left_content">
				<div class="title">
					<span class="title_icon"><img src="images/bullet1.gif"
						alt="" title="" />
					</span>Librarian Account
				</div>

				<div class="feat_prod_box_details">
					<p class="details"></p>
						<%if(!msg.equals("")){ %>
							
							
							<script type="text/javascript">
		$(function(){

					// Dialog
			$('#dialog').dialog({
				autoOpen: true,
				width: 400,
				
				buttons: {
					"Ok": function() {
						$(this).dialog("close");
					},
					"Cancel": function() {
						$(this).dialog("close");
					}
				}
			});

		});


	</script>
							
					<div id="dialog" title="Message" style="color: green;">
			<p><b><%=msg%> <%=libName%></</b></p>
		</div>
							
								<%} %>
					
					
				</div>

				<div class="clear"></div>
			</div>
			<!--end of left content-->
			<jsp:include page="jsp_welcomeSidebar.jsp" />
			<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>
