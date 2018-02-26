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
 * Servlet implementation class RemoveItemServlet
 */
@WebServlet(name="RemoveItemServlet", urlPatterns= {"/removerItem"})
public class RemoveItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SessionFactory factory;
	private Session ss;
	private Transaction tx;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoveItemServlet() {
    	factory = ConnectionUtil.getSessionFactory();
     
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String itemId = request.getParameter("itemId");
		int id = Integer.parseInt(itemId);
		
		try{
			ss = factory.openSession();
	        tx = ss.beginTransaction();
	        
			Item item = ss.get(Item.class, id);
			ss.delete(item);
			
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
