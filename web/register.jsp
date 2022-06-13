<%-- 
    Document   : register
    Created on : Apr 29, 2022, 9:27:09 PM
    Author     : Ice Cream Shop
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="account" class="Classes.Account" scope="page"/>
<jsp:setProperty name="account" property="*"/>
<%
    if(request.getAttribute("firstTime")==null){
        request.setAttribute("firstTime", "");
        request.setAttribute("isValidUser", "hidden");
        request.setAttribute("isValidPassword", "hidden");
        request.setAttribute("isValidAddress", "hidden");
        request.setAttribute("isValidPhone","hidden");
        request.setAttribute("isValidEmail","hidden");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Colorlib Templates">
    <meta name="author" content="Colorlib">
    <meta name="keywords" content="Colorlib Templates">

    <!-- Title Page-->
    <title>Sign Up</title>

    <!-- Icons font CSS-->
    <link href="signuppage/vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
    <link href="signuppage/vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">
    <!-- Font special for pages-->
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Vendor CSS-->
    <link href="signuppage/vendor/select2/select2.min.css" rel="stylesheet" media="all">
    <link href="signuppage/vendor/datepicker/daterangepicker.css" rel="stylesheet" media="all">

    <!-- Main CSS-->
    <link href="signuppage/css/main.css" rel="stylesheet" media="all">
    </head>
    <body>
    <div class="page-wrapper bg-gra-02 p-t-130 p-b-100 font-poppins" >
        <div class="wrapper wrapper--w680">
            <div class="card card-4">
                <div class="card-body">
                    <h2 class="title">Registration Form</h2>
                    <form action="signup.jsp" method="post">
                        <div class="row row-space">
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">
                                        User name
                                        <span style="color: red; font-size: 10px" <%= request.getAttribute("isValidUser") %> >
                                            
                                            <% System.out.print("is Valid UserName state = "+request.getAttribute("isValidUser")); %>
                                            <b>*Choose another username</b>
                                        </span>
                                    </label>
                                    <input class="input--style-4" type="text" name="userName" title="User.name can consist of letters & numbers" value='<%if(account.getUserName()==null)
                                    {
                                        out.print("");  
                                    }
                                    else
                                    out.print(account.getUserName());
                                    %>'>
                                    
                                </div>
                            </div>
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">
                                        Password
                                        <span style="color: red; font-size: 10px" <%= request.getAttribute("isValidPassword") %> >
                                            <% System.out.print("is Valid Password state = "+request.getAttribute("isValidPassword")); %>
                                            <b>*Enter Password</b>
                                        </span>
                                    </label>
                                    <input class="input--style-4" type="password" name="password" title="Password must be more than 8 characters & have both letters & numbers" value='<%if(account.getPassword()==null)
                                    {
                                       // out.print("");  
                                    }
                                    else
                                    out.print(account.getPassword());
                                    %>'>
                                </div>
                            </div>
                        </div>
                        <div class="row row-space">
                            <div class="col-4">
                                <div class="input-group">
                                    <label class="label">
                                        Address
                                        <span style="color: red; font-size: 10px" <%= request.getAttribute("isValidAddress") %> >
                                            <% System.out.print("is Valid Address state = "+request.getAttribute("isValidAddress")); %>
                                            <% System.out.print("================================================================="); %>
                                            <b>*Enter Address</b>
                                        </span>
                                    </label>
                                    <div class="input-group-icon">
                                        <input class="input--style-4" type="text" name="address" title="Please enter a Valid Address" value='<%if(account.getAddress()==null)
                                    {
                                        out.print("");  
                                    }
                                    else
                                    out.print(account.getAddress());
                                    %>'>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row row-space">
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">Email
                                    <span style="color: red; font-size: 10px" <%= request.getAttribute("isValidEmail") %> >
                                            <% System.out.print("is Valid Email state = "+request.getAttribute("isValidEmail")); %>
                                            <% System.out.print("================================================================="); %>
                                            <b>*Enter Email</b>
                                        </span>
                                    </label>
                                    <input class="input--style-4" type="email" name="email" title="Please enter a Valid Email" value='<%if(account.getEmail()==null)
                                    {
                                        out.print("");  
                                    }
                                    else
                                    out.print(account.getEmail());
                                    %>'>
                                </div>
                            </div>
                            <div class="col-2">
                                <div class="input-group">
                                    <label class="label">Phone Number
                                    <span style="color: red; font-size: 10px" <%= request.getAttribute("isValidPhone") %> >
                                            
                                            <b>*Enter Phone number</b>
                                        </span>
                                    </label>
                                    <input class="input--style-4" type="text" name="phone" title="Phone Number Must consist of 11 digit" value='<%if(account.getPhone()==null)
                                    {
                                        out.print("");  
                                    }
                                    else
                                    out.print(account.getPhone());
                                    %>'>
                                </div>
                            </div>
                        </div>
                        <div>
                            <input id="remember" type="checkbox" name="rememberMe" value="remember" checked hidden>		
                        </div>
                        <div class="p-t-15">
                            <button class="btn btn--radius-2 btn--blue" type="submit" formaction="SigningConfigurations.jsp" name="action" value="signup">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Jquery JS-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <!-- Vendor JS-->
    <script src="vendor/select2/select2.min.js"></script>
    <script src="vendor/datepicker/moment.min.js"></script>
    <script src="vendor/datepicker/daterangepicker.js"></script>

    <!-- Main JS-->
    <script src="js/global.js"></script>

</body>

</html>
