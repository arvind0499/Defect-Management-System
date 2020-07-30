package com;

import java.sql.*;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/defassign")
public class defassign extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("uid")==null) {
			response.sendRedirect("login.jsp");
		}
		try{
			int assigningto = Integer.parseInt(request.getParameter("assigningDefectTo"));
			int did = Integer.parseInt(request.getParameter("did"));
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/defect", "root", "root");
			Statement st1 = con.createStatement();
			st1.executeUpdate("update defectdetails set assignedTo = "+assigningto+" where did = "+did);
			response.sendRedirect("adminDefects.jsp");
//			RequestDispatcher rd = request.getRequestDispatcher("adminDefects.jsp");
//			rd.forward(request, response);
		}
		catch(Exception e) {
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}