<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="report.servlet_report"%>
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
		location.replace("excel_reportActiveMember.jsp");
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
	servlet_report amr = new servlet_report();
	amr.reportActiveMem();
	Vector memId = amr.memIdV;
	Vector memPwd = amr.memPwdV;
	Vector memFname = amr.memFnameV;
	Vector memMname = amr.memMnameV;
	Vector memLname = amr.memLnameV;
	Vector memAddress = amr.memAddressV;
	Vector memEmailId = amr.memEmailIdV;
	Vector memCellNo = amr.memCellNoV;
	Vector memType = amr.memTypeV;
	Vector memStatus = amr.memStatusV;
	Vector memRegDate = amr.memRegDateV;
	String msg = request.getParameter("msg") == null ? "" : request
			.getParameter("msg");
%>
<body>
	<div id="wrap">

		<jsp:include page="jsp_libWelcomeHeader.jsp" />


		<div class="center_content">
			<div class="left_content">
				
				<div class="feat_prod_box_details">
					<p class="details"></p>
					<h5 align="center">
						<font color="red"><%=msg%></font>
					</h5>
					<div class="title">
						<span class="title_icon"><img src="images/bullet1.gif"
							alt="" title="" /> </span>List of Active members
					</div>
					<!--  <div class="contact_form">-->
					<div class="form_subtitle">List of Active members</div>
					
					<table align="center" class="cart_table1" border="1">
						<tr class="cart_title">

							<td><b>Member Id</b></td>
							<td><b>Member Firstname</b></td>
							<td><b>Member Lastname</b></td>
							<td><b>Email Id</b></td>
							<td><b>Cell No.</b></td>
							<td><b>Membership Type</b></td>
							<td><b>Status</b></td>
							<td><b>Registration Date</b></td>
						</tr>
						<%
							for (int i = 0; i < memId.size(); i++) {
						%>
						<tr>
							<td><%=memId.elementAt(i)%></td>
							<td><%=memFname.elementAt(i)%></td>
							<td><%=memLname.elementAt(i)%></td>
							<td><%=memEmailId.elementAt(i)%></td>
							<td><%=memCellNo.elementAt(i)%></td>
							<td><%=memType.elementAt(i)%></td>
							<td><%=memStatus.elementAt(i)%></td>
							<td><%=memRegDate.elementAt(i)%></td>
						</tr>
						<%
							}
						%>
					</table>
					<br>
						<div align="left"><input type="button" class="report_btn" value="Export To Excel"
						onclick="toExcel()" />
						<a href="jsp_libReportOptions.jsp" class="contact">Back</a>
						</div>					
				</div>
			</div>
			<div class="clear"></div>
			<jsp:include page="jsp_welcomeFooter.jsp" />
		</div>
		<!--end of left content--></body>
</html>
