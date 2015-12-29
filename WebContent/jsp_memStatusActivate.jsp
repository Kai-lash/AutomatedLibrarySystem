<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Vector"%>
<%@page import="login.servlet_memberRegistration"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="java.util.Vector" errorPage="jsp_errorPageLib.jsp"%>
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252" />
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script type="text/javascript">
function setVal(a) {
		document.forms[0].memId.value=a;
		document.forms[0].submit();
	}
</script>

</head>
<%
	String libName = (String) session.getAttribute("Lib_Name") == null ? ""
			: (String) session.getAttribute("Lib_Name");
	if (libName.equals("")) {
		response.sendRedirect("jsp_libLogin.jsp");
	}
%>
<%
	String msg = request.getParameter("msg") == null ? "" : request
			.getParameter("msg");
%>
<%
	servlet_memberRegistration amr = new servlet_memberRegistration();
	amr.memActivateList();
	Vector memId = amr.memId;
	Vector memName = amr.memName;
%>
<body>
	<div id="wrap">
	<jsp:include page="jsp_libWelcomeHeader.jsp" />


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

					<div class="title">
						<span class="title_icon"><img src="images/bullet1.gif"
							alt="" title="" /> </span>Pending Member Request
					</div><br />
					<!-- <div class="contact_form"> -->
					<form action="servlet_memberRegistration"><br />
					<div class="form_subtitle">Pending Member Request</div>
					
					
					
						<table  align="center" border="1" class="cart_table">
							<tr class="cart_title">

								<td>Member Name</td>
								<td>Membership ID</td>
								<td>Action</td>
							</tr>

							<%
								for (int i = 0; i < memId.size(); i++) {
							%>
							<tr>
								<td><%=memName.elementAt(i)%></td>
								<td><%=memId.elementAt(i)%></td>
								
									<td align="center"><input type="button" value="Activate" class="register" onclick="setVal('<%=memId.elementAt(i)%>')">
								</td>
							</tr>

							<%
								}
							%>
						</table>
						<input type="hidden" name="memId"
									value="">
						<%if(memId.size()==0){ %>
						
		<div class="ui-widget">
			<div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
				<p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
				<strong>No Pending Request.</p>
			</div>
		</div>
						
						<%} %>
						<input type="hidden" name="pageOption" value="memActivate">
					</form>
				</div>
			</div>
		</div>

		<div class="clear"></div>
	
	<jsp:include page="jsp_welcomeFooter.jsp" />
		</body>
</html>
