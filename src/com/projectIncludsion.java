/*
 * parameter(pid)
 * make projects available suggest by users
 * and return to project.jsp(control)
 */
package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/projectIncludsion")
public class projectIncludsion extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			if(session.getAttribute("uid")==null) {
				response.sendRedirect("login.jsp");
			}
			else {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/defect", "root", "root");
				Statement st = con.createStatement();
				int pid = Integer.parseInt(request.getParameter("pid"));
				st.executeUpdate("update projectList set pinclude=1 where pid="+pid);
				RequestDispatcher rd = request.getRequestDispatcher("project.jsp");
				rd.forward(request, response);
			}
		}
		catch(Exception e) {
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
