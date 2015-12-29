<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="book.servlet_bookRequest"%>
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
	servlet_bookRequest br = new servlet_bookRequest();
	br.requestStatus(request);

	Vector bookStatus = br.reqBookStatusV2;
	Vector bookName = br.reqBookNameV2;
	Vector authorName = br.reqAuthorNameV2;
	Vector requestId = br.requestIdV2;
%>


<body>
	<div id="wrap">

		<jsp:include page="jsp_memWelcomeHeader.jsp" />

		<div class="center_content">
			<div class="left_content">

				<div class="feat_prod_box_details">
					<p class="details"></p>
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
			<p><b><%=msg%> </</b></p>
		</div>
							
								<%} %>

					<div class="contact_form">
						<div class="form_subtitle">Book Request</div>


						<h5 align="center">
							<font color="red"> <%
 	//=sp.msg
 %>
							</font>
						</h5>
					</div>

				</div>

				<form action="servlet_bookRequest">
					<table align="center" class="cart_table" border="1">
						<tr class="cart_title">


							<td><b>Book Name</b></td>
							<td><input type="text" name="reqBookName" maxlength="30"></td>
						</tr>
						<tr>
							<td><b>Author</b></td>
							<td><input type="text" name="reqBookAuthor" maxlength="20"></td>
						</tr>
						<tr>
							<td><b>Publisher</b></td>
							<td><input type="text" name="reqBookPub" maxlength="20"></td>
						</tr>
						<tr>
							<td><b>Version</b></td>
							<td><input type="text" name="reqBookVersion" maxlength="10"></td>
						</tr>
						<tr>
							
							<td colspan="2"><input type="submit" value="Request" class="register"></td>
						</tr>
					</table>
					<input type="hidden" name="pageOption" value="newBookRequest"></input>

				</form>

				<h4 align="center">Previous Book Request</h4>

				<table align="center" class="cart_table" border="1">

					<%
						if (bookName.size() > 0) {
					%>
					<tr class="cart_title">
						<td><b>Request ID</b></td>
						<td><b>Book Name</b></td>
						<td><b>Author Name</b></td>
						<td><b>Status</b></td>

					</tr>
					<%
						for (int i = 0; i < bookName.size(); i++) {
					%>

					<tr>
						<td><%=requestId.elementAt(i)%></td>
						<td><%=bookName.elementAt(i)%></td>
						<td><%=authorName.elementAt(i)%></td>
						<td><%=bookStatus.elementAt(i)%></td>


					</tr>

					<%
						}
					%>
					<%
						} else {
					%>
						
		
	<br><br></br></br>
		<div class="ui-widget">
			<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
				<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
				<strong>Alert:</strong> No Request Made</p>
			</div>
		</div>

<br></br>

					<%
						}
					%>
				</table>

				<div class="clear"></div>
			</div>
			<!--end of left content-->

			<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>
