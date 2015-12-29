<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252" />
<title>Book Store</title>
<%@page import="java.util.Vector" errorPage="jsp_errorPageLib.jsp"%>
<link rel="stylesheet" type="text/css" href="style.css" />

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
<body>
	<div id="wrap">

		<jsp:include page="jsp_libWelcomeHeader.jsp" />
<script type="text/javascript">
$(function(){

	// Accordion
	$("#accordion").accordion({ header: "h3" });

});


	</script>

		<div class="center_content">
			<div class="left_content">

				<div class="feat_prod_box_details">
					<p class="details"></p>
					<h5 align="center">
						<font color="red"><%=msg%></font>
					</h5>
					<div class="title">
						<span class="title_icon"><img src="images/bullet1.gif"
							alt="" title="" />
						</span>Reports
					</div>
					<!--  <div class="contact_form">-->
					<div class="form_subtitle">Reports</div>

<br></br><br></br>
<div id="accordion">
			<div>
				<h3><a href="jsp_reportBookRequest.jsp">New Book Request</a></h3>
				<div>This report shows the details of the new book requested by the members.
				<a href="jsp_reportBookRequest.jsp" class="contact">View</a>
				</div>
			</div>
			<div>
				<h3><a href="jsp_reportBookIssue.jsp">Book Issue Report</a></h3>
				<div>This report shows the details of the book issued or returned by the members.
				<a href="jsp_reportBookIssue.jsp" class="contact">View</a>
				</div>
			</div>
			<div>
				<h3><a href="jsp_reportBookInfo.jsp">Book Information</a></h3>
				<div>This report shows the details of all the books present in the library.
				<a href="jsp_reportBookInfo.jsp" class="contact">View</a>
				</div>
			</div>
			<div>
				<h3><a href="jsp_reportActiveMember.jsp">Active members</a></h3>
				<div>This report shows the details of all the active members of the library.
				<a href="jsp_reportActiveMember.jsp" class="contact">View</a>
				</div>
			</div>
			<div>
				<h3><a href="jsp_reportInactiveMember.jsp">Inactive members</a></h3>
				<div>This report shows the details of all the inactive members or members who are yet to be activated.
				<a href="jsp_reportInactiveMember.jsp" class="contact">View</a>
				</div>
			</div>
			<div>
				<h3><a href="jsp_reportNormalPremium.jsp">Normal/Premium Member</a></h3>
				<div>This report shows the details of members with Normal or Premium Membership type.
				<a href="jsp_reportNormalPremium.jsp" class="contact">View</a>
				</div>
			</div>
			<div>
				<h3><a href="jsp_reportMemCollection.jsp">Membership Collection</a></h3>
				<div>This report shows the details of the total amount collected Membership fees on monthly/yearly basis.
				<a href="jsp_reportMemCollection.jsp" class="contact">View</a>
				</div>
			</div>
			<div>
				<h3><a href="jsp_reportFineCollection.jsp">Fine Collection</a></h3>
				<div>This report shows the details of the total amount collected Book fines on monthly/yearly basis
				<a href="jsp_reportFineCollection.jsp" class="contact">View</a>
				</div>
			</div>
		</div>
</div>
</div>

				</div>

				<div class="clear"></div>
			
			<!--end of left content-->

			<jsp:include page="jsp_welcomeFooter.jsp" /></div>
</body>
</html>
