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
	function refresh() {
		issueReportType = document.forms[0].issueReportType.value;
		location.replace("jsp_reportBookIssue.jsp?issueReportType="
				+ issueReportType);
	}

	function refresh1() {
		month = document.forms[0].month.value;
		year = document.forms[0].year.value;
		issueReportType = document.forms[0].issueReportType.value;
		location.replace("jsp_reportBookIssue.jsp?issueReportType="
				+ issueReportType + "&month=" + month + "&year=" + year);
	}
	function refresh2() {

		year = document.forms[0].year.value;
		issueReportType = document.forms[0].issueReportType.value;
		location.replace("jsp_reportBookIssue.jsp?issueReportType="
				+ issueReportType + "&year=" + year);
	}

	function retainValues(issueReportType, month, year) {
		if (document.forms[0].month != null) {
			document.forms[0].month.value = month;
		}
		if (document.forms[0].year != null) {
			document.forms[0].year.value = year;
		}
		document.forms[0].issueReportType.value = issueReportType;

	}

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
		if (document.forms[0].issueReportType != null) {
			issueReportType = document.forms[0].issueReportType.value;
		} else {
			issueReportType = '';
		}

		location.replace("excel_reportBookIssue.jsp?issueReportType="
				+ issueReportType + "&month=" + month + "&year=" + year);
	}
</script>
<%
	String issueReportType = request.getParameter("issueReportType") == null ? "all"
			: request.getParameter("issueReportType");
	String month = request.getParameter("month") == null ? "JAN"
			: request.getParameter("month");
	String year = request.getParameter("year") == null ? "2012"
			: request.getParameter("year");
	servlet_report rpt = new servlet_report();
	rpt.setissueReportType(issueReportType);
	rpt.setMonth(month);
	rpt.setYear(year);
	rpt.getIssueReport();

	Vector bookIssueId = rpt.bookIssueIdV;
	Vector memId = rpt.memIdV4;
	Vector bookId = rpt.bookIdV4;
	Vector bookIssueDate = rpt.bookIssueDateV;
	Vector bookExpRetDate = rpt.bookExpRetDateV;
	Vector bookActRetDate = rpt.bookActRetDateV;
	Vector noOfDaysDues = rpt.noOfDaysDuesV;

	String msg = request.getParameter("msg") == null ? "" : request
			.getParameter("msg");
%>
</head>
<%
	String libName = (String) session.getAttribute("Lib_Name") == null ? ""
			: (String) session.getAttribute("Lib_Name");
	if (libName.equals("")) {
		response.sendRedirect("jsp_libLogin.jsp");
	}
