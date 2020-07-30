<!-- 
 session expired->login.jsp
 uid from session
 control 1-> projectDetails with pid-hidden, pname
 slidder 1-> defects assigned by me(assignedtome)
 slidder 2-> defects reported to me(reportedbyme)
 control 2-> project.jsp(add new project, no parameters)
 control 3-> Logout.java(session logout, no parameters)
 -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	import="java.sql.*" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<style>
table {
	border: 1px solid black;
}

table tr td {
	border: 1px solid black;
}

table tr th {
	border: 1px solid black;
}
</style>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<title>Welcome</title>
</head>
<body>
<div class="container col-8">
		<%
			if (session.getAttribute("uid") == null) {
				response.sendRedirect("login.jsp");
			} else {
		%>
		<center>
			<h3 style="width: 50%;">Accessible Project</h3>
		</center>
		<%
				int uid = (int) session.getAttribute("uid");
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/defect", "root", "root");
				Statement st = con.createStatement();

				ResultSet rs1 = st.executeQuery("select projects from user where uid = " + uid);
				int myproject[] = null;
				if (rs1.next()) {
					String[] getpro = rs1.getString(1).split(" ");
					myproject = new int[getpro.length];
					for (int i = 0; i < getpro.length; i++) {
						myproject[i] = Integer.parseInt(getpro[i]);
					}
					rs1.close();
					rs1 = st.executeQuery("select * from projectList where pinclude=1");
					while (rs1.next()) {
						int pid = rs1.getInt(1);
						for (int i : myproject) {
							if (i == pid) {
		%>
		<form action="projectDetail.jsp" method="post">
			<input type="text" name="pid" value="<%=rs1.getInt(1)%>" hidden="true"> 
			<center><input class="form-control col-3" type="submit" name="pname" value="<%=rs1.getString(2)%>"></center>
		</form>
		<%
			}
						}
					}
				}
				rs1.close();
		%>
		<br>
		<center><button class="btn btn-primary" onclick="assignedtome()">Defects Assigned to me</button>
		<button class="btn btn-primary" onclick="reportedbyme()">Defects Reported by me</button></center>
		<%
			Statement st1 = con.createStatement(), st2 = con.createStatement(), st3 = con.createStatement();
				ResultSet rs2, rs3;
		%>

		<div id="assignedtome">
		<center>
			<h3>Defects Assigned To Me</h3>
			<table class="table table-striped">
				<tr>
					<th>Defect Type</th>
					<th>Priority</th>
					<th>Project Name</th>
					<th>Status</th>
				</tr>
				<%
					rs1 = st1.executeQuery("select * from defectdetails where assignedTo = " + session.getAttribute("uid"));
						while (rs1.next()) {
							rs2 = st2.executeQuery("select pname from projectlist where pid = " + rs1.getInt("pid"));
							rs2.next();
				%>
				<tr>
					<td><%=rs1.getString("dtype")%></td>
					<td><%=rs1.getString("dpriority")%></td>
					<td><%=rs2.getString("pname")%></td>
					<td><%=rs1.getString("status")%></td>
				</tr>
				<br>
				<%
					rs2.close();
						}
						rs1.close();
				%>
			</table>
			</center>
		</div>

		<div id="reportedbyme">
			<center>
			<h3>Defects Reported By Me</h3>
			<table class="table table-striped">
				<tr>
					<th>Defect Type</th>
					<th>Priority</th>
					<th>Project Name</th>
					<th>Assigned To</th>
					<th>Status</th>
				</tr>
				<%
					rs1 = st1.executeQuery("select * from defectdetails where uid = " + session.getAttribute("uid"));
						while (rs1.next()) {
							String assignedTo = "";
							rs2 = st2.executeQuery("select pname from projectlist where pid = " + rs1.getInt("pid"));
							rs2.next();
							if (rs1.getInt("assignedto") != -1) {
								rs3 = st3.executeQuery("select uname from user where uid = " + (int) rs1.getInt("assignedTo"));
								rs3.next();
								assignedTo = rs3.getString("uname");
								rs3.close();
							} else {
								assignedTo = "Not Assigned";
							}
				%>
				<tr>
					<td><%=rs1.getString("dtype")%></td>
					<td><%=rs1.getString("dpriority")%></td>
					<td><%=rs2.getString("pname")%></td>
					<td><%=assignedTo%></td>
					<td><%=rs1.getString("status")%></td>
				</tr>
				<br>
				<%
					rs2.close();
						}
						rs1.close();
				%>
			</table>
			</center>
		</div>
		<br>
			<form action="project.jsp">
				<center><input type="submit" class="btn btn-primary" value="Add New Project"></center>
			</form>
		<br>
		<form action="Logout" method="post">
			<center><input type="submit" value="Logout" class="btn btn-primary"></center>
		</form>
		<%
			}
		%>

</div>
</body>
<script src="jquery/jq.js" type="text/javascript"></script>
<script type="text/javascript">
	$("div div").hide();
	function reportedbyme() {
		$("#reportedbyme").slideToggle();
	}
	function assignedtome() {
		$("#assignedtome").slideToggle();
	}
</script>
</html>