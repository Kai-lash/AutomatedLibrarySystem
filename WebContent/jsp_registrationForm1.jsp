<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<script type="text/javascript">

function modePay(){
	if(document.forms[0].mode.value=='1' || document.forms[0].mode.value=='2'){
		document.forms[0].cardno.disabled=false;
		document.forms[0].cvvno.disabled=false;
		document.forms[0].cardName.disabled=false;
		document.forms[0].dd_no.disabled=true;
		document.forms[0].bank_name.disabled=true;
		document.forms[0].cheque_no.disabled=true;
	}
	else if(document.forms[0].mode.value=='3'){
		document.forms[0].cardno.disabled=true;
		document.forms[0].cvvno.disabled=true;
		document.forms[0].cardName.disabled=true;
		document.forms[0].dd_no.disabled=true;
		document.forms[0].bank_name.disabled=false;
		document.forms[0].cheque_no.disabled=false;
	}
	else if(document.forms[0].mode.value=='4'){
		document.forms[0].cardno.disabled=true;
		document.forms[0].cvvno.disabled=true;
		document.forms[0].cardName.disabled=true;
		document.forms[0].dd_no.disabled=false;
		document.forms[0].bank_name.disabled=false;
		document.forms[0].cheque_no.disabled=true;
	}
}


function amountPay(memType){
	if(memType=='normal'){
		document.forms[0].amount.value='10000';
	}
	else
		{
		document.forms[0].amount.value='12000';
		}
}
</script>
<%
	String msg = request.getParameter("msg") == null ? "* fields are mandatory"
			: request.getParameter("msg");
