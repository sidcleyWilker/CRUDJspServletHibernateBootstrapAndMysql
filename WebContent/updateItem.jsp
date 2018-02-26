<%@page import="org.hibernate.HibernateException"%>
<%@page import="com.sidcleywilker.model.Item"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@ page import="com.sidcleywilker.util.ConnectionUtil" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>App Sidcley</title>

    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/estilo.css">
    <script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="js/jquery-3.3.1.min.js"></script>
    
</head>
<body>

<%
SessionFactory factory = ConnectionUtil.getSessionFactory();
Session ss = factory.openSession();

Transaction tx = ss.beginTransaction();

String idItem = request.getParameter("itemId");
int id = Integer.parseInt(idItem);

%>

	<div class="container">
		<h1 class="titulo">Update item</h1>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-md-8 col-lg-8">
				<div class="card">
				  <div class="card-body">
				  
				  <%
				  	try{
						
						Item it = (Item) ss.load(Item.class, id);

				  %>
				  
					  	<form action="editarItem" role="form" method="post">
					  		<input type="hidden" name="id" value="<%= it.getItemId()%>">
					    	 <div class="form-group">
							    <label >Item name</label>
							    <input type="text" class="form-control"  placeholder="Item name" name="itemname" value="<%= it.getItemName()%>">
							  </div>
							  
							  <div class="form-group">
							    <label>Item price</label>
							    <input type="text" class="form-control"  placeholder="Item price" name="itemprice" value="<%= it.getItemPrice()%>">
							  </div>
							  
							  <div class="form-group">
							    <label>Item quantity</label>
							    <select class="custom-select" name="itemquantity" >
							    	<option value="<%= it.getItemQuantity()%>"><%= it.getItemQuantity()%> Item</option>
							    	<option value="1">1 Item</option>
							    	<option value="2">2 Item</option>
							    	<option value="3">3 Item</option>
							    	<option value="4">4 Item</option>
							    	<option value="5">5 Item</option>
							    	<option value="6">6 Item</option>
							    	<option value="7">7 Item</option>
							    	<option value="8">8 Item</option>
							    </select>
							  </div>
							  <button type="submit" class="btn btn-primary btn-block"><i class="far fa-save"></i> Update itens</button>
					    </form>
				  	<%
				  	}//end try
				  	catch(HibernateException ex){
				  		if(tx != null){
				  			tx.rollback();
				  		}
				  	}// end catch
				  	
				  	finally{
				  		ss.close();
				  	}
				  	%>
				  </div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>