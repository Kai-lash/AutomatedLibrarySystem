<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@page import="java.util.Vector" errorPage="jsp_errorPage.jsp"%>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252" />
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script type="text/javascript">
	function retainVal(Lib_ID, password) {
		document.forms[0].loginId.value = Lib_ID;
		document.forms[0].password.value = password;
	}
</script>
</head>
<%
	String msg = request.getParameter("msg") == null ? "" : request
			.getParameter("msg");
	Cookie[] ck = request.getCookies();
	String Lib_ID = "";
	String password = "";
	for (int i = 0; i < ck.length; i++) {
		if (ck[i].getName().equals("Lib_ID")) {

			Lib_ID = ck[i].getValue();

		} else if (ck[i].getName().equals("passwordLib")) {

			password = ck[i].getValue();

		}
	}
%>
<body onload="retainVal('<%=Lib_ID%>','<%=password%>')">
	<div id="wrap">

		<jsp:include page="jsp_welcomeHeader.jsp" />

		<div class="center_content">
			<div class="left_content">
				<div class="title">
					<span class="title_icon"><img src="images/bullet1.gif"
						alt="" title="" />
					</span>Librarian Account
				</div>

				<div class="feat_prod_box_details">
					<p class="details"></p>
					<h5 align="center">
						<font color="red"><%=msg%></font>
					</h5>
					<div class="contact_form">
						<div class="form_subtitle">Login into your account</div>
						<form name="register" action="servlet_login" method="get">
							<div class="form_row">
								<label class="contact"><strong>Username:</strong>
								</label> <input type="text" class="contact_input" name="loginId" />
							</div>


							<div class="form_row">
								<label class="contact"><strong>Password:</strong>
								</label> <input type="password" class="contact_input" name="password" />
							</div>

							<div class="form_row">
								<div class="terms">
									<input type="checkbox" name="remember" value="yes"
										checked="checked" /> Remember me
								</div>
							</div>


							<div class="form_row">
								<input type="submit" class="register" value="login" />
							</div>
							<input type="hidden" name="pageOption" value="libLogin">
						</form>

					</div>

				</div>






				<div class="clear"></div>
			</div>
			<!--end of left content-->
			<%response.sendRedirect("jsp_memlogin.jsp") ;%>
			<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>
