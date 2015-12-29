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
%>
<body onload="retainVal('<%=Member_Id%>','<%=password%>')">
	<div id="wrap">

		<jsp:include page="jsp_welcomeHeader.jsp" />


		<div class="center_content">
			<div class="left_content">
				<div class="title">
					<span class="title_icon"><img src="images/bullet1.gif"
						alt="" title="" /> </span>My Account
				</div>

				<div class="feat_prod_box_details">
					<p class="details"></p>
						<%if(!msg.equals("")){ %>
		
	
		<div class="ui-widget">
			<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
				<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
				<strong>Alert:</strong> <%=msg %></p>
			</div>
		</div>

<br></br>
<%} %>
					<div class="contact_form">
						<div class="form_subtitle">Login into your account</div>
						<form name="register" action="servlet_login" method="post">
							<input type="radio" name="loginOption" value="member" checked="checked"/>Member
							&nbsp;&nbsp; &nbsp; &nbsp; <input type="radio" name="loginOption"
								value="librarian" />Librarian</br></br>
							<div class="form_row">
								<label class="contact"><strong>Username:</strong> </label> <input
									type="text" class="contact_input" name="loginId" maxlength="10" />
							</div>


							<div class="form_row">
								<label class="contact"><strong>Password:</strong> </label> <input
									type="password" class="contact_input" name="password"
									maxlength="15" />
							</div>

							<div class="form_row">
								<div class="terms">
									<input type="checkbox" name="remember" value="yes"
										 /> Remember me
								</div>
							</div>


							<div class="form_row">
								<input type="submit" class="register" value="login" />
							</div>
							<input type="hidden" name="pageOption" value="memLogin"></input>
							<a href="jsp_forgotPass.jsp">Forgot Password?</a>
						</form>

					</div>



					<div class="clear"></div>
				</div>
			</div>

			<!--end of left content-->
			<jsp:include page="jsp_welcomeSidebar.jsp" />
			<jsp:include page="jsp_welcomeFooter.jsp" />
		</div>
</body>
</html>
