<%-- 
    Document   : index
    Created on : Apr 29, 2022, 9:25:47 PM
    Author     : Ice Cream Shop
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if( session.getAttribute("flag") == null)
        session.setAttribute("flag", session.getId());
%>
<%
    Cookie c[]=request.getCookies();
    String userName="", password="";
    boolean remember=false;
    //System.out.println("cookie 1 is: " + c[0].getName());
    //System.out.println("cookie 2 is: " + c[1].getName());
    //System.out.println("cookie length is: ");
    //System.out.println(c.length);
    if(c != null){
        for(int i=0; i<c.length;i++){
            if(c[i].getName().equals("rememberMe") && c[i].getValue().equals("remember")){
                remember=true;
                break;
            }
        }
    }
    if(remember){
        for(int i=0;i<c.length;i++){
            if(c[i].getName().equals("userName")){
                userName=c[i].getValue();
            }
            if(c[i].getName().equals("password")){
                password=c[i].getValue();
            }
        }
    }
    
    
    if(request.getAttribute("isValidSubmission")==null)
        request.setAttribute("isValidSubmission", "hidden");
    
%>

<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      	<title>Login</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="indexpage/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="indexpage/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="indexpage/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="indexpage/fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="indexpage/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="indexpage/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="indexpage/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="indexpage/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="indexpage/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="indexpage/css/util.css">
	<link rel="stylesheet" type="text/css" href="indexpage/css/main.css">
<!--===============================================================================================-->

    </head>
<body>
	
    <div class="limiter">
        <div class="container-login100" style="background-image: url('indexpage/images/bg-01.jpg');">
            <div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
                <form class="login100-form validate-form" method="post">
                    <span class="login100-form-title p-b-49">
                            Login
                    </span>
                    
                    <div class="wrap-input100 validate-input m-b-23" >
                            <span class="label-input100">Username</span>
                            <input class="input100" type="text" name="userName" required placeholder="Type your username" value='<%= userName %>'>
                            <span class="focus-input100" data-symbol="&#xf206;"></span>
                    </div>

                    <div class="wrap-input100 validate-input" data-validate="Password is required">
                            <span class="label-input100">Password</span>
                            <input class="input100" type="password" name="password" required placeholder="Type your password" value='<%= password %>'>
                            <span class="focus-input100" data-symbol="&#xf190;"></span>
                    </div>

                    <div>
                        <strong>
                            <span class="label-input100">
                                <span style="color: red;" <%=request.getAttribute("isValidSubmission")%> >
                                    *Incorrect username or password
                                </span>
                            </span>
                        </strong>
                    </div>

                    <div>
                        <input id="remember" type="checkbox" name="rememberMe" value="remember">
                        <strong><span class="label-input100">
                                <label for="remember">Remember Me</label></span></strong>
                    </div>
                    <div class="container-login100-form-btn">
                            <div class="wrap-login100-form-btn">
                                    <div class="login100-form-bgbtn"></div>
                                    <button class="login100-form-btn" formaction="SigningConfigurations.jsp" name="action" value="signin">
                                            Login
                                    </button>
                            </div>
                    </div>

                    <div class="flex-col-c p-t-155">
                            <span class="txt1 p-b-17">
                                    Or 


                            <a href="register.jsp" class="txt2">
                                    Sign Up
                            </a>
                            </span>
                    </div>
                </form>
            </div>
        </div>
    </div>
	

	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>
