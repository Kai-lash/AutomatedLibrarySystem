<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@page import="java.util.Vector" errorPage="jsp_errorPage.jsp"%>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252" />
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script type="text/javascript">
	function retainVal(Member_Id, password) {
		document.forms[0].loginId.value = Member_Id;
		document.forms[0].password.value = password;
	}
</script>
</head>
<%
	String msg = request.getParameter("msg") == null ? "" : request
			.getParameter("msg");
	Cookie[] ck = request.getCookies();
	String Member_Id = "";
	String password = "";
	for (int i = 0; i < ck.length; i++) {
		if (ck[i].getName().equals("Member_Id")) {

			Member_Id = ck[i].getValue();

		} else if (ck[i].getName().equals("password")) {

			password = ck[i].getValue();

		}
	}

	String msg1 = request.getParameter("msg1") == null ? "" : request
			.getParameter("msg1");
%>
<body onload="retainVal('<%=Member_Id%>','<%=password%>')">
	<div id="wrap">

		<jsp:include page="jsp_welcomeHeader.jsp" />


		<div class="center_content">
			<div class="left_content">
				<div class="title">
					<span class="title_icon"><img src="images/bullet1.gif"
						alt="" title="" />
					</span>My account
				</div>

				<div class="feat_prod_box_details">
					<p class="details"></p>
					<h5 align="center">
						<font color="red"><%=msg%></font>
					</h5>
					<div class="contact_form">
						<div class="form_subtitle">Forgot Password?</div>
						<form name="register" action="servlet_reset" method="get">
							<div class="form_row">
								<label class="contact"><strong>Enter Member Id:</strong>
								</label> <input type="text" class="contact_input" name="Member_Id" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Select Security
										Question:</strong>
								</label> <select name="SecurityQuestion">
									<option value="0">--Select--</option>
									<option value="pet_name">What is your pet's name ?</option>
									<option value="birth_place">What is your Birth Place ?</option>
									<option value="school_name">What is your School Name ?</option>

								</select>
							</div>

							<div class="form_row">
								<label class="contact"><strong>Enter Answer:</strong>
								</label> <input type="text" class="contact_input" name="Answer" />
							</div>

							<%
								if (msg1.equals("Valid Member")) {
							%>
							<a href="jsp_resetPass.jsp">Reset Password</a>
							<%
								}
								if (msg1.equals("no matching data")) {
							%>
								<%if(!msg1.equals("")){ %>
		
	<br><br></br></br>
		<div class="ui-widget">
			<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
				<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
				<strong>Alert:</strong> No Matching Data Found!!</p>
			</div>
		</div>

<br></br>
<%} %>

							<%
								}
							%>


							<div class="form_row">
								<input type="submit" class="register" value="Submit" />
							</div>
							<input type="hidden" name="pageOption" value="jsp_forgotPass">
						</form>

					</div>

				</div>






				<div class="clear"></div>
			</div>
			<!--end of left content-->

			<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>
