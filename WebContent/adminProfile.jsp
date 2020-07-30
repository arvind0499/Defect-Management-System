<!-- 
control 1-> projectDetail.jsp with pid-hidden, pname
control 2-> button-onclick to adminDefects.jsp(view defect details)
control 3-> href to project.jsp(add new project)
 -->
 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	import="java.sql.*" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div class="container col-8">
	<%
		if (session.getAttribute("uid") == null) {
			response.sendRedirect("login.jsp");
		}else{
	%>
		<center><h3 style="width: 50%;">Project List</h3></center>
		<%
			int uid = (int) session.getAttribute("uid");
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/defect", "root", "root");
			Statement st = con.createStatement();

			ResultSet rs1 = st.executeQuery("select * from projectList where pinclude=1");
			while (rs1.next()) {
		%>
		<form action="projectDetail.jsp" method="post">
			<input type="text" name="pid" value="<%=rs1.getInt(1)%>" hidden="true"> 
			<center>
				<input class="form-control col-3" type="submit" name="pname" value="<%=rs1.getString(2)%>"></input>
			</center>
		</form>
		<%
			}
		%>
		<br>
		<center><button class="btn btn-primary" onclick="location.href='adminDefects.jsp'">View Defects Details</button></center>
		<br>
		<center><a class="btn btn-primary" href="project.jsp">Add New Project</a></center>
		<br>
		<form action="Logout" method="post">
			<center><input class="btn btn-primary" type="submit" value="Logout"></center>
		</form>
		
		
		<%
		}
		%>

</div>
</body>
</html>