package com.sidcleywilker.servelet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.sidcleywilker.model.Item;
import com.sidcleywilker.util.ConnectionUtil;

/**
 * Servlet implementation class EditItemServlet
 */
@WebServlet(name="/EditItemServlet", urlPatterns= {"/editarItem"})
public class EditItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	private SessionFactory factory;
	private Session ss;
	private Transaction tx;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditItemServlet() {
    	factory = ConnectionUtil.getSessionFactory();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String itemId = request.getParameter("id");
		int id = Integer.parseInt(itemId);

		String itemName = request.getParameter("itemname");
		String itemPrice = request.getParameter("itemprice");
		double price = Double.parseDouble(itemPrice);
		String itemQuantity = request.getParameter("itemquantity");
		int quantity = Integer.parseInt(itemQuantity);
		
		try{
			ss = factory.openSession();
	        tx = ss.beginTransaction();
			Item item = ss.get(Item.class, id);
			item.setItemName(itemName);
			item.setItemPrice(price);
			item.setItemQuantity(quantity);
			ss.update(item);
			
			if(ss != null){
				response.sendRedirect("index.jsp");
			}
			
			tx.commit();
		}catch(HibernateException ex){
			if(tx != null){
		  		tx.rollback();
		  	}
		 }finally{
		  	ss.close();
		 }
	}

}
