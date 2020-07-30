<!-- 
 get parameter(pid, pname)
 get attribute(role)
 set session(pid)
 href-> defect.jsp(for reporting a defect)
 button-onlcick-> DeleteProject.java (confirmation popup using javascript) at end
 href-> profile.jsp/adminProfile.jsp
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
	<center>
		<div class="container" style="padding: 20px;">
			<%
				//response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
				if (session.getAttribute("uid") == null) {
					response.sendRedirect("login.jsp");
				}
				else{
				int pid = Integer.parseInt(request.getParameter("pid"));
				session.setAttribute("pid", pid);
				String pname = request.getParameter("pname");
				String role = (String) session.getAttribute("role");
			%>
			<h2>
				<i><u><%="Project Name:- " + pname%></u></i>
			</h2>
			<a class="btn btn-primary" href="defect.jsp" style="margin: 10px">Report Defect</a> <br>
			<%
				if (role.equals("adm")) {
			%>
			<a class="btn btn-primary" href="adminProfile.jsp" style="margin: 10px">Profile</a> <br>
			<button class="btn btn-primary" onclick="myfunc1()">Delete Project</button> <br>
			<%
				} else {
			%>
			<a class="btn btn-primary" href="profile.jsp" style="margin: 10px">Profile</a> <br>
			<%
				}
				}
			%>
		</div>
	</center>
</body>
<script type="text/javascript">
	function myfunc1() {
		var con = confirm("Sure you want to delete this project?");
		if (con) {
			location.href = "DeleteProject";
		}
	}
</script>
</html>