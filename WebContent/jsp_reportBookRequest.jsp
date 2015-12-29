<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Vector"%>
<%@page import="book.servlet_bookRequest"
	errorPage="jsp_errorPageLib.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252" />
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script type="text/javascript">
	function toExcel() {
		location.replace("excel_reportBookRequest.jsp");
	}
	function setVal(a,b) {
		document.forms[0].memId.value=a;
		document.forms[0].requestId.value=b;
		document.forms[0].submit();
	}

</script>
</head>

<%
	servlet_bookRequest amr = new servlet_bookRequest();
	amr.reportBookRequest();
	Vector memId = amr.memIdV;
	Vector memName = amr.memNameV;
	Vector bookName = amr.bookNameV;
	Vector authorName = amr.authorNameV;
	Vector requestId = amr.requestIdV;

	String msg = request.getParameter("msg") == null ? "" : request
			.getParameter("msg");
%>
<body>
	<%
		String libName = (String) session.getAttribute("Lib_Name") == null ? ""
				: (String) session.getAttribute("Lib_Name");
		if (libName.equals("")) {
			response.sendRedirect("jsp_libLogin.jsp");
		}
	%>
	<div id="wrap">

		<jsp:include page="jsp_libWelcomeHeader.jsp" />

		<div class="center_content">
			<div class="left_content">

				<div class="feat_prod_box_details">
					<p class="details"></p>
										<div class="title">
						<span class="title_icon"><img src="images/bullet1.gif"
							alt="" title="" /> </span>List of Requested Books
					</div><br><br></br></br>
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
					<!--  <div class="contact_form">-->
					<form action="servlet_bookRequest">
						
						<table align="center" class="cart_table1" border="1">
							<tr class="cart_title">
								<td><b>Member ID</b></td>
								<td><b>Member Name</b></td>
								<td><b>Book Name</b></td>
								<td><b>Author Name</b></td>
								<td><b>Request Id</b></td>
								<td><b>Action</b></td>
							</tr>

							<%
								for (int i = 0; i < memId.size(); i++) {
							%>
							<tr>
								<td align="left"><%=memId.elementAt(i)%></td>
								<td><%=memName.elementAt(i)%></td>
								<td><%=bookName.elementAt(i)%></td>
								<td><%=authorName.elementAt(i)%></td>
								<td><%=requestId.elementAt(i)%></td>
								<td><input class="register" type="button" value="Approve" onclick="setVal('<%=memId.elementAt(i)%>','<%=requestId.elementAt(i)%>')"></input>
								</td>
								
							</tr>

							<%
								}
							%>
							</table>
							
							<input type="hidden" name="memId"
									value=""/>
								<input type="hidden" name="requestId"
									value=""/>
							
							<%if(memId.size()==0){ %>
						<h3 align="center">
						<font color="blue" face="calibri">No pending Request!!</font>
					</h3>
						
						<%}else { %>
							<br>
						<div align="left"><input type="button" class="report_btn" value="Export To Excel"
						onclick="toExcel()" />
						<a href="jsp_libReportOptions.jsp" class="contact">Back</a>
						</div>							<input type="hidden" name="pageOption"
								value="jsp_reportBookRequest"/>
							<%} %>
														
					</form>
					
				</div>
			</div>
			<div class="clear"></div>
		</div>
		<!--end of left content-->
		<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>
