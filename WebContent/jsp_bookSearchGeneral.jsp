<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="book.servlet_bookSearch"%>
<%@page import="java.util.Vector" errorPage="jsp_errorPage.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<%
%>
<%
	
String category=request.getParameter("category")== null ? "0"
		: request.getParameter("category");
String msg=request.getParameter("msg")== null ? ""
		: request.getParameter("msg");
String varbook_Name=request.getParameter("book_Name")== null ? ""
		: request.getParameter("book_Name");
String varbook_Author=request.getParameter("author_Name")== null ? ""
		: request.getParameter("author_Name");

servlet_bookSearch sbs = new servlet_bookSearch();
sbs.setBook_cat(category);
sbs.setBook_name(varbook_Name);
sbs.setBook_author(varbook_Author);
sbs.bookSearchInit();
sbs.bookSearchName();
sbs.bookSearchAuthor();


Vector book_Name= sbs.book_NameV;
Vector book_Author= sbs.book_AuthorV;
Vector book_Publisher= sbs.book_PublisherV;
Vector book_ID= sbs.book_IDV;

// FOR BOOK SEARCH BY NAME
Vector book_Name2= sbs.book_NameV2;
Vector book_Author2= sbs.book_AuthorV2;
Vector book_Publisher2= sbs.book_PublisherV2;
Vector book_ID2= sbs.book_IDV2;

// FOR BOOK SEARCH BY Author
Vector book_Name3= sbs.book_NameV3;
Vector book_Author3= sbs.book_AuthorV3;
Vector book_Publisher3= sbs.book_PublisherV3;
Vector book_ID3= sbs.book_IDV3;
%>
<script type="text/javascript">
function refresh()
{
	var searchBy=document.forms[0].searchBy.value;
	
	location.replace("jsp_bookSearchGeneral.jsp?searchBy="+searchBy);
	
	}
	
function refreshCat()
{
	var searchBy=document.forms[0].searchBy.value;	
	var category=document.forms[0].category.value;
	location.replace("jsp_bookSearchGeneral.jsp?searchBy="+searchBy+"&category="+category);
	
	}
	
function refreshBookName()
{
	var searchBy=document.forms[0].searchBy.value;	
	var book_Name=document.forms[0].book_Name.value;
	location.replace("jsp_bookSearchGeneral.jsp?searchBy="+searchBy+"&book_Name="+book_Name);
	
	}
	
	
function refreshBookAuthor()
{
	var searchBy=document.forms[0].searchBy.value;	
	var author_Name=document.forms[0].author_Name.value;
	location.replace("jsp_bookSearchGeneral.jsp?searchBy="+searchBy+"&author_Name="+author_Name);
	
	}
function retain_value(searchBy,category)
{
	document.forms[0].searchBy.value=searchBy;
	if(document.forms[0].category!=null){
		document.forms[0].category.value=category;
		}
	
	
	}

</script>

<%String searchBy=request.getParameter("searchBy")==null?"":request.getParameter("searchBy");%>
<body onload="retain_value('<%=searchBy%>','<%=category%>')">
<div id="wrap">
 
       <jsp:include page="jsp_welcomeHeader.jsp" />
       
       
       <div class="center_content">
       	<div class="left_content">
            <div class="title"></div>
        
        	<div class="feat_prod_box_details">
            <p class="details">
             
            </p>
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
							
					<div id="dialog" title="Message">
			<p><b><%=msg%></b></p>
		</div>
							
								<%} %>

              	<div class="title"><span class="title_icon"><img src="images/bullet1.gif" alt="" title="" /></span>Available Books</div>
            
              
 <form action="servlet_bookSearch">
<table align="center"  class="cart_table" border="1">
		<tr class="cart_title">

<td colspan="2"><b>Book search by</b></td>
<td colspan="2"><select name ="searchBy" onchange="refresh()">
						<option value="">--Select--</option>
						<option value="book_Name">Book Name</option>
						<option value="author_Name">Author Name</option>
						<option value="category">Category</option>

</select></td>


</tr>

