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
<title>Signup</title>
</head>
<body>
	<div class="container col-4">
		<div class="form-group">
			<form method="post" action="SignupInsert">
				<br>
				<h5>
					<center><i>Name</i></center>
				</h5>
				<input type="text" name="name" class="form-control"
					placeholder="Enter full name"> <br>
				<h5>
					<center><i>E-mail</i></center>
				</h5>
				<input type="text" name="email" class="form-control"
					placeholder="xyz@abc.com"> <br>
				<h5>
					<center><i>Password</i></center>
				</h5>
				<input type="password" name="pass" class="form-control"
					placeholder="Enter password"> <br>
				<h5>
					<center><i>Confirm Password</i></center>
				</h5>
				<input type="password" name="conpass" class="form-control"
					placeholder="Enter password to confirm"> <br>
				<h5>
					<center><i>Projects</i></center>
				</h5>
				<%
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/defect", "root", "root");
					Statement st = con.createStatement();
					String query1 = "select * from projectList";
					ResultSet rs = st.executeQuery(query1);
					while (rs.next()) {
						int projectid = rs.getInt(1);
						String projectname = rs.getString(2);
				%>
				<table>
					<tr>
						<td><input type="checkbox" name="project" value=<%=projectid%>><i><%=projectname%></i></td>
					</tr>
				</table>
				<%
					}
				%>
				<br>
				<h5>
					<center><i>Role</i></center>
				</h5>
				<select name="role" class="form-control">
					<option hidden>select</option>
					<option>Tester</option>
					<option>Developer</option>
					<option>Manager</option>
					<option>Client</option>
				</select> <br> 
				<center><input type="submit" class="btn btn-primary"></center>
			</form>
		</div>
		<center><a href="login.jsp" class="btn btn-primary" title="Already Registered!">Login</a></center>
	</div>
</body>
</html>