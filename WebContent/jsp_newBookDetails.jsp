<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="book.servlet_newBookDetails"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@page import="java.util.Vector" errorPage="jsp_errorPageLib.jsp"%>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252" />
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script type="text/javascript">

var fname = /^[A-Za-z]+$/;

var contact = /^[0-9]+$/;

var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

var reg1 = /^([A-Za-z0-9_\-\.])+\@([A-Za-z])+\.([A-Za-z]{2,4})$/;


function validateBname() {

	if (document.forms[0].bookName.value == '') {
		alert('Book Name can not be Empty');
	} else if (!document.forms[0].bookName.value.match(fname)) {
		alert('Invalid Characters in Book Name!');
		document.forms[0].bookName.value = '';
	}
}
function validateAname() {

	if (document.forms[0].authorName.value == '') {
		alert('Author Name can not be Empty');
	} else if (!document.forms[0].authorName.value.match(fname)) {
		alert('Invalid Characters in Author Name!');
		document.forms[0].authorName.value = '';
	}
}
function validatePname() {

	if (document.forms[0].publisherName.value == '') {
		alert('Publisher Name can not be Empty');
	} else if (!document.forms[0].publisherName.value.match(fname)) {
		alert('Invalid Characters in  Publisher Name!');
		document.forms[0].publisherName.value = '';
	}
}


function validateVersion() {

	if (document.forms[0].version.value == '') {
		alert('Version cannot be Empty');
	} else if (!document.forms[0].version.value.match(contact)) {
		alert('Version number should contain numeric values only');
		document.forms[0].version.value = '';
	}
}
function validatePages() {

	if (document.forms[0].pages.value == '') {
		alert('Pages field cannot be Empty');
	} else if (!document.forms[0].pages.value.match(contact)) {
		alert('Page number should contain numeric values only');
		document.forms[0].pages.value = '';
	}
}
function validateCopies() {

	if (document.forms[0].copies.value == '') {
		alert('Copies cannot be Empty');
	} else if (!document.forms[0].copies.value.match(contact)) {
		alert('Copies number should contain numeric values only');
		document.forms[0].copies.value = '';
	}
}