%>
<body
	onload="retainValues('<%=issueReportType%>','<%=month%>','<%=year%>')">
	<div id="wrap">

		<jsp:include page="jsp_libWelcomeHeader.jsp" />


		<div class="center_content">
			<div class="left_content1">

				<div class="feat_prod_box_details">
					<p class="details"></p>
					<h5 align="center">
						<font color="red"><%=msg%></font>
					</h5>
					<div class="title" align="center">
						<span class="title_icon"><img src="images/bullet1.gif"
							alt="" title="" /> </span>List of Issued Books
					</div><br><br></br></br>
					<!--  <div class="contact_form">-->
					
					<form>
					
					
						<table align="center" class="cart_table1" border="1" >
							<tr class="cart_title1">

								<td colspan="3">Book issue report</td>
								<td colspan="4"><select name="issueReportType"
									onchange="refresh()">

										<option value="0">--Select--</option>

										<option value="monthwise">Month</option>

										<option value="yearwise">Year</option>

										<option value="bookidwise">Book Id</option>
										<option value="all">All</option>

								</select>
								</td>
							</tr>


							<%
								if (issueReportType.equals("monthwise")) {
							%>
							<tr>
								<td colspan="2">month<select name="month">
										<option value="0">--select --</option>
										<option value="JAN">JAN</option>
										<option value="FEB">FEB</option>
										<option value="MAR">MAR</option>
										<option value="APR">APR</option>
										<option value="MAY">MAY</option>
										<option value="JUN">JUN</option>
										<option value="JLY">JLY</option>
										<option value="AUG">AUG</option>
										<option value="SEP">SEP</option>
										<option value="OCT">OCT</option>
										<option value="NOV">NOV</option>
										<option value="DEC">DEC</option>
								</select>
								</td>
								<td colspan="2">year<select name="year">
										<option value="0">--select--</option>
										<option value="2012">2012</option>
										<option value="2011">2011</option>
										<option value="2010">2010</option>
										<option value="2009">2009</option>
										<option value="2008">2008</option>
								</select>
								</td>
								<td colspan="3"><input type="button" value="submit"
									onclick="refresh1()" class="register"></input></td>
							</tr>
							<tr>
								<td><b>Book Issue Id</b></td>
								<td><b>Member ID</b></td>
								<td><b>Book Id</b></td>
								<td><b>Book Issue Date</b></td>
								<td><b>Expected Return Date</b></td>
								<td><b>Actual Return Date</b></td>
								<td><b>No. of Days Overdue</b></td>
							</tr>
							<%
								for (int i = 0; i < bookIssueId.size(); i++) {
							%>
							<tr>
								<td><%=bookIssueId.elementAt(i)%></td>
								<td><%=memId.elementAt(i)%></td>
								<td><%=bookId.elementAt(i)%></td>
								<td><%=bookIssueDate.elementAt(i)%></td>
								<td><%=bookExpRetDate.elementAt(i)%></td>
								<td><%=bookActRetDate.elementAt(i)%></td>
								<td><%=noOfDaysDues.elementAt(i)%></td>
							</tr>
							<%
								}
							%>

							<%
								}
							%>

							<%
								if (issueReportType.equals("yearwise")) {
							%>
							<tr>

								<td colspan="4">year<select name="year">

										<option value="0">--select--</option>
										<option value="2012">2012</option>
										<option value="2011">2011</option>
										<option value="2010">2010</option>
										<option value="2009">2009</option>
										<option value="2008">2008</option>
								</select>
								</td>
								<td colspan="3"><input type="button" value="submit"
									onclick="refresh2()" class="register"></input>
								</td>
							</tr>
							<tr>
								<td><b>Book Issue Id</b></td>
								<td><b>Member ID</b></td>
								<td><b>Book Id</b></td>
								<td><b>Book Issue Date</b></td>
								<td><b>Expected Return Date</b></td>
								<td><b>Actual Return Date</b></td>
								<td><b>No. of Days Overdue</b></td>
							</tr>
							<%
								for (int i = 0; i < bookIssueId.size(); i++) {
							%>
							<tr>
								<td><%=bookIssueId.elementAt(i)%></td>
								<td><%=memId.elementAt(i)%></td>
								<td><%=bookId.elementAt(i)%></td>
								<td><%=bookIssueDate.elementAt(i)%></td>
								<td><%=bookExpRetDate.elementAt(i)%></td>
								<td><%=bookActRetDate.elementAt(i)%></td>
								<td><%=noOfDaysDues.elementAt(i)%></td>
							</tr>
							<%
								}
							%>

							<%
								}
							%>

							<%
								if (issueReportType.equals("bookidwise")) {
							%>

							<tr>
								<td><b>Book Issue Id</b></td>
								<td><b>Member ID</b></td>
								<td><b>Book Id</b></td>
								<td><b>Book Issue Date</b></td>
								<td><b>Expected Return Date</b></td>
								<td><b>Actual Return Date</b></td>
								<td><b>No. of Days Overdue</b></td>
							</tr>
							<%
								for (int i = 0; i < bookIssueId.size(); i++) {
							%>
							<tr>
								<td><%=bookId.elementAt(i)%></td>
								<td><%=bookIssueId.elementAt(i)%></td>
								<td><%=memId.elementAt(i)%></td>
								<td><%=bookIssueDate.elementAt(i)%></td>
								<td><%=bookExpRetDate.elementAt(i)%></td>
								<td><%=bookActRetDate.elementAt(i)%></td>
								<td><%=noOfDaysDues.elementAt(i)%></td>
							</tr>
							<%
								}
							%>

							<%
								}
							%>

							<%
								if (issueReportType.equals("all")) {
							%>

							<tr>

								<td><b>Book Issue Id</b></td>
								<td><b>Member ID</b></td>
								<td><b>Book Id</b></td>
								<td><b>Book Issue Date</b></td>
								<td><b>Expected Return Date</b></td>
								<td><b>Actual Return Date</b></td>
								<td><b>No. of Days Overdue</b></td>
							</tr>
							<%
								for (int i = 0; i < bookIssueId.size(); i++) {
							%>
							<tr>

								<td><%=bookIssueId.elementAt(i)%></td>
								<td><%=memId.elementAt(i)%></td>
								<td><%=bookId.elementAt(i)%></td>
								<td><%=bookIssueDate.elementAt(i)%></td>
								<td><%=bookExpRetDate.elementAt(i)%></td>
								<td><%=bookActRetDate.elementAt(i)%></td>
								<td><%=noOfDaysDues.elementAt(i)%></td>
							</tr>
							<%
								}
							%>

							<%
								}
							%>
						</table>
						<br>
						<div align="left"><input type="button" class="report_btn" value="Export To Excel"
						onclick="toExcel()" />
						<a href="jsp_libReportOptions.jsp" class="contact">Back</a>
						</div>
						
						
					</form>
				</div>
			</div>
			<div class="clear"></div>
		</div>
		<!--end of left content-->
		<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>
