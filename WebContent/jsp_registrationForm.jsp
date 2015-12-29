<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252" />
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<%@page import="java.util.Vector" errorPage="jsp_errorPage.jsp"%>
<script type="text/javascript">
	var fname = /^[A-Za-z]+$/;

	var contact = /^[0-9]+$/;

	var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

	var reg1 = /^([A-Za-z0-9_\-\.])+\@([A-Za-z])+\.([A-Za-z]{2,4})$/;

	function validateFname() {

		if (document.forms[0].firstName.value == '') {
			alert('First Name can not be Empty');
		} else if (!document.forms[0].firstName.value.match(fname)) {
			alert('Invalid Characters in first name!');
			document.forms[0].firstName.value = '';
		}
	}
	function validateMname() {

		if (!document.forms[0].middleName.value.match(fname)) {
			alert('Invalid Characters in middle name!');
			document.forms[0].middleName.value = '';
		}
	}
	function validateLname() {
		if (document.forms[0].lastName.value == '') {
			alert('Last Name can not be Empty');
		} else if (!document.forms[0].lastName.value.match(fname)) {
			alert('Invalid Characters in last name!');
			document.forms[0].lastName.value = '';
		}
	}
	function validatePass() {
		if (document.forms[0].password.value == '') {
			alert('Password can not be Empty');
		}
	}
	function validateCpass() {
		if (document.forms[0].cpassword.value == '') {
			alert('Confirm Password field can not be Empty');
		} else if (document.forms[0].cpassword.value != document.forms[0].password.value) {
			alert('Password not matching !');
			document.forms[0].cpassword.value = '';
		}
	}
	function validateSQ() {
		if (document.forms[0].SecurityQuestion.value == '') {
			alert('Please select a security question !');
		}
	}
	function validateSA() {
		if (document.forms[0].sec_que_ans.value == '') {
			alert('Answer cannot be Empty');
		}
	}
	function validateAddress() {
		if (document.forms[0].address.value == '') {
			alert('Address cannot be Empty');
		}

	}
	function validateEmail() {
		if (document.forms[0].emailId.value == '') {
			alert('Email Id cannot be Empty');
		} else if (!document.forms[0].emailId.value.match(reg)) {
			alert('Invalid Email Id!');
			document.forms[0].emailId.value = '';
		}
	}
	function validateContact() {

		if (document.forms[0].contactNo.value == '') {
			alert('Contact cannot be Empty');
		} else if (!document.forms[0].contactNo.value.match(contact)) {
			alert('Contact number should contain numeric values only');
			document.forms[0].contactNo.value = '';
		}
	}
	function validateModePay() {
		if (document.forms[0].mode.value == '0') {
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

	function enabutton() {
		if (document.forms[0].terms.checked) {
			document.forms[0].sub.disabled = false;
		} else {
			document.forms[0].sub.disabled = true;
		}
	}

	function modePay() {
		if (document.forms[0].mode.value == 'Credit Card'
				|| document.forms[0].mode.value == 'Debit Card') {
			document.forms[0].cardno.disabled = false;
			document.forms[0].cvvno.disabled = false;
			document.forms[0].cardName.disabled = false;
			document.forms[0].dd_no.disabled = true;
			document.forms[0].bank_name.disabled = true;
			document.forms[0].cheque_no.disabled = true;
		} else if (document.forms[0].mode.value == 'Cheque') {
			document.forms[0].cardno.disabled = true;
			document.forms[0].cvvno.disabled = true;
			document.forms[0].cardName.disabled = true;
			document.forms[0].dd_no.disabled = true;
			document.forms[0].bank_name.disabled = false;
			document.forms[0].cheque_no.disabled = false;
		} else if (document.forms[0].mode.value == 'DD') {
			document.forms[0].cardno.disabled = true;
			document.forms[0].cvvno.disabled = true;
			document.forms[0].cardName.disabled = true;
			document.forms[0].dd_no.disabled = false;
			document.forms[0].bank_name.disabled = false;
			document.forms[0].cheque_no.disabled = true;
		}
	}

	function retainVal(firstName, lastName, middleName, cpassword, password,
			SecurityQuestion, sec_que_ans, address, emailId, contactNo, amount,
			hidMemType, mode) {

		document.forms[0].firstName.value = firstName;
		document.forms[0].lastName.value = lastName;
		document.forms[0].middleName.value = middleName;
		document.forms[0].password.value = password;
		document.forms[0].cpassword.value = cpassword;
		document.forms[0].SecurityQuestion.value = SecurityQuestion;
		document.forms[0].sec_que_ans.value = sec_que_ans;
		document.forms[0].address.value = address;
		document.forms[0].emailId.value = emailId;
		document.forms[0].contactNo.value = contactNo;
		document.forms[0].amount.value = amount;
		document.forms[0].hidMemType.value = hidMemType;
		document.forms[0].mode.value = mode;
	}

	function modePay1() {

		firstName = document.forms[0].firstName.value;
		lastName = document.forms[0].lastName.value;
		middleName = document.forms[0].middleName.value;
		password = document.forms[0].password.value;
		cpassword = document.forms[0].cpassword.value;
		SecurityQuestion = document.forms[0].SecurityQuestion.value;
		sec_que_ans = document.forms[0].sec_que_ans.value;
		address = document.forms[0].address.value;
		emailId = document.forms[0].emailId.value;
		contactNo = document.forms[0].contactNo.value;
		amount = document.forms[0].amount.value;
		hidMemType = document.forms[0].hidMemType.value;
		mode = document.forms[0].mode.value;
		location.replace("jsp_registrationForm.jsp?firstName=" + firstName
				+ "&lastName=" + lastName + "&middleName=" + middleName
				+ "&password=" + password + "&cpassword=" + cpassword
				+ "&SecurityQuestion=" + SecurityQuestion + "&sec_que_ans="
				+ sec_que_ans + "&address=" + address + "&emailId=" + emailId
				+ "&contactNo=" + contactNo + "&amount=" + amount
				+ "&hidMemType=" + hidMemType + "&mode=" + mode);
	}

	function amountPay(memType) {
		if (memType == 'normal') {
			document.forms[0].hidMemType.value = 'normal';
			document.forms[0].amount.value = '10000';
		} else {
			document.forms[0].hidMemType.value = 'premium';
			document.forms[0].amount.value = '12000';
		}
	}

	function validateAll() {
		var flag = false;
		var elem = document.forms[0].elements;
		for ( var i = 0; i < elem.length; i++) {
			if (elem[i] != null) {
				if (elem[i].value == ''
						&& (elem[i] != document.forms[0].middleName)) {
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
		if (flag == false) {
			document.forms[0].submit();
		}
	}
</script>
<%
	String msg = request.getParameter("msg") == null ? ""
			: request.getParameter("msg");
	String msgSuccess = request.getParameter("msgSuccess") == null ? ""
			: request.getParameter("msgSuccess");
	String firstName = request.getParameter("firstName") == null ? ""
			: request.getParameter("firstName");
	String lastName = request.getParameter("lastName") == null ? ""
			: request.getParameter("lastName");
	String middleName = request.getParameter("middleName") == null ? ""
			: request.getParameter("middleName");
	String password = request.getParameter("password") == null ? ""
			: request.getParameter("password");
	String cpassword = request.getParameter("cpassword") == null ? ""
			: request.getParameter("cpassword");
	String SecurityQuestion = request.getParameter("SecurityQuestion") == null ? "pet_name"
			: request.getParameter("SecurityQuestion");
	String sec_que_ans = request.getParameter("sec_que_ans") == null ? ""
			: request.getParameter("sec_que_ans");
	String address = request.getParameter("address") == null ? ""
			: request.getParameter("address");
	String emailId = request.getParameter("emailId") == null ? ""
			: request.getParameter("emailId");
	String contactNo = request.getParameter("contactNo") == null ? ""
			: request.getParameter("contactNo");
	String amount = request.getParameter("amount") == null ? "10000"
			: request.getParameter("amount");
	String hidMemType = request.getParameter("hidMemType") == null ? "normal"
			: request.getParameter("hidMemType");
	String mode = request.getParameter("mode") == null ? "0" : request
			.getParameter("mode");
%>
<body
	onload="retainVal('<%=firstName%>','<%=lastName%>','<%=middleName%>','<%=password%>','<%=cpassword%>','<%=SecurityQuestion%>','<%=sec_que_ans%>','<%=address%>','<%=emailId%>','<%=contactNo%>','<%=amount%>','<%=hidMemType%>','<%=mode%>')">
	<div id="wrap">


		<jsp:include page="jsp_welcomeHeader.jsp" />

		<div class="center_content">
			<div class="left_content">
				<div class="title">
					<span class="title_icon"><img src="images/bullet1.gif"
						alt="" title="" /> </span>Register
				</div>
<br></br>
<div id="dialog" title="Alert!">
			<p><font color="red">* Marked fields are mandatory !!</font></p>
		</div>

				<div class="feat_prod_box_details">
					<p class="details"></p>
					<%if(!msg.equals("")){ %>
		
	<br><br></br></br>
		<div class="ui-widget">
			<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
				<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
				<strong>Alert:</strong> <%=msg %></p>
			</div>
		</div>

<br></br>
<%} %>					<div class="contact_form">
						<div class="form_subtitle">Create New Account</div>
						<form name="register" action="servlet_memberRegistration">
							<div class="form_row">
								<label class="contact"><strong>Firstname*:</strong> </label> <input
									type="text" class="contact_input" name="firstName"
									onkeyup="validateFname()" maxlength="15" />
							</div>


							<div class="form_row">
								<label class="contact"><strong>Middlename:</strong> </label> <input
									type="text" class="contact_input" name="middleName"
									onkeyup="validateMname()" maxlength="15" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Lastname*:</strong> </label> <input
									type="text" class="contact_input" name="lastName"
									onkeyup="validateLname()" maxlength="15" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Password*:</strong> </label> <input
									type="password" class="contact_input" name="password"
									onblur="validatePass()" maxlength="15"></input>
							</div>

							<div class="form_row">
								<label class="contact"><strong>Confirm
										Password*:</strong> </label> <input type="password" class="contact_input"
									name="cpassword" onblur="validateCpass()" maxlength="15" />
							</div>

							<div class="form_row">
								<label class=""><strong>Security Question:</strong> </label> <select
									name="SecurityQuestion" onblur="validateSQ()">
									<!--  <option value="0">--Select--</option>-->
									<option value="pet_name">What is your pet's name ?</option>
									<option value="birth_place">What is your Birth Place ?</option>
									<option value="school_name">What is your School Name ?</option>

								</select>
							</div>

							<div class="form_row">
								<label class="contact"><strong>Answer*:</strong> </label> <input
									type="text" class="contact_input" name="sec_que_ans" size="30"
									onkeyup="validateSA()" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Correspondence
										Address*:</strong> </label> <input type="text" class="contact_input"
									name="address" size="70" onkeyup="validateAddress()"
									maxlength="50" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Email Id*:</strong> </label> <input
									type="text" class="contact_input" name="emailId" size="30"
									onblur="validateEmail()" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Contact No*:</strong> </label> <input
									type="text" class="contact_input" name="contactNo"
									onkeyup="validateContact()" maxlength="10" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Normal:</strong> </label> <input
									class="" type="radio" name="membershipType" value="normal"
									<%if (hidMemType.equals("normal")) {%> checked="checked" <%}%>
									onclick="amountPay('normal')" />
							</div>


							<div class="form_row">
								<label class="contact"><strong>Premium:</strong> </label> <input
									class="" type="radio" name="membershipType" value="premium"
									<%if (hidMemType.equals("premium")) {%> checked="checked" <%}%>
									onclick="amountPay('premium')" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Membership Fees
										: </strong> </label> <input type="text" class="contact_input" name="amount"
									readonly="readonly" />
							</div>

							<div class="form_row">
								<label class=""><strong>Select the mode of
										payment:</strong> </label> <select onchange="modePay1()" name="mode"
									onblur="validateModePay()">
									<option value="0">--Select--</option>
									<option value="Credit Card">Credit Card</option>
									<option value="Debit Card">Debit Card</option>
									<option value="Cheque">Cheque</option>
									<option value="DD">DD</option>
								</select>
							</div>

							<%
								if (mode.equals("Credit Card") || mode.equals("Debit Card")) {
							%>
							<div class="form_row">
								<label class="contact"><strong>Card No:</strong> </label> <input
									type="text" class="contact_input" name="cardno"
									onkeyup="validateCN()" maxlength="16" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>CVV No:</strong> </label> <input
									type="text" class="contact_input" name="cvvno"
									onkeyup="validateCVV()" maxlength="3" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Name on Card: </strong> </label>
								<input type="text" name="cardName" class="contact_input"
									onkeyup="validateNAC()" maxlength="15" />
							</div>
							<%
								} else if (mode.equals("Cheque")) {
							%>
							<div class="form_row">
								<label class="contact"><strong>Cheque No :</strong> </label> <input
									type="text" class="contact_input" name="cheque_no"
									onkeyup="validateCheque()" maxlength="10" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Bank Name : </strong> </label> <input
									type="text" class="contact_input" name="bank_name"
									onkeyup="validateBank()" maxlength="15" />
							</div>
							<%
								} else if (mode.equals("DD")) {
							%>
							<div class="form_row">
								<label class="contact"><strong>Demand Draft No
										: </strong> </label> <input type="text" class="contact_input" name="dd_no"
									onkeyup="validateDD()" maxlength="5" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Bank Name : </strong> </label> <input
									type="text" class="contact_input" name="bank_name"
									onkeyup="validateBank()" maxlength="15" />
							</div>
							<%
								}
							%>

							<div class="form_row">
								<div class="terms">
									<input type="checkbox" name="terms" onchange="enabutton()"
										checked="checked" /> I agree to the <a href="jsp_tnc.jsp">terms
										&amp; conditions</a>
								</div>
							</div>


							<div class="form_row">
								<input type="button" class="register" value="register"
									name="sub" onclick="validateAll();"/>
							</div>
							<input type="hidden" name="pageOption" value="registrationForm">
								<input type="hidden" name="hidMemType" value="">
						</form>
					</div>
				</div>

				<div class="clear"></div>
			</div>
			<!--end of left content-->
			<jsp:include page="jsp_welcomeSidebar.jsp" />
			<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>