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
		location.replace("excel_reportBookInfo.jsp");
	}
</script>
</head>

<%
	servlet_report amr = new servlet_report();
	amr.reportBookInfo();
	Vector bookId = amr.bookIdV;
	Vector bookName = amr.bookNameV;
	Vector authorName = amr.authorNameV;
	Vector bookQty = amr.bookQtyV;
	Vector bookPub = amr.bookPubV;
	Vector bookPubYear = amr.bookPubYearV;
	Vector bookPurDate = amr.bookPurDateV;
	Vector bookPages = amr.bookPagesV;
	String msg = request.getParameter("msg") == null ? "" : request
			.getParameter("msg");
%>
<%
	String libName = (String) session.getAttribute("Lib_Name") == null ? ""
			: (String) session.getAttribute("Lib_Name");
	if (libName.equals("")) {
		response.sendRedirect("jsp_libLogin.jsp");
	}
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
							alt="" title="" /> </span>List of Books
					</div>
					<!--  <div class="contact_form">-->
					<div class="form_subtitle">List of Books</div>

					<table align="center" class="cart_table1" border="1">
						<tr class="cart_title">

							<td><b>Book ID</b></td>
							<td><b>Book Name</b></td>
							<td><b>Author Name</b></td>
							<td><b>Book Quantity</b></td>
							<td><b>Publisher</b></td>
							<td><b>Publishing Year</b></td>
							<td><b>Purchase Date </b></td>
							<td><b>Book Pages</b></td>
						</tr>
						<%
							for (int i = 0; i < bookId.size(); i++) {
						%>
						<tr>
							<td><%=bookId.elementAt(i)%></td>
							<td><%=bookName.elementAt(i)%></td>
							<td><%=authorName.elementAt(i)%></td>
							<td><%=bookQty.elementAt(i)%></td>
							<td><%=bookPub.elementAt(i)%></td>
							<td><%=bookPubYear.elementAt(i)%></td>
							<td><%=bookPurDate.elementAt(i)%></td>
							<td><%=bookPages.elementAt(i)%></td>
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
		</div>

		<div class="clear"></div>
	
	<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>
