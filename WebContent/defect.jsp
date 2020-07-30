<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<title>Defect</title>
</head>
<body>	
	<%
	if(session.getAttribute("uid")==null)
	{
		response.sendRedirect("login.jsp");
	}
	else{
	%>
		<div class="container col-4">
			<form action="defectInsert.jsp" method="post">
				<br>
				<h5>
					<center><i>Defect Type</i></center>
				</h5>
				<select required class="form-control" name="deftype">
					<option hidden>select</option>
					<option>Bug</option>
					<option>select</option>
					<option>select</option>
				</select> <br>
				<h5>
					<center><i>Defect Priority</i></center>
				</h5>
				<select required class="form-control" name="defpriority">
					<option hidden>select</option>
					<option>High</option>
					<option>Medium</option>
					<option>Low</option>
				</select> <br>
				<h5>
					<center><i>Description</i></center>
				</h5>
				<textarea class="form-control" rows="4" cols="10" maxlength="50" placeholder="Describe about the defect" name="defdesc"></textarea>
				<br> 
				<center><input style="margin: 10px" type="submit" value="Report" class="btn btn-primary"></center>
			</form>
			<%
			if("add".equals((String)session.getAttribute("role"))){
			%>
			<br> <center><a class="btn btn-primary" href="adminProfile.jsp" style="margin: 10px">Profile</a></center>
			<br>
			<% 
			}
			else{
			%>
			<br> <center><a class="btn btn-primary" href="profile.jsp" style="margin: 10px">Profile</a></center>
			<br>
			<%
			}
	}
			%>
		</div>
</body>
</html>