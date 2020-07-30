<!-- 
Login
control transfered to LoginCheck.java(servlet)
Registration button-> signup.jsp
 -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="javax.servlet.http.HttpSession,java.util.*"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<title>Login</title>
</head>
<body>
		<div class="container col-4">
			<form action="LoginCheck" method="post">
				<br>
				<center><h3><i>Username</i></h3></center>
				<input type="text" name="uemail" placeholder="Enter email" class="form-control"> <br>
				
				<center><h3><i>Password</i></h3></center>
				<input type="password" name="upass" placeholder="Enter password" class="form-control"> <br> 
				<center><input type="submit" class="btn btn-primary"></center>
			</form>
		</div>
		<br>
		<center><a href="signup.jsp" class="btn btn-primary" title="Not Registered?">Register</a></center>
</body>
</html>