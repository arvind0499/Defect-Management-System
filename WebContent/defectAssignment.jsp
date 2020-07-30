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
<div class="container col-6">
	<br>
	<%
		if (session.getAttribute("uid") == null) {
			response.sendRedirect("login.jsp");
		} else {
			int did = Integer.parseInt(request.getParameter("did"));
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/defect", "root", "root");
			Statement st1 = con.createStatement();
			ResultSet rs1 = st1.executeQuery("select uname, uid from user");
			out.println("<center><h2>Assign To:</h2>");
			out.println("<form action='defassign' method='post'>");
			while (rs1.next()) {
	%>
	<input name="did" value="<%=did%>" type="text" hidden="true">
	<input name="assigningDefectTo" type="radio" value='<%=rs1.getInt("uid")%>'><%=rs1.getString("uname")%></input>
	<br>
	<%
		}
			out.println("<br><input class='btn btn-primary' type='submit' value='Assign'>");
			out.println("</form></center>");
		}
	%>
</div>
</body>
</html>