<%if(searchBy.equals("category")){ %>
<tr>

<td colspan="4" align="right"><b>Categories:</b><select name ="category" onchange="refreshCat()">
						<option value="0">--Select--</option>
						<option value="TECHNICAL">Technical</option>
						<option value="FICTION">Fiction</option>
						<option value="NON-FICTION">Non-Fiction</option>

</select></td>
<%if(book_Name.size()!=0){ %>
		<tr>
			<td>Book Name</td>
			<td>Author</td>
			<td>Publisher Name</td>
			<td>Issue</td>
			
		</tr>
		
		
		<%for(int i=0;i<book_Name.size();i++){ %>
		<tr>
			<td><%=book_Name.elementAt(i) %></td>
			<td><%=book_Author.elementAt(i) %></td>
			<td><%=book_Publisher.elementAt(i) %></td>
			<td>
			<input type="hidden" name="bookIDhidden" value="<%=book_ID.elementAt(i) %>">
			<input type="hidden" name="booknamehidden" value="<%=book_Name.elementAt(i) %>">
			<input type="hidden" name="authornamehidden" value="<%=book_Author.elementAt(i) %>">
			<input type="radio" name="Issue" >
			</td>
		</tr>
		
		<%} %>
		
		<%} %>

<%}%> 

<%
	if(searchBy.equals("book_Name")){
%>
<tr>
	<td> Book Name:<input type ="text" name="book_Name" onblur="refreshBookName()"></td>
<td colspan="3"><input type= "button" name="Search" value="Search"  class="register" onclick="refreshBookName()"></td>
</tr>


<%if(book_Name2.size()!=0){ %>
		<tr>
			<td>Book Name</td>
			<td>Author</td>
			<td>Publisher Name</td>
			<td>Issue</td>
			
		</tr>
		
		
		
		<%for(int i=0;i<book_Name2.size();i++){ %>
		<tr>
			<td><%=book_Name2.elementAt(i) %></td>
			<td><%=book_Author2.elementAt(i) %></td>
			<td><%=book_Publisher2.elementAt(i) %></td>
			<td>
			<input type="hidden" name="bookIDhidden" value="<%=book_ID2.elementAt(i) %>">
			<input type="hidden" name="booknamehidden" value="<%=book_Name2.elementAt(i) %>">
			<input type="radio" name="Issue" >
			</td>
		</tr>
	<%} %>
<%} 
else if(book_Name2.size()==0 && !(varbook_Name.equals(""))){
	%>
		
		
	<br><br></br></br>
		<div class="ui-widget">
			<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
				<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
				<strong>Alert:</strong> No books found </p>
			</div>
		</div>

<br></br>

	<%
}
%>
<%} %>

<%if(searchBy.equals("author_Name")){%>

<tr>
	<td> Author Name:<input type ="text" name="author_Name"></td>
	<td align="center" colspan="3"><input type= "button" name="Search" class="register" value="Search" onclick="refreshBookAuthor()"></td>
</tr>

<%if(book_Name3.size()!=0){ %>
<tr>
			<td>Book Name</td>
			<td>Author</td>
			<td>Publisher Name</td>
			<td>Issue</td>
			
		</tr>
		
		
		<%for(int i=0;i<book_Name3.size();i++){ %>
		<tr>
			<td><%=book_Name3.elementAt(i) %></td>
			<td><%=book_Author3.elementAt(i) %></td>
			<td><%=book_Publisher3.elementAt(i) %></td>
			<td>
			<input type="hidden" name="bookIDhidden" value="<%=book_ID3.elementAt(i) %>">
			<input type="hidden" name="booknamehidden" value="<%=book_Name3.elementAt(i) %>">
			<input type="radio" name="Issue" >
			</td>
		</tr>
				
		<%}%>
		
	<%}
	else if(book_Name3.size()==0 && !(varbook_Author.equals(""))){
	%>
	<br><br></br></br>
		<div class="ui-widget">
			<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
				<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
				<strong>Alert:</strong> No books found for this author </p>
			</div>
		</div>

<br></br>

	<%
}%>
<%}%>

</table>
<center></center><br>
<input type="hidden" name="pageOption" value="searchBook">
<%=msg %>
</form>
            
 </div>
            
        <div class="clear"></div>
        </div><!--end of left content-->
        
       <jsp:include page="jsp_welcomeFooter.jsp" />

</body>
</html>
