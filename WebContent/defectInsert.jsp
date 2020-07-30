<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	import="java.sql.*" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<title>Defect Registered</title>
</head>
<body>
		<div class="container col-8">
			<%
				response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
				if (session.getAttribute("uid") == null) {
					response.sendRedirect("login.jsp");
				}
				else 
				{
				int defid;
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/defect", "root", "root");

				Statement st = con.createStatement();
				ResultSet rs1;
				do {
					defid = (int) (Math.random() * 1000);
					String query1 = "select did from defectdetails where did=" + defid;
					rs1 = st.executeQuery(query1);
				} while (rs1.next());
				rs1.close();
				st.close();

				PreparedStatement ps = con.prepareStatement("insert into defectdetails values(?,?,?,?,?,?,?,?)");
				ps.setInt(1, defid);
				ps.setString(2, request.getParameter("deftype"));
				ps.setString(3, request.getParameter("defpriority"));
				ps.setString(4, request.getParameter("defdesc"));
				ps.setString(5, "open");
				ps.setInt(6, (int) session.getAttribute("pid"));
				ps.setInt(7, (int) session.getAttribute("uid"));
				ps.setInt(8, -1);
				ps.executeUpdate();
				ps.close();
				con.close();
			%>
			<center><h4 style="margin:22% 0px 0px 0px;"><%="Defect Registerd!! Thanks for making the world better."%></h4></center>
			<center><h4><%="Your contribution is not less than anyone working here :D"%></h4></center>
			<%
			if("adm".equals((String)session.getAttribute("role"))){
			%>
			<center><a class="btn btn-primary" href="adminProfile.jsp" style="margin: 10px">Profile</a></center>
			<br>
			<%
			}
			else{
			%>
			<center><a class="btn btn-primary" href="profile.jsp" style="margin: 10px">Profile</a></center>
			<br>
			<% 
			}
			}
			%>
		</div>
</body>
</html>