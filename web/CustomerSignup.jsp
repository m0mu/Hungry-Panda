<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="Error.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/signInPage.css" rel="stylesheet">
    <title>Sign Up</title>
</head>
<body>
<div class="jumbotron">
    <div class="container">
        <h1>Hungry Panda</h1>
    </div>
    <div class="nav">
        <center><h2>Customer - Sign Up</h2>

            <form action="CustomerSignupDetails.jsp" method="post">
                <br/>Name:<input type="text" name="name" required>
                <br/>
                <br/>Username:<input type="text" name="username" required>
                <br/>
                <br/>Password:<input type="password" name="password" required>
                <br/>
                <br/>Mobile Number:<input type="number" min="1" maxlength="10" name="mobile" required>
                <br/>
                <br/>Room:<input type="text" name="room" required>
                <br/>
                <br/><input type="submit" value="Submit">
            </form>
        </center>
    </div>
</div>
</body>
</html>
