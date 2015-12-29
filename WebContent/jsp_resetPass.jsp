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
	String msg1 = request.getParameter("msg1") == null ? "" : request
			.getParameter("msg1");
%>
<body>
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
						<font color="red">
							<%
								//=msg
							%>
						</font>
					</h5>
					<div class="contact_form">
						<div class="form_subtitle">Reset Password</div>
						<form name="register" action="servlet_reset" method="get">
							<div class="form_row">
								<label class="contact"><strong>Enter Member Id:</strong>
								</label> <input type="text" class="contact_input" name="Member_Id" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Enter Password:</strong>
								</label> <input type="password" class="contact_input" name="password" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Confirm
										Password:</strong>
								</label> <input type="password" class="contact_input" name="password1" />
							</div>


							<%
								if (msg1.equals("Password Updated")) {
							%>
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
			<p><b><%=msg1%> </</b></p>
		</div>
							
								<%} %>

							<%
								}
							%>

							<div class="form_row">
								<input type="submit" class="register" value="Reset" />
							</div>
							<input type="hidden" name="pageOption" value="jsp_resetPass">
						</form>
					</div>
				</div>

				<div class="clear"></div>
			</div>
			<!--end of left content-->

			<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>
