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
<script type="text/javascript">
	function payMode() {
		payment_Mode = document.forms[0].payment_Mode.value;
		location.replace("jsp_bookFine.jsp?payment_Mode=" + payment_Mode);
	}

	function retainVal(payment_Mode) {
		document.forms[0].payment_Mode.value = payment_Mode;
	}
</script>
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

	String payment_Mode = request.getParameter("payment_Mode") == null ? "0"
			: request.getParameter("payment_Mode");

	servlet_bookReturn sbr = new servlet_bookReturn();
	//sbr.returnUpdate(request, response);
	sbr.bookReturn(request, response);

	Vector book_Id = sbr.book_IdV1;
	Vector book_Name = sbr.book_NameV1;

	Vector book_issueDate = sbr.book_issueDateV1;
	Vector book_ExpReturnDate = sbr.book_ExpReturnDateV1;
	Vector no_Overdue = sbr.no_OverdueV1;
%>
<%
	String searchBy = request.getParameter("searchBy") == null ? ""
			: request.getParameter("searchBy");
%>
<%
	
%>


<body onload="retainVal('<%=payment_Mode%>')">
	<div id="wrap">

		<jsp:include page="jsp_memWelcomeHeader.jsp" />


		<div class="center_content">
			<div class="left_content">

				<div class="feat_prod_box_details">
					<p class="details"></p>
					<div class="title">
						<span class="title_icon"><img src="images/bullet1.gif"
							alt="" title="" /> </span>Fine Payment
					</div>
					
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
			<p><b><%=msg%></b></p>
		</div>
							
								<%} %>


						<h5 align="center">
							<font color="red"> <%
 	//=sp.msg
 %>
							</font>
						</h5>

				</div>

				<form action="servlet_payment">
					<table align="center" class="cart_table" border="1">
						<tr class="cart_title">


							<td><b>Book Name</b></td>
							<td><b>Book IssueDate</b></td>
							<td><b>Exp. ReturnDate</b></td>
							<td><b>Fine</b></td>


						</tr>


						<%
							for (int i = 0; i < book_Name.size(); i++) {
						%>
						<tr>

							<td><%=book_Name.elementAt(i)%></td>
							<td><%=book_issueDate.elementAt(i)%></td>
							<td><%=book_ExpReturnDate.elementAt(i)%></td>
							<td><%=no_Overdue.elementAt(i)%></td>

						</tr>

						<%
							}
						%>

						<%
							int sum = 0;
							for (int i = 0; i < no_Overdue.size(); i++) {
								sum = sum + (Integer) no_Overdue.elementAt(i);
							}
						%>

						<tr>
							<td colspan="2"><b>Total Fine</b></td>
							<td colspan="2"><%=sum%></td>
						</tr>
						<%
							if (sum != 0) {
						%>
						<tr>
							<td colspan="2">Select the mode of payment:</td>
							<td colspan="3"><select name="payment_Mode"
								onchange="payMode()">
									<option value="0">--Select--</option>
									<option value="Credit_Card">Credit Card</option>
									<option value="Debit_Card">Debit Card</option>

									<option value="Cheque">Cheque</option>
									<option value="DD">DD</option>
							</select></td>
						</tr>


						<%
							if (payment_Mode.equals("Credit_Card")
										|| payment_Mode.equals("Debit_Card")) {
						%>
						<tr>
							<td><label class="contact"><strong>Card No:</strong>
							</label></td>
							<td colspan="3"><input type="text" class="contact_input"
								name="cardno" maxlength="16" /></td>
						</tr>

						<tr>
							<td><label class="contact"><strong>CVV No:</strong>
							</label></td>
							<td colspan="3"><input type="text" class="contact_input"
								name="cvvno" maxlength="3" /></td>
						</tr>

						<tr>
							<td><label class="contact"><strong>Name on
										Card: </strong> </label></td>
							<td colspan="3"><input type="text" name="cardName"
								class="contact_input" maxlength="15" /></td>
						</tr>
						<%
							} else if (payment_Mode.equals("Cheque")) {
						%>

						<tr>
							<td><label class="contact"><strong>Cheque
										No :</strong> </label></td>
							<td colspan="3"><input type="text" class="contact_input"
								name="cheque_no" maxlength="10" /></td>
						</tr>

						<tr>
							<td><label class="contact"><strong>Bank
										Name : </strong> </label></td>
							<td colspan="3"><input type="text" class="contact_input"
								name="bank_name" maxlength="15" /></td>
						</tr>
						<%
							} else if (payment_Mode.equals("DD")) {
						%>

						<tr>
							<td><label class="contact"><strong>Demand
										Draft No : </strong> </label></td>
							<td colspan="3"><input type="text" class="contact_input"
								name="dd_no" maxlength="10" /></td>
						</tr>

						<tr>
							<td><label class="contact"><strong>Bank
										Name : </strong> </label></td>
							<td colspan="3"><input type="text" class="contact_input"
								name="bank_name" maxlength="15" /></td>
						</tr>
						<%
							}
						%>
						<tr>
							<td colspan="5" align="center"><input type="submit"
								value="Pay" class="register"></input></td>
						</tr>
						<%
							}
						%>
					</table>
					<input type="hidden" name="pageOption" value="makeFinePayment"></input>
					<input type="hidden" name="amount" value="<%=sum%>"></input>

				</form>

				<div class="clear"></div>
			</div>
			<!--end of left content-->

			<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>