%>
<body>
<div id="wrap">

       <div class="header">
       		<div class="logo"><a href="index.html"><img src="images/logo.gif" alt="" title="" border="0" /></a></div>            
        <div id="menu">
            <ul>                                                                       
            <li class="selected"><a href="jsp_welcome.jsp">Home</a></li>
            <li><a href="about.html">About Us</a></li>
            <li><a href="category.html">Books</a></li>
            <li><a href="specials.html">Specials Books</a></li>
            <li><a href="jsp_libLogin.jsp">Librarian</a></li>
            <li><a href="temp_myaccount.jsp">My Account</a></li>
            <li><a href="jsp_registrationForm.jsp">Register</a></li>
            <li><a href="details.html">Prices</a></li>
            <li><a href="contact.html">Contact</a></li>
            </ul>
        </div>     
            
            
       </div> 
       
       
       <div class="center_content">
       	<div class="left_content">
            <div class="title"><span class="title_icon"><img src="images/bullet1.gif" alt="" title="" /></span>Register</div>
        
        	<div class="feat_prod_box_details">
            <p class="details">
             Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.
            </p>
            <h5>
			<font color="red"><%=msg%></font>
		</h5>
              	<div class="contact_form">
                <div class="form_subtitle">create new account</div>
                 <form name="register" action="servlet_memberRegistration">          
                    <div class="form_row">
                    <label class="contact"><strong>Firstname*:</strong></label>
                    <input type="text" class="contact_input" name="firstName"/>
                    </div>  


					<div class="form_row">
                    <label class="contact"><strong>Middlename:</strong></label>
                    <input type="text" class="contact_input" name="middleName"/>
                    </div> 
                    
                    <div class="form_row">
                    <label class="contact"><strong>Lastname:</strong></label>
                    <input type="text" class="contact_input" name="lastName"/>
                    </div> 
                    
                    <div class="form_row">
                    <label class="contact"><strong>Password:</strong></label>
                    <input type="text" class="contact_input" name="password"/>
                    </div> 
                    
                    <div class="form_row">
                    <label class=""><strong>Security Question:</strong></label>
                    <select name="SecurityQuestion">
						<option value="0">--Select--</option>
						<option value="pet_name">What is your pet's name ?</option>
						<option value="birth_place">What is your Birth Place ?</option>
						<option value="school_name">What is your School Name ?</option>
						
				</select></div>
                    
                    <div class="form_row">
                    <label class="contact"><strong>Answer*:</strong></label>
                    <input type="text" class="contact_input" name="sec_que_ans" size="30"/>
                    </div>
                    
                    <div class="form_row">
                    <label class="contact"><strong>Correspondence Address*:</strong></label>
                    <input type="text" class="contact_input" name="address" size="70"/>
                    </div> 
                    
                    <div class="form_row">
                    <label class="contact"><strong>Email Id*:</strong></label>
                    <input type="text" class="contact_input" name="emailId" size="30"/>
                    </div> 
					
                    <div class="form_row">
                    <label class="contact"><strong>Contact No*:</strong></label>
                    <input type="text" class="contact_input" name="contactNo"/>
                    </div> 

                    <div class="form_row">
                    <label class="contact"><strong>Normal:</strong></label>
                    <input class="" type="radio" name="membershipType" value="normal" onclick="amountPay('normal')"/>
                    </div>


                    <div class="form_row">
                    <label class="contact"><strong>Premium:</strong></label>
                    <input class="" type="radio" name="membershipType" value="premium" onclick="amountPay('premium')"/>
                    </div>
                    
                    <div class="form_row">
                    <label class="contact"><strong>Membership Fees : </strong></label>
                    <input type="text" class="contact_input" name="amount" readonly="readonly"/>
                    </div>
                    
                    <div class="form_row">
                    <label class=""><strong>Select the mode of payment:</strong></label>
                    <select onchange="modePay()" name="mode">
						<option value="0">--Select--</option>
						<option value="1">Credit Card</option>
						<option value="2">Debit Card</option>
						<option value="3">Cheque</option>
						<option value="4">DD</option>
				</select>
                    </div>
                                       

					<div class="form_row">
                    <label class="contact"><strong>Card No:</strong></label>
                    <input type="text" class="contact_input" name="cardno"/>
                    </div>
					
					<div class="form_row">
                    <label class="contact"><strong>CVV No:</strong></label>
                    <input type="text" class="contact_input" name="cvvno"/>
                    </div>
                    
                    <div class="form_row">
                    <label class="contact"><strong>Name on Card: </strong></label>
                    <input type="text" name="cardName" class="contact_input"/>
                    </div>
                    
                    <div class="form_row">
                    <label class="contact"><strong>Cheque No :</strong></label>
                    <input type="text" class="contact_input" name="cheque_no" readonly="readonly"/>
                    </div>
                    
                    <div class="form_row">
                    <label class="contact"><strong>Demand Draft No : </strong></label>
                    <input type="text" class="contact_input" name="dd_no" readonly="readonly"/>
                    </div>
                    
                    <div class="form_row">
                    <label class="contact"><strong>Bank Name : </strong></label>
                    <input type="text" class="contact_input" name="bank_name" readonly="readonly"/>
                    </div>
                    

                    <div class="form_row">
                        <div class="terms">
                        <input type="checkbox" name="terms" />
                        I agree to the <a href="#">terms &amp; conditions</a>                        </div>
                    </div> 

                    
                    <div class="form_row">
                    <input type="submit" class="register" value="register" />
                    </div>  
					<input type="hidden" name="pageOption" value="registrationForm">
                  </form>     
                </div>  
            
          </div>	
            
              

            

            
        <div class="clear"></div>
        </div><!--end of left content-->
        
        <div class="right_content">
        
                	<div class="languages_box">
            <span class="red">Languages:</span>
            <a href="#"><img src="images/gb.gif" alt="" title="" border="0" /></a>
            <a href="#"><img src="images/fr.gif" alt="" title="" border="0" /></a>
            <a href="#"><img src="images/de.gif" alt="" title="" border="0" /></a>
            </div>
                <div class="currency">
                <span class="red">Currency: </span>
                <a href="#">GBP</a>
                <a href="#">EUR</a>
                <a href="#"><strong>USD</strong></a>
                </div>
                
                
              <div class="cart">
                  <div class="title"><span class="title_icon"><img src="images/cart.gif" alt="" title="" /></span>My cart</div>
                  <div class="home_cart_content">
                  3 x items | <span class="red">TOTAL: 100$</span>
                  </div>
                  <a href="cart.html" class="view_cart">view cart</a>
              
              </div>
        
             <div class="title"><span class="title_icon"><img src="images/bullet3.gif" alt="" title="" /></span>About Our Store</div> 
             <div class="about">
             <p>
             <img src="images/about.gif" alt="" title="" class="right" />
             Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.
             </p>
             
             </div>
             
             <div class="right_box">
             
             	<div class="title"><span class="title_icon"><img src="images/bullet4.gif" alt="" title="" /></span>Promotions</div> 
                    <div class="new_prod_box">
                        <a href="details.html">product name</a>
                        <div class="new_prod_bg">
                        <span class="new_icon"><img src="images/promo_icon.gif" alt="" title="" /></span>
                        <a href="details.html"><img src="images/thumb1.gif" alt="" title="" class="thumb" border="0" /></a>
                        </div>           
                    </div>
                    
                    <div class="new_prod_box">
                        <a href="details.html">product name</a>
                        <div class="new_prod_bg">
                        <span class="new_icon"><img src="images/promo_icon.gif" alt="" title="" /></span>
                        <a href="details.html"><img src="images/thumb2.gif" alt="" title="" class="thumb" border="0" /></a>
                        </div>           
                    </div>                    
                    
                    <div class="new_prod_box">
                        <a href="details.html">product name</a>
                        <div class="new_prod_bg">
                        <span class="new_icon"><img src="images/promo_icon.gif" alt="" title="" /></span>
                        <a href="details.html"><img src="images/thumb3.gif" alt="" title="" class="thumb" border="0" /></a>
                        </div>           
                    </div>              
             
             </div>
             
             <div class="right_box">
             
             	<div class="title"><span class="title_icon"><img src="images/bullet5.gif" alt="" title="" /></span>Categories</div> 
                
                <ul class="list">
                <li><a href="#">accesories</a></li>
                <li><a href="#">books gifts</a></li>
                <li><a href="#">specials</a></li>
                <li><a href="#">hollidays gifts</a></li>
                <li><a href="#">accesories</a></li>
                <li><a href="#">books gifts</a></li>
                <li><a href="#">specials</a></li>
                <li><a href="#">hollidays gifts</a></li>
                <li><a href="#">accesories</a></li>
                <li><a href="#">books gifts</a></li>
                <li><a href="#">specials</a></li>                                              
                </ul>
                
             	<div class="title"><span class="title_icon"><img src="images/bullet6.gif" alt="" title="" /></span>Partners</div> 
                
                <ul class="list">
                <li><a href="#">accesories</a></li>
                <li><a href="#">books gifts</a></li>
                <li><a href="#">specials</a></li>
                <li><a href="#">hollidays gifts</a></li>
                <li><a href="#">accesories</a></li>
                <li><a href="#">books gifts</a></li>
                <li><a href="#">specials</a></li>
                <li><a href="#">hollidays gifts</a></li>
                <li><a href="#">accesories</a></li>                              
                </ul>      
             
             </div>         
             
        
        </div><!--end of right content-->
        
        
       
       
       <div class="clear"></div>
       </div><!--end of center content-->
       
              
       <div class="footer">
       	<div class="left_footer"><img src="images/footer_logo.gif" alt="" title="" /><br /> <a href="http://csscreme.com/freecsstemplates/" title="free templates"><img src="images/csscreme.gif" alt="free templates" title="free templates" border="0" /></a></div>
        <div class="right_footer">
        <a href="#">home</a>
        <a href="#">about us</a>
        <a href="#">services</a>
        <a href="#">privacy policy</a>
        <a href="#">contact us</a>
       
        </div>
        
       
       </div>
    

</div>

</body>
</html>