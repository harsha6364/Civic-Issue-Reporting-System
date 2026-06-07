package com.civic.test;

import java.util.Scanner;

import com.civic.dao.UserDAO;
import com.civic.dao.impl.UserDAOImpl;
import com.civic.dto.User;

public class Test {
	
	public static void main(String args[]) {
		Scanner sc = new Scanner(System.in);
		User u = new User();
		UserDAO udao = new UserDAOImpl();
		
//		System.out.println("Enter your name :");
//		u.setName(sc.next());
//		
//		System.out.println("Enter your email:");
//		u.setEmail(sc.next());
//		
//		System.out.println("Enter your phone number:");
//		u.setPhone(sc.next());
//		
//		System.out.println("Enter your password:");
//		u.setPassword(sc.next());
//		
//		System.out.println("Enter your village:");
//		u.setVillage(sc.next());
//		
//		udao.registerUser(u);
		
		System.out.println("Enter your email:");
		String email = sc.next();
		
		System.out.println("Enter your password:");
		String password = sc.next();
		
		System.out.println(udao.getUserByEmailPassword(email, password));
		
		
	}
}
