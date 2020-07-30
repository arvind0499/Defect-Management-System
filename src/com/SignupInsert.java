package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SignupInsert")
public class SignupInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try (PrintWriter out = response.getWriter()) {
			int id = -1;
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String password = request.getParameter("pass");
			String conpassword = request.getParameter("conpass");
			String role = request.getParameter("role");
			String[] project = request.getParameterValues("project");
			if (role.equalsIgnoreCase("Tester")) {
				role = "tst";
			} else if (role.equalsIgnoreCase("Developer")) {
				role = "dev";
			} else if (role.equalsIgnoreCase("Manager")) {
				role = "mng";
			} else if (role.equalsIgnoreCase("Client")) {
				role = "clt";
			}
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/defect", "root", "root");
			Statement st = con.createStatement();
			ResultSet rs;

			if (!password.equals(conpassword)) {

				out.println("<p>Password doesn't match</p>");
				RequestDispatcher rd1 = request.getRequestDispatcher("signup.jsp");
				rd1.include(request, response);

			} else {
				String query1 = "select email from user where email = '" + email + "'";
				rs = st.executeQuery(query1);
				if (rs.next()) {
					rs.close();
					con.close();
					st.close();
					out.println("<p>Email is already Registered!</p>");
					RequestDispatcher rd1 = request.getRequestDispatcher("signup.jsp");
					rd1.include(request, response);
				} else {
					rs.close();
					do {
						id = (int) (Math.random() * 1000);
						String query2 = "select uid from user where uid = " + id;
						rs = st.executeQuery(query2);
					} while (rs.next());

					rs.close();
					st.close();

					String upro = "";

					for (int i = 0; i < project.length; i++) {
						upro = upro + project[i] + " ";
					}
					PreparedStatement ps1 = con.prepareStatement("insert into user values(?,?,?,?,?,?)");
					ps1.setInt(1, id);
					ps1.setString(2, name);
					ps1.setString(3, email);
					ps1.setString(4, password);
					ps1.setString(5, upro);
					ps1.setString(6, role);
					ps1.execute();

					ps1.close();
					con.close();
					out.println("<p>Successfully Registered!</p>");
					RequestDispatcher rd1 = request.getRequestDispatcher("login.jsp");
					rd1.forward(request, response);
				}
			}
		} catch (Exception e) {
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
