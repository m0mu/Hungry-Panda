<%@page contentType="text/html" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/logout.css" rel="stylesheet">
    <title>Logout</title>
</head>
<body>
<% session.removeAttribute("username");
    session.invalidate();
%>
<script>
    alert("Logout Successful. Thank You for using HungryPanda");
    window.location = 'index.jsp';
</script>
</body>
</html>
