<!-- 
control 1-> projectInsert.java with pname(new project name)
slidder 1-> for admin only to add new project requested by users
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
	<%
		if (session.getAttribute("uid") == null) {
			response.sendRedirect("login.jsp");
		} else {
	%>
	<div class="container col-4">
		<br>
		<form action="projectInsert" method="post">
			<center>
				<h5>
					<i>Project Name</i>
				</h5>
				<input type="text" name="pname" placeholder="Enter Project Name" class="form-control">
				<%
					if (session.getAttribute("role").equals("adm")) {
				%>
				<br> <input type="submit" value="Add Project" class="btn btn-primary">
				<%
					} else {
				%>
				<br> <input type="submit" value="Request Project" class="btn btn-primary">
				<%
					}
				%>
			</center>
		</form>
		<br>
		<%
			if(session.getAttribute("role").equals("adm")){
		%>
		<div>
			<button onclick="reqprobut()" id="requestedProjectButton" class="btn btn-primary">Requested Projects</button>
			<div id="requestedProject">
			<table class="table table-striped">
				<tr>
					<td>Project Name</td>
				</tr>
					<%
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/defect", "root", "root");
						Statement st = con.createStatement();
						ResultSet rs1 = st.executeQuery("select * from projectList where pinclude=0");
						while (rs1.next()) {
					%>
					<tr>
						<td><%=rs1.getString("pname")%></td>
						<td>
							<form action="projectIncludsion">
								<input type="hidden" name="pid" value=<%= rs1.getInt("pid") %>>
								<input type="submit" value="Include">
							</form>
						</td>
					</tr>	
					<%
						}
					%>
			</table>
			</div>
		</div>
		<%
			}
		%>
	</div>
	<%
		}
	%>
</body>
<script src="jquery/jq.js" type="text/javascript"></script>
<script type="text/javascript">
	$('#requestedProject').hide();
	function reqprobut(){
		$('#requestedProject').slideToggle();
	}
</script>
</html>