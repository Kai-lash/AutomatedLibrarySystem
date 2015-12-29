<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="book.servlet_bookReturn"%>
<%@page import="book.servlet_bookSearch"
	%>
<%@page import="java.util.Vector" errorPage="jsp_errorPageMem.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252" />
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script type="text/javascript">
function setVal(a) {
		document.forms[0].Return.value = a;
		document.forms[0].submit();
	}
</script>
</head>
<%
	String fname = (String) session.getAttribute("Member_Name") == null ? ""
			: (String) session.getAttribute("Member_Name");
	if (fname.equals("")) {
		response.sendRedirect("jsp_memlogin.jsp");
	}
	String msg = request.getParameter("msg") == null ? "" : request.getParameter("msg");

	servlet_bookReturn sbr = new servlet_bookReturn();
	//sbr.returnUpdate(request, response);
	sbr.bookReturn(request, response);

	Vector book_Id = sbr.book_IdV;
	Vector book_Name = sbr.book_NameV;
	Vector book_Author = sbr.book_AuthorV;
	Vector book_issueDate = sbr.book_issueDateV;
	Vector book_ExpReturnDate = sbr.book_ExpReturnDateV;
	Vector no_Overdue = sbr.no_OverdueV;
	Vector book_Fine = sbr.book_FineV;
%>

<%
	String searchBy = request.getParameter("searchBy") == null ? ""
			: request.getParameter("searchBy");
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
						<div class="form_subtitle">Books To be Returned</div>

					</div>
				</div>

				<form action="servlet_bookReturn">
					<table align="center" class="cart_table1" border="1">
						<tr class="cart_title">

							<td>Book Name</td>
							<td>Author</td>
							<td>Book IssueDate</td>
							<td>Exp. ReturnDate</td>
							<td>Overdue</td>
							<td>Fine</td>
							<td>Select</td>
						</tr>

						<%
							for (int i = 0; i < book_Name.size(); i++) {
						%>
						<tr>

							<td><%=book_Name.elementAt(i)%></td>
							<td><%=book_Author.elementAt(i)%></td>
							<td><%=book_issueDate.elementAt(i)%></td>
							<td><%=book_ExpReturnDate.elementAt(i)%></td>
							<td><%=no_Overdue.elementAt(i)%></td>
							<td><%=book_Fine.elementAt(i)%></td>

							<td><input type="button" name="ReturnBtn" value="Return" class="register" onclick="setVal('<%=book_Id.elementAt(i)%>')"></input>
								
							</td>
							
						</tr>

						<%
							}
						%>
							<input type="hidden" name="Return" value="">
						<input type="hidden" name="pageOption" value="bookReturn"></input>
					</table>
					<%
						//=sbr.msg
					%>
				</form>

				<div class="clear"></div>
			</div>
			<!--end of left content-->

			<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>
