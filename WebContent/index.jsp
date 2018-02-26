<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.HibernateException"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@ page import="com.sidcleywilker.util.ConnectionUtil" %>
<%@page import="com.sidcleywilker.model.Item" %>

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

Transaction tx = null;

%>

	<div class="container">
		<h1 class="titulo">Jsp Hibernate Bootstrap And Mysql</h1>
	</div>


	<div class="container">
		<div class="row">
			<div class="col-md-5 col-lg-5">
			<div class="card">
			  <div class="card-body">
			    <form action="adicionarItem" role="form" method="post">
			    	 <div class="form-group">
					    <label >Item name</label>
					    <input type="text" class="form-control"  placeholder="Item name" name="itemname">
					  </div>
					  
					  <div class="form-group">
					    <label>Item price</label>
					    <input type="text" class="form-control"  placeholder="Item price" name="itemprice">
					  </div>
					  
					  <div class="form-group">
					    <label>Item quantity</label>
					    <select class="custom-select" name="itemquantity">
					    	<option value="0">Select Item</option>
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
					  <button type="submit" class="btn btn-primary btn-block"><i class="fas fa-plus"></i> Add itens</button>
			    </form>
			  </div>
			</div>
			</div>
			
			<div class="col-md-7 col-lg-7">
				<table id="table_id" class="table table-hover">
				  <thead>
				    <tr>
				      <th scope="col">#</th>
				      <th scope="col">name</th>
				      <th scope="col">price</th>
				      <th scope="col">quantity</th>
				      <th scope="col" class="alinhatexto" colspan="2">Ações</th>
				      <th scope="col"></th>
				    </tr>
				  </thead>
				  
				  <tbody>
				    
				    <%
				    	try{
				    		tx = ss.beginTransaction();	
				    		List itens = ss.createQuery("FROM Item").list();
				    		int cont = 1;
				    		for(Iterator iterator = itens.iterator(); iterator.hasNext();){
				    			Item it = (Item) iterator.next();
				    %>
				    
					    <tr>
					      <th scope="row"><%= cont %></th>
					      <td><%= it.getItemName() %></td>
					      <td>R$ <%= it.getItemPrice() %></td>
					      <td><%= it.getItemQuantity() %></td>
					      <td>
					      	<a href="updateItem.jsp?itemId=<%= it.getItemId() %>" class="btn btn-outline-success btn-block"><i class="fas fa-edit"></i>Editar</a>
					      </td>
					      <td>
					      	<a href="removerItem?itemId=<%= it.getItemId() %>" class="btn btn-outline-danger btn-block"><i class="far fa-trash-alt"></i>Deletar</a>
					      </td>
					    </tr>
  	      
					<%		
				    		cont++;
				    		}// end for
				    		
				    		tx.commit();
						} //end try 
						catch(HibernateException ex){
							 if(tx != null){
								 tx.rollback();
							 }
							ex.printStackTrace();
						}//end catch
						finally{
							 ss.close();
						}// end finally
					
					%>
				  </tbody>
				</table>
			</div>
		</div>
	</div>
	
	 
	<script defer src="js/fontawesome-all.js"></script>
	
	
</body>
</html>