<%@page contentType="text/html" language="java" pageEncoding="UTF-8" %>
<%
    String check = (String) session.getAttribute("sessionVendor");
    if (check != null) { %>
<script>
    window.location = 'VendorHome.jsp';
</script>
<%
} else { %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/signInPage.css" rel="stylesheet">

    <meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id"
          content="825738061208-8a4hlv9as929mdpl3k6pig6ldvl8bpsd.apps.googleusercontent.com">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer></script>

    <title>Sign In</title>
</head>
<body>

<div class="jumbotron">

    <div class="container">
        <h1>Hungry Panda</h1>
    </div>

    <div class="nav">
        <center><h2>Vendor - Sign In</h2>
            <form action="VendorLoginCheck.jsp" method="post">
                <br/>Username:<input type="text" name="username" required>
                <br/>
                <br/>Password:<input type="password" name="password" required>
                <br/>
                <br/><input type="submit" value="Submit">
                <br/>
                <br/>Not registered? <a href="VendorSignup.jsp">Sign Up</a>
                <br/>
                <br/> Or Login using Gmail


                <div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div>
                <script>
                    function onSignIn(googleUser) {
                        // Useful data for your client-side scripts:
                        var profile = googleUser.getBasicProfile();
                        console.log("ID: " + profile.getId()); // Don't send this directly to your server!
                        console.log('Full Name: ' + profile.getName());
                        console.log('Given Name: ' + profile.getGivenName());
                        console.log('Family Name: ' + profile.getFamilyName());
                        console.log("Image URL: " + profile.getImageUrl());
                        console.log("Email: " + profile.getEmail());

                        // The ID token you need to pass to your backend:
                        var id_token = googleUser.getAuthResponse().id_token;
                        console.log("ID Token: " + id_token);
                        var url = "ajax/checkAuthVendors.jsp";

                        $.ajax({
                            type: 'POST',
                            url: url,
                            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                            dataType: "json",
                            data: {id: googleUser.getAuthResponse().id_token},
                            success: function (response) {
                                $('#info-modal .modal-title #spinner').remove();
                                if (response && response.status == 0) {
                                    //location.pathname = location.pathname.replace(/(.*)\/[^/]*/, "$1/"+ 'dashboard');
                                    alert("logged in as " + response.email + " name = " + response.name);
                                    window.location = 'VendorHome.jsp';
                                }
                                else {
                                    //LOG("Showing error");
                                    alert('Error: ' + response.error);
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert('There was an unexpected error in connecting to the server');
                            },
                        });
                    }
                </script>
            </form>
        </center>
    </div>

</div>

</body>
</html>
<%
    }
%>