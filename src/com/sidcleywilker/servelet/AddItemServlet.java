package com.sidcleywilker.servelet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.sidcleywilker.model.Item;
import com.sidcleywilker.util.ConnectionUtil;

/**
 * Servlet implementation class ItemServelet
 */
@WebServlet(name="AddItemServlet", urlPatterns= {"/adicionarItem"})
public class AddItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private SessionFactory factory;
	private Session ss;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddItemServlet() {
        factory = ConnectionUtil.getSessionFactory();
        ss = factory.openSession();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
		String itemName = request.getParameter("itemname");
		 String itemPrice = request.getParameter("itemprice");
		 double price = Double.parseDouble(itemPrice);
		 String itemQuantity = request.getParameter("itemquantity");
		 int quantity = Integer.parseInt(itemQuantity);
		 
		 Item item = new Item(itemName, price, quantity);
		 
		 ss.getTransaction().begin();
		 ss.save(item);
		 ss.beginTransaction().commit();
		 
		 
		 if(ss != null){
			 response.sendRedirect("index.jsp");
		 }

	}

}
