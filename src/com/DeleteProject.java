package com;

import javax.servlet.http.HttpSession;
import java.sql.*;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteProject")
public class DeleteProject extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			
			if(session.getAttribute("uid")==null){
				response.sendRedirect("login.jsp");
			}			
			int pid = (int) session.getAttribute("pid");
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/defect", "root", "root");
			Statement st = con.createStatement();
			String query1 = "delete from defectDetails where pid = " + pid;
			String query2 = "delete from projectList where pid = " + pid;
			st.executeUpdate(query1);
			st.executeUpdate(query2);
			st.close();
			con.close();
			if("adm".equalsIgnoreCase((String)session.getAttribute("uid"))) {
				response.sendRedirect("adminProfile.jsp");
			}
			else {
				response.sendRedirect("profile.jsp");
			}
//			RequestDispatcher rd = request.getRequestDispatcher("profile.jsp");
//			rd.forward(request, response);
		} catch (Exception e) {

		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