function validateAll(){
	var flag=false;
	var elem=document.forms[0].elements;
	for(var i=0;i<elem.length;i++){
		if(elem[i]!=null){
			if(elem[i].value=='' && (elem[i]!=document.forms[0].version && elem[i]!=document.forms[0].pages)){
				flag=true;
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
				break;
			}
		}
	}
	if(flag==false){
		document.forms[0].submit();
	}
}


	function changeOpt(bookOption) {
		location.replace("jsp_newBookDetails.jsp?bookOption=" + bookOption);
	}
	function ref2(bookOption) {

		deleteBookId = document.forms[0].deleteBookId.value;
		location.replace("jsp_newBookDetails.jsp?bookOption=" + bookOption
			+ "&deleteBookId=" + deleteBookId);
	}
	
	function retainValues(deleteBookId) {
		if (document.forms[0].deleteBookId != null) {
			document.forms[0].deleteBookId.value = deleteBookId;
		}

	}
	
	function validate() {
		if (document.forms[0].deleteBookId.value=='' || document.forms[0].deleteBookCopyId.value=='') {
			alert('Please select both the fields!!');
		}
		else{
			document.forms[0].submit();
		}

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
	String bookOption = request.getParameter("bookOption") == null ? "add"
			: request.getParameter("bookOption");
	String deleteBookId = request.getParameter("deleteBookId") == null ? ""
			: request.getParameter("deleteBookId");
	String deleteBookCopyId = request.getParameter("deleteBookCopyId") == null ? ""
			: request.getParameter("deleteBookCopyId");

	Vector deleteBookIdV = null;
	Vector deleteBookCopyIdV = null;
	if (bookOption.equals("delete")) {
		servlet_newBookDetails sb = new servlet_newBookDetails();
		sb.deleteBookId = deleteBookId;
		sb.deleteBookCopyId = deleteBookCopyId;
		sb.deleteBookDetails();
		deleteBookIdV = sb.deleteBookIdV;
		deleteBookCopyIdV = sb.deleteBookCopyIdV;

	}
%>
<body onload="retainValues('<%=deleteBookId%>')">
	<div id="wrap">
		<jsp:include page="jsp_libWelcomeHeader.jsp" />


		<div class="center_content">
			<div class="left_content">

				<div class="feat_prod_box_details">
					<p class="details"></p>
					<div id="dialog" title="Alert!">
			<p><font color="red">* Marked fields are mandatory !!</font></p>
		</div>
					
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
					<input type="radio" name="bookOption" value="add"
						<%if (bookOption.equals("add")) {%> checked="checked" <%}%>
						onclick="changeOpt('add')" />Add Books&nbsp;&nbsp;&nbsp;&nbsp; <input
						type="radio" name="bookOption" value="add"
						<%if (bookOption.equals("delete")) {%> checked="checked" <%}%>
						onclick="changeOpt('delete')" />Delete Books
					<div class="contact_form">
						<form name="register" action="servlet_newBookDetails" method="get">
							<%
								if (bookOption.equals("add")) {
							%>
							<div class="form_subtitle">New Book Details</div>
							


							<div class="form_row">
								<label class="contact"><strong>Book Name*:</strong> </label> <input
									type="text" class="contact_input" name="bookName" onkeyup="validateBname()"
									maxlength="25" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Version :</strong> </label> <input
									type="text" class="contact_input" name="version" maxlength="10" onkeyup="validateVersion()" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Author Name*:</strong> </label> <input
									type="text" class="contact_input" name="authorName" onkeyup="validateAname()"
									maxlength="15" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Publisher Name*:</strong>
								</label> <input type="text" class="contact_input" name="publisherName" onkeyup="validatePname()"
									maxlength="15" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Publishing
										Year*:</strong> </label> <select name="publishYear">
									<option value="2012">2012</option>
									<%
										for (int i = 1980; i < 2012; i++) {
									%>
									<option value="<%=i%>"><%=i%></option>
									<%
										}
									%>

								</select>
							</div>
							<div class="form_row">
								<label class="contact"><strong> Category*:</strong> </label> <select
									name="category">
									<option value="">--Select--</option>
									<option value="FICTION">Fiction</option>
									<option value="NON FICTION">Non Fiction</option>
									<option value="TECHNICAL">Technical</option>
								</select>
							</div>

							<div class="form_row">
								<label class="contact"><strong>Number of Pages:</strong>
								</label> <input type="text" class="contact_input" name="pages" onkeyup="validatePages()"
									maxlength="4" />
							</div>

							<div class="form_row">
								<label class="contact"><strong>Number of
										Copies*:</strong> </label> <input type="text" class="contact_input" onkeyup="validateCopies()"
									name="copies" maxlength="4" />
							</div>


							<div class="form_row">
								<input type="button" class="register" onclick="validateAll()" value="Add" />
							</div>
							
							<%
								} else if (bookOption.equals("delete")) {
							%>
							<input type="hidden" name="bookOptionHid" value="delete"/>
							<div class="form_subtitle">Delete Books</div>
							<div class="form_row">
								<label class="contact"><strong>Select Book ID*:</strong>
								</label> <select name="deleteBookId" onchange="ref2('delete')">
									<option value="">--Select--</option>
									<%
										for (int i = 0; i < deleteBookIdV.size(); i++) {
									%>
									<option value="<%=deleteBookIdV.elementAt(i)%>"><%=deleteBookIdV.elementAt(i)%></option>
									<%
										}
									%>

								</select>
							</div>

							<div class="form_row">
								<label class="contact"><strong>Select Book Copy
										ID*:</strong> </label> <select name="deleteBookCopyId">
									<option value="">--Select--</option>
									<%
										for (int i = 0; i < deleteBookCopyIdV.size(); i++) {
									%>
									<option value="<%=deleteBookCopyIdV.elementAt(i)%>"><%=deleteBookCopyIdV.elementAt(i)%></option>
									<%
										}
									%>

								</select>
							</div>
							<div class="form_row">
								<input type="button" class="register" value="Delete" onclick="validate()"/>
							</div>


							<%
								}
							%>
							<input type="hidden" name="pageOption" value="newBookDetails" />
						</form>
					</div>
				</div>

				<div class="clear"></div>
			</div>
			<!--end of left content-->

			<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>
