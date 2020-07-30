/*
 * get parameter(pname)
 * get session role
 * insert a new project in table projectList
 */

package com;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/projectInsert")
public class projectInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			HttpSession session = request.getSession();
			if(session.getAttribute("uid")==null) {
				response.sendRedirect("login.jsp");
			}else {
				String pname = request.getParameter("pname");
				int pid = 0;
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/defect", "root", "root");
				Statement st = con.createStatement();
				ResultSet rs1;
				do {
					pid = (int)(Math.random()*1000);
					rs1 = st.executeQuery("select pid from projectList where pid = "+pid);
				}while(rs1.next());
				

				PreparedStatement ps= con.prepareStatement("insert into projectList  values(?,?,?)");
				ps.setInt(1, pid);
				ps.setString(2, pname);
				if(session.getAttribute("role").equals("adm"))
					ps.setInt(3, 1);
				else
					ps.setInt(3, 0);
				ps.execute();
				
				rs1.close();
				st.close();
				con.close();
				if("adm".equals((String)session.getAttribute("role"))) {
					response.sendRedirect("adminProfile.jsp");
				}
				else {
					response.sendRedirect("profile.jsp");
				}
			}
		}
		catch(Exception e) {
			response.getWriter().print(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
