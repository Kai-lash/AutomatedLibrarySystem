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

	servlet_payment sp = new servlet_payment();
	sp.showPrevPayment(request, response);
	Vector mem_Id = sp.mem_IdV;
	Vector trans_Id = sp.trans_IdV;
	Vector mode_Of_Payment = sp.mode_Of_PaymentV;
	Vector amount = sp.amountV;
	Vector payment_Date = sp.payment_DateV;
	Vector fees_Type = sp.fees_TypeV;
%>


<body>
	<div id="wrap">

		<jsp:include page="jsp_memWelcomeHeader.jsp" />


		<div class="center_content">
			<div class="left_content">
				
				<div class="feat_prod_box_details">
					<p class="details"></p>
					<div class="title">
						<span class="title_icon"><img src="images/bullet1.gif"
							alt="" title="" /> </span>Previous Payments
					</div>
					<h5 align="center">
						<font color="red"><%=msg%></font>
					</h5>


						<h5 align="center">
							<font color="red"><%=sp.msg%></font>
						</h5>
				</div>

				<form action="servlet_payment">
					<table align="center" class="cart_table1" border="1">
						<tr class="cart_title">


							<td>Member Id</td>
							<td>Transaction Id</td>
							<td>Mode of payment</td>
							<td>Amount</td>
							<td>Payment date</td>
							<td>Fee type</td>
						</tr>
						<%
							for (int i = 0; i < mem_Id.size(); i++) {
						%>
						<tr>
							<td><%=mem_Id.elementAt(i)%></td>
							<td><%=trans_Id.elementAt(i)%></td>
							<td><%=mode_Of_Payment.elementAt(i)%></td>
							<td><%=amount.elementAt(i)%></td>
							<td><%=payment_Date.elementAt(i)%></td>
							<td><%=fees_Type.elementAt(i)%></td>
						</tr>
						<%
							}
						%>

					</table>
					<input type="hidden" name="pageOption" value="makePayment"></input>

				</form>

				<div class="clear"></div>
			</div>
			<!--end of left content-->

			<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>
