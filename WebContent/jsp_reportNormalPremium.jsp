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
	function refresh(memType1) {
		//var memType1=document.forms[0].memType.value;
		//alert(memType1);
		location.replace("jsp_reportNormalPremium.jsp?memType=" + memType1);
	}

	function retainValues() {

	}

	function toExcel(memType) {

		alert(memType);
		location.replace("excel_reportNormalPremium.jsp?memType=" + memType);
	}
</script>
</head>

<%
	String memType = request.getParameter("memType") == null ? "all"
			: request.getParameter("memType");
	servlet_report rpt = new servlet_report();
	rpt.setMemType(memType);
	rpt.getNormalPremium();
	Vector memId = rpt.memId;
	Vector memName = rpt.memName;
	Vector cellNo = rpt.cellNo;
	Vector emailId = rpt.emailId;
	Vector membership = rpt.membership;
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

	<form>
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
							alt="" title="" /> </span>List of Normal/Premium members
					</div>
						<!--  <div class="contact_form">-->
						<div class="form_subtitle">List of Normal/Premium members</div>
						<br></br> <br></br><input type="radio" name="memType"
							value="normal" onclick="refresh('normal')"
							<%if (memType.equals("normal")) {%> checked="checked" <%}%>></input>Normal
						&nbsp;&nbsp;&nbsp; <input type="radio" name="memType"
							value="premium" onclick="refresh('premium')"
							<%if (memType.equals("premium")) {%> checked="checked" <%}%>></input>Premium
						<table align="center" class="cart_table1" border="1">
							<tr class="cart_title">

								<td><b>Member Name</b></td>
								<td><b>Member ID</b></td>
								<td><b>Email ID</b></td>
								<td><b>Contact No.</b></td>
								<td><b>Membership Type</b></td>
							</tr>
							<%
								for (int i = 0; i < memId.size(); i++) {
							%>
							<tr>
								<td><%=memName.elementAt(i)%></td>
								<td><%=memId.elementAt(i)%></td>
								<td><%=emailId.elementAt(i)%></td>
								<td><%=cellNo.elementAt(i)%></td>
								<td><%=membership.elementAt(i)%></td>
							</tr>
							<%
								}
							%>
						</table>
						<br>
						<div align="left"><input type="button" class="report_btn" value="Export To Excel"
						onclick="toExcel()" />
						<a href="jsp_libReportOptions.jsp" class="contact">Back</a>
						</div></div>
			</div>
			<div class="clear"></div>
			<jsp:include page="jsp_welcomeFooter.jsp" />
		</div>
		<!--end of left content-->	</form>
</body>
</html>
