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

var fname = /^[A-Za-z]+$/;

var contact = /^[0-9]+$/;

var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

var reg1 = /^([A-Za-z0-9_\-\.])+\@([A-Za-z])+\.([A-Za-z]{2,4})$/;

	function payMode() {
		payment_Mode = document.forms[0].payment_Mode.value;
		location.replace("jsp_payment.jsp?payment_Mode=" + payment_Mode);
	}

	function retainVal(payment_Mode) {
		document.forms[0].payment_Mode.value = payment_Mode;
	}
	
	function validateModePay() {
		if (document.forms[0].payment_Mode.value == '0') {
			alert('Please select a mode of payment');
		}
	}
	function validateNAC() {
		if (document.forms[0].cardName.value == '') {
			alert('Name on Card cannot be blank!');
		} else if (!document.forms[0].cardName.value.match(fname)) {
			alert('Invalid Characters in name on card field!');
			document.forms[0].cardName.value = '';
		}
	}
	function validateCN() {
		if (document.forms[0].cardno.value == '') {
			alert('Card number cannot be blank!');
		} else if (!document.forms[0].cardno.value.match(contact)) {
			alert('Card number should contain numeric values only');
			document.forms[0].cardno.value = '';
		}
	}
	function validateCVV() {
		if (document.forms[0].cvvno.value == '') {
			alert('CVV no. cannot be blank!');
		} else if (!document.forms[0].cvvno.value.match(contact)) {
			alert('CVV should contain numeric values only');
			document.forms[0].cvvno.value = '';
		}
	}

	function validateCheque() {
		if (document.forms[0].cheque_no.value == '') {
			alert('Check no. cannot be blank!');
		} else if (!document.forms[0].cheque_no.value.match(contact)) {
			alert('Check no. should contain numeric values only');
			document.forms[0].cheque_no.value = '';
		}
	}

	function validateBank() {
		if (document.forms[0].bank_name.value == '') {
			alert('Bank name cannot be blank!');
		} else if (!document.forms[0].bank_name.value.match(fname)) {
			alert('Invalid Characters in bank name!');
			document.forms[0].bank_name.value = '';
		}
	}

	function validateDD() {
		if (document.forms[0].dd_no.value == '') {
			alert('DD no. cannot be blank!');
		} else if (!document.forms[0].dd_no.value.match(contact)) {
			alert('DD no.should contain numeric values only');
			document.forms[0].dd_no.value = '';
		}
	}
	function validateAll(){
		var flag=false;
		var elem=document.forms[0].elements;
		for(var i=0;i<elem.length;i++){
			if(elem[i]!=null){
				if(elem[i].value==''){
					flag=true;
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

					break;
				}
			}
		}
		if(flag==false){
			document.forms[0].submit();
		}
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
	servlet_payment sp = new servlet_payment();
	sp.showPaymentDetails(request, response);
%>
<%
	String searchBy = request.getParameter("searchBy") == null ? ""
			: request.getParameter("searchBy");
%>
<%
	if ((sp.msg) == "P") {
		String msg2 = "You have already done the payment for this year";
		response.sendRedirect("jsp_paymentDone.jsp?msg1=" + msg2);
	} else {
%>


<body onload="retainVal('<%=payment_Mode%>')">
	<div id="wrap">

		<jsp:include page="jsp_memWelcomeHeader.jsp" />


		<div class="center_content">
			<div class="left_content">
				
				<div class="feat_prod_box_details">
					<p class="details"></p>
						<%if(!msg.equals("")){ %>
		
		<div id="dialog" title="Alert!">
			<p><font color="red">* Marked fields are mandatory !!</font></p>
		</div>
		
	<br><br></br></br>
		<div class="ui-widget">
			<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
				<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
				<strong>Alert:</strong> <%=msg %></p>
			</div>
		</div>

<br></br>
<%} %>
					<div class="contact_form">
						<div class="form_subtitle">Payment</div>

							<%if(!sp.msg.equals("")){ %>
							
							
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
			<p><b><%=sp.msg%> </</b></p>
		</div>
							
								<%} %>
					</div>
				</div>

				<form action="servlet_payment">
					<table align="center" class="cart_table" border="1">
						<tr class="cart_title">
							<td><b>Amount :</b>
							</td>
							<td><b>1000</b>
							</td>
						</tr>
						<tr>
							<td>Select the mode of payment:</td>
							<td><select name="payment_Mode" onchange="payMode()" onblur="validateModePay()">
									<option value="0">--Select--</option>
									<option value="Credit_Card">Credit Card</option>
									<option value="Debit_Card">Debit Card</option>

									<option value="Cheque">Cheque</option>
									<option value="DD">DD</option>
							</select>
							</td>
						</tr>
						
						<%
							if (payment_Mode.equals("Credit_Card")
										|| payment_Mode.equals("Debit_Card")) {
						%>
						<tr>
							<td><label class="contact"><strong>Card No*:</strong>
							</label>
							</td>
							<td><input type="text" class="contact_input" name="cardno" maxlength="16" onkeyup="validateCN()"/>
							</td>
						</tr>

						<tr>
							<td><label class="contact"><strong>CVV No*:</strong>
							</label>
							</td>
							<td><input type="text" class="contact_input" name="cvvno" maxlength="3" onkeyup="validateCVV()"/>
							</td>
						</tr>

						<tr>
							<td><label class="contact"><strong>Name on
										Card*: </strong>
							</label>
							</td>
							<td><input type="text" name="cardName" class="contact_input" maxlength="15" onkeyup="validateNAC()"/>
							</td>
						</tr>
						<%
							} else if (payment_Mode.equals("Cheque")) {
						%>

						<tr>
							<td><label class="contact"><strong>Cheque
										No* :</strong>
							</label>
							</td>
							<td><input type="text" class="contact_input"
								name="cheque_no" maxlength="10" onkeyup="validateCheque()"/></td>
						</tr>

						<tr>
							<td><label class="contact"><strong>Bank
										Name* : </strong>
							</label>
							</td>
							<td><input type="text" class="contact_input"
								name="bank_name" maxlength="20" onkeyup="validateBank()"/></td>
						</tr>
						<%
							} else if (payment_Mode.equals("DD")) {
						%>

						<tr>
							<td><label class="contact"><strong>Demand
										Draft No* : </strong>
							</label>
							</td>
							<td><input type="text" class="contact_input" name="dd_no"
								 maxlength="10" onkeyup="validateDD()"/></td>
						</tr>

						<tr>
							<td><label class="contact"><strong>Bank
										Name* : </strong>
							</label>
							</td>
							<td><input type="text" class="contact_input"
								name="bank_name" maxlength="20" onkeyup="validateBank()"/></td>
						</tr>
						<%
							}
						%>

						<tr>
							<td colspan="2" align="center"><input type="button"
								value="Pay" class="register" onclick="validateAll()"></input></td>
						</tr>

					</table>
					<input type="hidden" name="pageOption" value="makePayment"></input>
					<br><br></br></br>
					<div align="center">
					<a href="jsp_prevPayment.jsp" class="report">Previous Payments</a> <a
						href="jsp_bookFine.jsp" class="report">Fine</a>
						</div>
					<%
						}
					%>
				</form>

				<div class="clear"></div>
			</div>
			<!--end of left content-->

			<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>
