<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="payment.servlet_payment"%>
<%@page import="book.servlet_bookReturn"%>
<%@page import="book.servlet_bookSearch"%>
<%@page import="java.util.Vector" errorPage="jsp_errorPageMem.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252" />
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<%
	String fname = (String) session.getAttribute("Member_Name") == null ? ""
			: (String) session.getAttribute("Member_Name");
	if (fname.equals("")) {
		response.sendRedirect("jsp_memlogin.jsp");
	}
%>
<%
	String msg = request.getParameter("msg") == null ? "" : request
			.getParameter("msg");

	String msg1 = request.getParameter("msg1") == null ? "" : request
			.getParameter("msg1");
	String paymentDoneMsg = request.getParameter("paymentDoneMsg") == null ? ""
			: request.getParameter("paymentDoneMsg");
%>


<body>
	<div id="wrap">

		<jsp:include page="jsp_memWelcomeHeader.jsp" />

		<div class="center_content">
			<div class="left_content">
				<div class="title">
					<span class="title_icon"><img src="images/bullet1.gif"
						alt="" title="" />
					</span>My Account
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
			<p><b><%=msg%> </</b></p>
		</div>
							
								<%} %>
					<div class="contact_form">
						<div class="form_subtitle">Payment Status</div>


							<%if(!msg1.equals("")){ %>
							
							
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
			<p><b><%=msg1%></</b></p>
		</div>
							
								<%} %>

						<h3 align="center">
							<font color="green"><%=paymentDoneMsg%></font>
						</h3>
						<a href="jsp_prevPayment.jsp" class="report">Previous Payments</a> <a
						href="jsp_bookFine.jsp" class="report">Fine</a>					</div>

				</div>

				<div class="clear"></div>
			</div>
			<!--end of left content-->

			<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>
