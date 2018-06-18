<%@page import="authenticate.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="Error.jsp" %>


<%
    String nameString = request.getParameter("name");
    String usernameString = request.getParameter("username");
    String passwordString = request.getParameter("password");
    String mobileString = request.getParameter("mobile");
    String outletNameString = request.getParameter("outletName");

    if (SignUp.vendorUsernameAlreadyExists(usernameString)) { %>
<script>
    alert("Username already exists, please try with a different username");
    window.location = 'VendorSignup.jsp';
</script>
<%
} else {
    SignUp.signUpVendor(nameString, usernameString, passwordString, mobileString, outletNameString); %>
<script>
    alert("Thank You for Registering with HungryPanda");
    window.location = 'VendorLogin.jsp';
</script>
<%
    }
%>


