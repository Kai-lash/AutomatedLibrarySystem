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
		if (document.forms[0].month != null) {
			month = document.forms[0].month.value;
		} else {
			month = '';
		}
		if (document.forms[0].year != null) {
			year = document.forms[0].year.value;
		} else {
			year = '';
		}
		if (document.forms[0].span != null) {
			span = document.forms[0].span.value;
		} else {
			span = '';
		}

		location.replace("excel_reportFineCollection.jsp?span=" + span
				+ "&month=" + month + "&year=" + year);
	}
	function refresh() {
		span = document.forms[0].span.value;
		location.replace("jsp_reportFineCollection.jsp?span=" + span);
	}

	function refresh1() {
		month = document.forms[0].month.value;
		span = document.forms[0].span.value;
		year = document.forms[0].year.value;
		location.replace("jsp_reportFineCollection.jsp?span=" + span
				+ "&month=" + month + "&year=" + year);
	}

	function refresh2() {
		span = document.forms[0].span.value;
		year = document.forms[0].year.value;
		location.replace("jsp_reportFineCollection.jsp?span=" + span + "&year="
				+ year + "&month=" + month + "&year=" + year);
	}
	function retainValues(span, month, year) {
		if (document.forms[0].month != null) {
			document.forms[0].month.value = month;
		}
		document.forms[0].span.value = span;

		document.forms[0].year.value = year;

	}
</script>
</head>

<%
	String msg = request.getParameter("msg") == null ? "" : request
			.getParameter("msg");
	String span = request.getParameter("span") == null ? "all"
			: request.getParameter("span");
	String month = request.getParameter("month") == null ? "JAN"
			: request.getParameter("month");
	String year = request.getParameter("year") == null ? "2012"
			: request.getParameter("year");
%>
<%
	servlet_report rpt = new servlet_report();
	rpt.setSpan6(span);
	rpt.setMemCollMonth6(month);
	rpt.setMemCollYear6(year);
	rpt.reportFineCollection();
	Vector memIdV1 = rpt.memIdV6;
	Vector memNameV1 = rpt.memNameV6;
	Vector memFeesTypeV1 = rpt.memFeesTypeV6;
	Vector memFeesV1 = rpt.memFeesV6;
	String memTotalCollection = rpt.memTotalCollection6==null?"0":rpt.memTotalCollection6;
%>

<body onload="retainValues('<%=span%>','<%=month%>','<%=year%>')">
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
					<h5 align="center">
						<font color="red"><%=msg%></font>
					</h5>
					<div class="title">
						<span class="title_icon"><img src="images/bullet1.gif"
							alt="" title="" /> </span>List of Fine Collection
					</div>

					<!--  <div class="contact_form">-->
					<div class="form_subtitle">List of Fine Collection</div>
					<form action="">
						<br></br>

						<table align="center" class="cart_table1" border="1">
							<tr class="cart_title">

								<td>Fine Collection report</td>
								<td colspan="2"><select name="span" onchange="refresh()">

										<option value="0">--Select--</option>

										<option value="monthwise">Month</option>

										<option value="yearwise">Year</option>

										<option value="all">All</option>

								</select></td>
							</tr>


							<%
								if (span.equals("monthwise")) {
							%>
							<tr>
								<td>Month<select name="month">
										<option value="0">--select --</option>
										<option value="JAN">JAN</option>
										<option value="FEB">FEB</option>
										<option value="MAR">MAR</option>
										<option value="APR">APR</option>
										<option value="MAY">MAY</option>
										<option value="JUN">JUN</option>
										<option value="JLY">JUL</option>
										<option value="AUG">AUG</option>
										<option value="SEP">SEP</option>
										<option value="OCT">OCT</option>
										<option value="NOV">NOV</option>
										<option value="DEC">DEC</option>
								</select></td>
								<td>Year<select name="year">
										<option value="0">--select--</option>
										<option value="2012">2012</option>
										<option value="2011">2011</option>
										<option value="2010">2010</option>
										<option value="2009">2009</option>
										<option value="2008">2008</option>
								</select></td>
								<td><input type="button" value="submit" class="register"
									onclick="refresh1()"></td>
							</tr>
							<tr bgcolor="gray">
								<td><b>Member ID</b></td>
								<td><b>Member Name</b></td>
								<td><b>Membership Fees</b></td>
							</tr>
							<%
								for (int i = 0; i < memIdV1.size(); i++) {
							%>
							<tr>
								<td><%=memIdV1.elementAt(i)%></td>
								<td><%=memNameV1.elementAt(i)%></td>
								<td><%=memFeesV1.elementAt(i)%></td>
							</tr>
							<%
								}
							%>
							<tr>
								<td colspan="2">Total</td>
								<td><%=memTotalCollection%></td>
							</tr>

							<%
								} else if (span.equals("yearwise")) {
							%>
							<tr>
								<td>Year<select name="year">
										<option value="0">--select--</option>
										<option value="2012">2012</option>
										<option value="2011">2011</option>
										<option value="2010">2010</option>
										<option value="2009">2009</option>
										<option value="2008">2008</option>
								</select></td>

								<td colspan="2"><input type="button" value="submit"
									class="register" onclick="refresh2()"></td>

							</tr>
							<tr bgcolor="gray">
								<td><b>Member ID</b></td>
								<td><b>Member Name</b></td>
								<td><b>Membership Fees</b></td>
							</tr>

							<%
								for (int i = 0; i < memIdV1.size(); i++) {
							%>
							<tr>
								<td><%=memIdV1.elementAt(i)%></td>
								<td><%=memNameV1.elementAt(i)%></td>
								<td><%=memFeesV1.elementAt(i)%></td>

							</tr>
							<%
								}
							%>
							<tr>
								<td colspan="2">Total</td>
								<td><%=memTotalCollection%></td>
							</tr>
							<%
								} else if (span.equals("all")) {
							%>

							<tr bgcolor="gray">

								<td><b>Member ID</b></td>
								<td><b>Member Name</b></td>
								<td><b>Membership Fees</b></td>
							</tr>
							<%
								for (int i = 0; i < memIdV1.size(); i++) {
							%>
							<tr>
								<td><%=memIdV1.elementAt(i)%></td>
								<td><%=memNameV1.elementAt(i)%></td>
								<td><%=memFeesV1.elementAt(i)%></td>
							</tr>
							<%
								}
							%>
							<tr>
								<td colspan="2">Total</td>
								<td><%=memTotalCollection%></td>
							</tr>
							<%
								}
							%>
						</table>
						<br>
							<div align="left">
								<input type="button" class="report_btn" value="Export To Excel"
									onclick="toExcel()" /> <a href="jsp_libReportOptions.jsp"
									class="contact">Back</a>
							</div>
					</form>

				</div>
			</div>
		</div>

		<div class="clear"></div>
		<jsp:include page="jsp_welcomeFooter.jsp" />
	</div>
</body>
</html>
