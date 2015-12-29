
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" errorPage="jsp_errorPageMem.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252" />
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<%
	String fname = (String) session.getAttribute("Member_Name") == null ? ""
			: (String) session.getAttribute("Member_Name");
	if (fname.equals("")) {
		response.sendRedirect("jsp_memlogin.jsp");
	}
%>

<%
	String msg = request.getParameter("msg") == null ? "" : request
			.getParameter("msg");
%>
<body>
	<div id="wrap">

		<jsp:include page="jsp_memWelcomeHeader.jsp" />

		<div class="center_content">
			<div class="left_content">

				<div class="title">
					<span class="title_icon"><img src="images/bullet1.gif"
						alt="" title="" />
					</span>Featured books
				</div>

				<div class="feat_prod_box">

					<div class="prod_img">
						<a href="#"><img src="images/prod1.gif" alt=""
							title="" border="0" />
						</a>
					</div>

					<div class="prod_det_box">
						<div class="box_top"></div>
						<div class="box_center">
						
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
			<p><b><%=msg%> <%=fname%></</b></p>
		</div>
							
								<%} %>
						
						
							<div class="prod_title">3 Mistakes Of My Life</div>
							<p class="details">Best Seller Book Of The Year By Chetan
								Bhagat.Chetan Bhagat is a famous youth writer who has written
								some more Best Sellers namely Five Point Someone and Two States.
							</p>
							<!--  <a href="details.html" class="more">- more details -</a> -->
							<div class="clear"></div>
						</div>

						<div class="box_bottom"></div>
					</div>
					<div class="clear"></div>
				</div>


				<div class="feat_prod_box">

					<div class="prod_img">
						<a href="#"><img src="images/get.gif" alt=""
							title="" border="0" />
						</a>
					</div>

					<div class="prod_det_box">
						<div class="box_top"></div>
						<div class="box_center">
							<div class="prod_title">Lost Symbol</div>
							<p class="details">The Mysterious story which is full of
								suspense in the very own style of Dan Brown. His story holds you
								up till the end and characters are described in his own
								narrative way.</p>
							<!-- <a href="details.html" class="more">- more details -</a> -->
							<div class="clear"></div>
						</div>

						<div class="box_bottom"></div>
					</div>
					<div class="clear"></div>
				</div>



				<div class="title">
					<span class="title_icon"><img src="images/bullet2.gif"
						alt="" title="" />
					</span>New books
				</div>

				<div class="new_products">

					<div class="new_prod_box">
						<a href="#">The Complete Reference:JAVA</a>
						<div class="new_prod_bg">
							<span class="new_icon"><img src="images/new_icon.gif"
								alt="" title="" />
							</span> <a href="#"><img src="images/java.gif" alt=""
								title="" class="thumb" border="0" />
							</a>
						</div>
					</div>

					<div class="new_prod_box">
						<a href="#">Let us C</a>
						<div class="new_prod_bg">
							<span class="new_icon"><img src="images/new_icon.gif"
								alt="" title="" />
							</span> <a href="#"><img src="images/letusc.gif" alt=""
								title="" class="thumb" border="0" />
							</a>
						</div>
					</div>

				</div>


				<div class="clear"></div>
			</div>
			<!--end of left content-->
			<jsp:include page="jsp_welcomeSidebar.jsp" />
			<jsp:include page="jsp_welcomeFooter.jsp" />
</body>
</html>
