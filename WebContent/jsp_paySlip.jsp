<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="report.servlet_report"%>
<%@page import="java.util.Vector"%>
<%@page import="book.servlet_bookRequest"
	errorPage="jsp_errorPageMem.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252" />
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script type="text/javascript">
	function toExcel() {

		msgMemId = document.forms[0].msgMemId.value;
		msgMemName = document.forms[0].msgMemName.value;
		msgTransId = document.forms[0].msgTransId.value;
		msgTransDate = document.forms[0].msgTransDate.value;
		msgTransAmount = document.forms[0].msgTransAmount.value;
		msgFeesType = document.forms[0].msgFeesType.value;

		location.replace("excel_paySlip.jsp?msgMemId=" + msgMemId
				+ "&msgMemName=" + msgMemName + "&msgTransId=" + msgTransId
				+ "&msgTransDate=" + msgTransDate + "&msgTransAmount="
				+ msgTransAmount + "&msgFeesType=" + msgFeesType);
	}
</script>
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
	<div id="wrap">

		<jsp:include page="jsp_welcomeHeader.jsp" />

		<form>
			<div class="center_content">
				<div class="left_content">
					<div class="title"></div>

					<div class="feat_prod_box_details">
						<p class="details"></p>
							<%if(!msgSuccess.equals("")){ %>
							
							
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
			<p><b><%=msgSuccess%> </</b></p>
		</div>
							
								<%} %>
						<div class="title">
							<span class="title_icon"><img src="images/bullet1.gif"
								alt="" title="" />
							</span>Payment Slip
						</div>
						<!--  <div class="contact_form">-->
						<div class="form_subtitle">Payment Slip</div>

						<input type="button" class="register" value="To Excel"
							onclick="toExcel()" />
						<table align="center" class="cart_table" border="1">
							<tr class="cart_title">

								<td><b>Member ID </b>
								</td>
								<td><b><%=msgMemId%></b>
								</td>
							</tr>
							<tr>
								<td><b>Member Name</b>
								</td>
								<td><b><%=msgMemName%></b>
								</td>
							</tr>
							<tr>
								<td><b>Transaction ID</b>
								</td>
								<td><b><%=msgTransId%></b>
								</td>
							</tr>
							<tr>
								<td><b>Transaction Date</b>
								</td>
								<td><b><%=msgTransDate%></b>
								</td>
							</tr>
							<tr>
								<td><b>Amount Paid</b>
								</td>
								<td><b><%=msgTransAmount%></b>
								</td>
							</tr>
							<tr>
								<td><b>Payment Type</b>
								</td>
								<td><b><%=msgFeesType%></b>
								</td>
							</tr>
							<tr>
							</tr>

						</table>

					</div>

					<input type="hidden" name="msgMemId" value="<%=msgMemId%>"></input>
					<input type="hidden" name="msgMemName" value="<%=msgMemName%>"></input>
					<input type="hidden" name="msgTransId" value="<%=msgTransId%>"></input>
					<input type="hidden" name="msgTransDate" value="<%=msgTransDate%>"></input>
					<input type="hidden" name="msgTransAmount"
						value="<%=msgTransAmount%>"></input> <input type="hidden"
						name="msgFeesType" value="<%=msgFeesType%>"></input>
		</form>

		<div class="clear"></div>
	</div>
	<!--end of left content-->
	<jsp:include page="jsp_welcomeFooter.jsp" />


</body>
</html>
