<%@page import="util.CharValidation"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<%
	String msg = request.getParameter("msg") == null ? "* fields are mandatory"
			: request.getParameter("msg");

int contactNoInt=0; 
String firstName = request.getParameter("firstName") == null ? ""
		: request.getParameter("firstName");
String middleName = request.getParameter("middleName") == null ? ""
		: request.getParameter("middleName");
String lastName = request.getParameter("lastName") == null ? ""
		: request.getParameter("lastName");
String password = request.getParameter("password") == null ? ""
		: request.getParameter("password");
String address = request.getParameter("address") == null ? "" : request
		.getParameter("address");
String emailId = request.getParameter("emailId") == null ? "" : request
		.getParameter("emailId");
String contactNo = request.getParameter("contactNo") == null ? ""
		: request.getParameter("contactNo");
String membershipType = request.getParameter("membershipType") == null ? ""
		: request.getParameter("membershipType");
String sec_que = request.getParameter("SecurityQuestion") == null ? ""
		: request.getParameter("SecurityQuestion");
String sec_que_ans = request.getParameter("sec_que_ans") == null ? ""
		: request.getParameter("sec_que_ans");
CharValidation cv = new CharValidation();

if (firstName.equals("")) {
	msg = "First Name cannot be blank !";
	response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
} else if (cv.validate(firstName)) {
	msg = "Invalid Character in First Name !";
	response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
}else if (password.equals("")) {
	msg = "password cannot be blank !";
	response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
}
else if (address.equals("")) {
	msg = "Address cannot be blank !";
	response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
} else if (emailId.equals("")) {
	msg = "Email ID cannot be blank !";
	response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
} else if (cv.validateEmail(emailId)) {
	msg = "Invalid Email ID !";
	response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
} else if (contactNo.equals("")) {
	msg = "Contact number cannot be blank !";
	response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
} else if (membershipType.equals("")) {
	msg = "Please select a Membership Type !";
	response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
}
//else if (sec_que_ans.equals("")) {
	//msg = "Answer field cannot be blank !";;
	//response.sendRedirect("jsp_registrationForm.jsp?msg=" + msg);
//}
else {
	try {
		contactNoInt = Integer.parseInt(contactNo);
	} catch (NumberFormatException Ne) {
		msg = "Contact number should be numeric !";
		
	}
	}
%>
<body>
<form action="servlet_payment">
<table background="Blue hills.jpg" align="center">
			<tr>
<td>Credit card:<input type="radio" name="paymode" value="creditcard"/><br>
</tr>
<tr>
<td>Debit Card:<input type="radio" name="paymode" value="debitcard"/><br>
</tr>
<tr>
<td>Enter the Card No:<input type="text" name="cardno"/><br>
</tr>
<tr>
<td>Enter cvvno:<input type="text" name="cvvno"/><br>
</tr>
<tr>
<td>Enter The Name on card:<input type="text" name="cardName"/><br>
</tr>
<tr>
<td>Enter the expiry date of the card:<select name="Expiry Date">

						<option value="0">--Select--</option>
						<option value="2012">2012</option>
						<option value="2013">2013</option>
						<option value="2014">2014</option>
						<option value="2015">2015</option>
						<option value="2016">2016</option></select>
						</td>
						
	<tr>
	<td>
		<input type="submit"  value=submit>
		
		</td>
	</tr>				
</table>
<h5>
			<font color="red"><%=msg%></font>
		</h5>
		<input type="hidden" name="firstNameHid" value="<%=firstName %>">
<input type="hidden" name="middleNameHid" value="<%=middleName %>">
<input type="hidden" name="lastNameHid" value="<%=lastName %>">
<input type="hidden" name="passwordHid" value="<%=password %>">
<input type="hidden" name="addressHid" value="<%=address %>">
<input type="hidden" name="emailIdHid" value="<%=emailId %>">
<input type="hidden" name="contactNoHid" value="<%=contactNo %>">
<input type="hidden" name="membershipTypeHid" value="<%=membershipType %>">
<input type="hidden" name="sec_queHid" value="<%=sec_que %>">
<input type="hidden" name="sec_que_ansHid" value="<%=sec_que_ans %>">
</form>
</body>
</html>