package com.sidcleywilker.util;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class ConnectionUtil {

	private static SessionFactory factory = null;
	private static Configuration conf = null;
	
	
	private static SessionFactory myBuildSessionFactory() {
		
		try {
			conf = new Configuration();
			conf.configure("hibernate.conf.xml");
			System.out.println("Configuration load successfully .......");
			
			factory = conf.buildSessionFactory();
			System.out.println("factory load successfully .......");
			
			return factory;
		}catch (Throwable e) {
			System.err.print("SessionFactory creation faild");
			e.printStackTrace();
			throw new ExceptionInInitializerError(e);
		}
	}
	
	
	public static SessionFactory getSessionFactory() {
		if (factory == null) {
			factory = myBuildSessionFactory();
		}
		return factory;
	}
}
