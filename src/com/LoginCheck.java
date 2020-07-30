/*
 * get Parameters(email, password)
 * session setup uid and role
 * Admin->adminProfile.jsp
 * user->profile.jsp
 * wrong info->login.jsp
 */
package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.http.HttpSession;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LoginCheck")
public class LoginCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();

		try (PrintWriter out = response.getWriter()) {
			
			String email = request.getParameter("uemail");
			String password = request.getParameter("upass");
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/defect", "root", "root");
			Statement st = con.createStatement();
			ResultSet rs1 = st.executeQuery("select password,uid,role from user where email = '" + email + "'");
			
			if (rs1.next()) {
				boolean result = password.equals(rs1.getString(1));
				if (result) {
					session.setAttribute("uid", rs1.getInt(2));
					session.setAttribute("role", rs1.getString(3));
					
					if(rs1.getString(3).equalsIgnoreCase("adm")){
						st.close();
						con.close();
						response.sendRedirect("adminProfile.jsp");
					}
					else {
						st.close();
						con.close();
						response.sendRedirect("profile.jsp");
					}
				} else {
					st.close();
					con.close();
					out.println("<p>Incorrect Password!</p>");
					RequestDispatcher rd2 = request.getRequestDispatcher("login.jsp");
					rd2.include(request, response);
				}
			} else {
				st.close();
				con.close();
				out.println("<p>Email is not registered!</p>");
				RequestDispatcher rd3 = request.getRequestDispatcher("login.jsp");
				rd3.include(request, response);
			}

		} catch (Exception e) {
			PrintWriter out = response.getWriter();
			out.println(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
