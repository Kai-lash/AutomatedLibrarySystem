<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252" />
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script type="text/javascript">

var fname = /^[A-Za-z]+$/;

var contact = /^[0-9]+$/;

var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

var reg1 = /^([A-Za-z0-9_\-\.])+\@([A-Za-z])+\.([A-Za-z]{2,4})$/;

function validateFname() {

	if (document.forms[0].firstName.value == '') {
		alert('Name can not be Empty');
	} else if (!document.forms[0].firstName.value.match(fname)) {
		alert('Invalid Characters in Name!');
		document.forms[0].firstName.value = '';
	}
}

function validateEmail() {
	if (document.forms[0].emailId.value == '') {
		alert('Email Id cannot be Empty');
	} else if (!document.forms[0].emailId.value.match(reg)) {
		alert('Invalid Email Id!');
		document.forms[0].emailId.value = '';
	}
}
function validateContact() {

	if (document.forms[0].contactNo.value == '') {
		alert('Contact cannot be Empty');
	} else if (!document.forms[0].contactNo.value.match(contact)) {
		alert('Contact number should contain numeric values only');
		document.forms[0].contactNo.value = '';
	}
}


function validateAll(){
		var flag=false;
		var elem=document.forms[0].elements;
		for(var i=0;i<elem.length;i++){
			if(elem[i]!=null){
				if(elem[i].value==''){
					flag=true;
					alert('All the fields are Mandatory!!');
					break;
				}
			}
		}
		if(flag==false){
			location.replace("jsp_feedback.jsp?done=no");
		}
	}
</script>
</head>
<body>
	<%
		String done = request.getParameter("done") == null ? "yes"
				: request.getParameter("done");
	%>
	<div id="wrap">

		<jsp:include page="jsp_welcomeHeader.jsp" />


		<div class="center_content">
			<div class="left_content">
				<div class="title">
					<span class="title_icon"><img src="images/bullet1.gif"
						alt="" title="" />
					</span>Feedback
				</div>
				<form>
				<div class="feat_prod_box_details">
					<%
						if (done.equals("yes")) {
					%>

					<p class="details">
						<b>Happy to hear suggestions from your side</b>
					</p>

					<div class="contact_form">
						<div class="form_subtitle">Feedback</div>
						<div class="form_row">
							<label class="contact"><strong>Name*:</strong>
							</label> <input type="text" class="contact_input" maxlength="15" onkeyup="validateFname()" name="firstName"/>
						</div>

						<div class="form_row">
							<label class="contact"><strong>Email*:</strong>
							</label> <input type="text" class="contact_input" maxlength="25" onblur="validateEmail()" name="emailId"/>
						</div>


						<div class="form_row">
							<label class="contact"><strong>Phone*:</strong>
							</label> <input type="text" class="contact_input" maxlength="15" onkeyup="validateContact()" name="contactNo"/>
						</div>

						<div class="form_row">
							<label class="contact"><strong>Message*:</strong>
							</label>
							<textarea class="contact_textarea" ></textarea>
						</div>


						<div class="form_row">
						<input type="button"
								value="Submit" class="register" onclick="validateAll()"></input>
							
						</div>
					</div>

					<%
						} else {
					%>
					
							
							
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
			<p><b>Thanks for your suggestion!!</b></p>
		</div>
							
								
					<%
						}
					%>

				</div>
</form>

				<div class="clear"></div>
			</div>
			<!--end of left content-->

			<div class="right_content">

				<div class="languages_box">
					
				</div>
				<div class="currency">
				</div>


				<div class="title">
					<span class="title_icon"><img src="images/bullet3.gif"
						alt="" title="" />
					</span>About Book Shelf Library
				</div>
				<div class="about">
					<p>
						<img src="images/about.gif" alt="" title="" class="right" /> ESG
						library hosts the world's broadest and deepest multidisciplinary
						collection of books covering mostly technical and science based
						books. Featuring a clean and simple interface, this online service
						delivers intutive navigation, enhanced discoverability, expanded
						functionalities and a range of personalization and alerting
						options. :-)
					</p>

				</div>

				<div class="right_box">

					<div class="title">
						<span class="title_icon"><img src="images/bullet4.gif"
							alt="" title="" />
						</span>Promotions
					</div>
					<div class="new_prod_box">
						<a>Unix Practice</a>
						<div class="new_prod_bg">
							<span class="new_icon"><img src="images/promo_icon.gif"
								alt="" title="" />
							</span> <a><img src="images/unix.gif" alt="" title="" class="thumb"
								border="0" />
							</a>
						</div>
					</div>

					<div class="new_prod_box">
						<a>Angels and Demons</a>
						<div class="new_prod_bg">
							<span class="new_icon"><img src="images/promo_icon.gif"
								alt="" title="" />
							</span> <a><img src="images/angels.gif" alt="" title=""
								class="thumb" border="0" />
							</a>
						</div>
					</div>

					<div class="new_prod_box">
						<a>Complete Reference SQL</a>
						<div class="new_prod_bg">
							<span class="new_icon"><img src="images/promo_icon.gif"
								alt="" title="" />
							</span> <a><img src="images/sql.gif" alt="" title="" class="thumb"
								border="0" />
							</a>
						</div>
					</div>

				</div>

				<div class="right_box">
					<div class="title">
						<span class="title_icon"><img src="images/bullet6.gif"
							alt="" title="" />
						</span>Partners
					</div>


					<ul class="list">
						<li><a> Tata McGraw Hill</a>
						</li>
						<li><a> Rupa Publication</a>
						</li>
						<li><a> Rajhans Publication</a>
						</li>
						<li><a> Oxford Publication</a>
						</li>
						<li><a> IIM Publication</a>
						</li>
						<li><a> Dream Tech</a>
						</li>

					</ul>

				</div>

			</div>
			<!-- end of right content -->

			<div class="clear"></div>
		</div>
		<!--end of center content-->

		<div class="footer">
			<div class="left_footer">
				<img src="images/techy2.gif" alt="" title="" /><br />
				</a>
			</div>
			<div class="right_footer">
				<a href="jsp_welcome.jsp">Home</a> <a href="jsp_about.jsp">About
					Us</a>
			</div>
		</div>
	</div>
</body>
</html>