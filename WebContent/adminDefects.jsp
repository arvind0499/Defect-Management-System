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
<title>Insert title here</title>
<style type="text/css">
table {
	border: 1px solid black;
}
table tr th {
	border: 1px solid black;
}

table tr td {
	border: 1px solid black;
}
</style>
</head>
<body>
<div class="container col-8">
	<%
		if (session.getAttribute("uid") == null) {
			response.sendRedirect("login.jsp");
		}
		else{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/defect", "root", "root");
		Statement st1 = con.createStatement(),st2 = con.createStatement(),st3 = con.createStatement();
		ResultSet rs1, rs2, rs3;
	%>
		
		<br>
		<center><button class="btn btn-primary" onclick="unsolved()">Unsolved Defects</button>
		<button class="btn btn-primary" onclick="solved()">Solved Defects</button>
		<button class="btn btn-primary" onclick="byme()">Reported by me</button>
		<button class="btn btn-primary" onclick="unassign()">Unassigned Defects</button></center>
		<br> 
		<center><a class="btn btn-primary" href="adminProfile.jsp">Profile</a></center>
		
		<br>
		<div id="unsol">
			<center><h3>Unsolved Defects</h3></center>
			<table class="table table-striped">
				<tr>
					<th>Defect Type</th>
					<th>Priority</th>
					<th>Project Name</th>
					<th>Assigned To</th>
					<th>Reported By</th>
					<th>Status</th>
				</tr>
				<%
					rs1 = st1.executeQuery("select * from defectdetails where status = 'open'");
					while (rs1.next()) {
						String assignedTo = "";
						rs2 = st2.executeQuery("select pname from projectlist where pid = " + (int)rs1.getInt("pid"));
						rs2.next();
						if(rs1.getInt("assignedto")!=-1){
							rs3 = st3.executeQuery("select uname from user where uid = " + (int)rs1.getInt("assignedTo"));
							rs3.next();
							assignedTo = rs3.getString("uname");
							rs3.close();
						}
						else{
							assignedTo = "Not Assigned";
						}
						rs3 = st3.executeQuery("select uname from user where uid = "+(int)rs1.getInt("uid"));
						rs3.next();
				%>
				<tr>
					<td><%=rs1.getString("dtype")%></td>
					<td><%=rs1.getString("dpriority")%></td>
					<td><%=rs2.getString("pname")%></td>
					<td><%=assignedTo %></td>
					<td><%=rs3.getString("uname") %></td>
					<td><%=rs1.getString("status")%></td>
				</tr>
				<br>
				<%
						rs3.close();
						rs2.close();
					}
					rs1.close();
				%>
			</table>
		</div>

		<div id="sol">
			<center><h3>Solved Defects</h3></center>
			<table class="table table-striped">
				<tr>
					<th>Defect Type</th>
					<th>Priority</th>
					<th>Project Name</th>
					<th>Assigned To</th>
					<th>Reported By</th>
					<th>Status</th>
				</tr>
				<%
					rs1 = st1.executeQuery("select * from defectdetails where status = 'close'");
					while (rs1.next()) {
						String assignedTo = "";
						rs2 = st2.executeQuery("select pname from projectlist where pid = " + rs1.getInt("pid"));
						rs2.next();
						if(rs1.getInt("assignedto")!=-1){
							rs3 = st3.executeQuery("select uname from user where uid = " + (int)rs1.getInt("assignedTo"));
							rs3.next();
							assignedTo = rs3.getString("uname");
							rs3.close();
						}
						else{
							assignedTo = "Not Assigned";
						}
						rs3 = st3.executeQuery("select uname from user where uid = "+(int)rs1.getInt("uid"));
						rs3.next();
				%>
				<tr>
					<td><%=rs1.getString("dtype")%></td>
					<td><%=rs1.getString("dpriority")%></td>
					<td><%=rs2.getString("pname")%></td>
					<td><%=assignedTo %></td>
					<td><%=rs3.getString("uname") %></td>
					<td><%=rs1.getString("status")%></td>
				</tr>
				<br>
				<%
						rs3.close();
						rs2.close();
					}
					rs1.close();
				%>
			</table>
		</div>

		<div id="repbyme">
			<center><h3>Defects Reported By Me</h3></center>
			<table class="table table-striped">
				<tr>
					<th>Defect Type</th>
					<th>Priority</th>
					<th>Project Name</th>
					<th>Reported To</th>
					<th>Status</th>
				</tr>
				<%
					rs1 = st1.executeQuery("select * from defectdetails where uid = " + session.getAttribute("uid"));
					while (rs1.next()) {
						String assignedTo = "";
						rs2 = st2.executeQuery("select pname from projectlist where pid = " + rs1.getInt("pid"));
						rs2.next();
						if(rs1.getInt("assignedto")!=-1){
							rs3 = st3.executeQuery("select uname from user where uid = " + (int)rs1.getInt("assignedTo"));
							rs3.next();
							assignedTo = rs3.getString("uname");
							rs3.close();
						}
						else{
							assignedTo = "Not Assigned";
						}
				%>
				<tr>
					<td><%=rs1.getString("dtype")%></td>
					<td><%=rs1.getString("dpriority")%></td>
					<td><%=rs2.getString("pname")%></td>
					<td><%=assignedTo %></td>
					<td><%=rs1.getString("status")%></td>
				</tr>
				<br>
				<%
						rs2.close();
					}
					rs1.close();
				%>
			</table>
		</div>

		<div id="unassign">
			<center><h3>Unsolved Defects</h3></center>
			<table class="table table-striped">
				<tr>
					<th>Defect Type</th>
					<th>Priority</th>
					<th>Project Name</th>
					<th>Assigned To</th>
					<th>Reported By</th>
					<th>Status</th>
				</tr>
				<%
					rs1 = st1.executeQuery("select * from defectdetails where assignedto = -1");
					while (rs1.next()) {
						rs2 = st2.executeQuery("select pname from projectlist where pid = " + rs1.getInt("pid"));
						rs2.next();
						rs3 = st3.executeQuery("select uname from user where uid = "+(int)rs1.getInt("uid"));
						rs3.next();
				%>
				<tr>
					<td><%=rs1.getString("dtype")%></td>
					<td><%=rs1.getString("dpriority")%></td>
					<td><%=rs2.getString("pname")%></td>
					<td><%="Not Assigned" %></td>
					<td><%=rs3.getString("uname") %></td>
					<td><%=rs1.getString("status")%></td>
					<td style="border: 1px solid white;">
						<form action="defectAssignment.jsp" method="post">
							<input type="text" name="did" value="<%=rs1.getInt("did")%>" hidden>
							<input type="submit" value="Assign">
						</form>
					</td>
				</tr>
				<br>
				<%
						rs3.close();
						rs2.close();
					}
					rs1.close();
				%>
			</table>
		</div>
		
		<%
		}
		%>

</div>
</body>
<script src="jquery/jq.js" type="text/javascript"></script>

<script type="text/javascript">
	$("div div").hide();
	function byme() {
		$("#repbyme").slideToggle();
	}
	function solved() {
		$("#sol").slideToggle();
	}
	function unsolved() {
		$("#unsol").slideToggle();
	}
	function unassign() {
		$("#unassign").slideToggle();
	}
</script>
</html>