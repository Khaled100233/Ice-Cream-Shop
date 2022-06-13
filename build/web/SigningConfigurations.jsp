<%-- 
    Document   : SigningConfigurations
    Created on : Apr 30, 2022, 12:54:35 PM
    Author     : Ice Cream Shop
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="account" class="Classes.Account" scope="session" />
<jsp:setProperty name="account" property="*" />
<jsp:useBean id="db" class="Classes.DataBase" scope="session" />
<%
    session.setAttribute("flag", "");
    int counter=0;
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Signing Configuration</title>
    </head>
    <body>
        <%
            if( request.getParameter("action").equals("signin") ){//sign in
                if(request.getParameter("rememberMe")!=null){
                Cookie rememberMe=new Cookie("rememberMe","remember");
                rememberMe.setMaxAge(60*60*24);
                response.addCookie(rememberMe);

                Cookie userName=new Cookie("userName", account.getUserName());
                Cookie password=new Cookie("password", account.getPassword());
                userName.setMaxAge(60*60*24);
                password.setMaxAge(60*60*24);
                response.addCookie(userName);
                response.addCookie(password);
            }
        %>
<!--==============Sign In=====================================================================================================================================-->
        
        <%
        if(db.login(account)){
            account.setEmail(db.retrieveEmail(account));
        %>
        <jsp:forward page="OrderPage.jsp"/>
        <%
        }
        else{
            request.setAttribute("isValidSubmission", "invalid");
        %>
        <jsp:forward page="index.jsp"></jsp:forward>
        <%
        }
        }
        //========Sign UP====================================================================================
        else if(request.getParameter("action").equals("signup")){
        %>
        
<%--===================================================================================================================================================--%>
        
        <%
        if(account.getUserName()==null || !(db.isValidUserName(account))){
            counter++;
            request.setAttribute("isValidUser", "not valid");//not valid
            System.out.print("counter is "+counter+" and state of username is "+ request.getAttribute("isValidUser"));
        }
        else{
            request.setAttribute("isValidUser", "hidden");//not valid
        }
        if(account.getAddress()==null){
            counter++;
            request.setAttribute("isValidAddress", "not valid");//not valid
            System.out.print("counter is "+counter+" and state of address is "+ request.getAttribute("isValidAddress"));
        }
        else{
            request.setAttribute("isValidAddress", "hidden");
        }
        if(account.getPassword()==null){
            counter++;
            //request.setAttribute("isValidUser", "not valid");//not valid/////////////////////////needs to be revised
            request.setAttribute("isValidPassword", "not valid");//not valid
            System.out.print("counter is "+counter+" and state of password is "+ request.getAttribute("isValidPassword"));
        }
        else
        {
            request.setAttribute("isValidPassword", "hidden");
        }
        if(account.getPhone()==null)
        {
            counter++;
            request.setAttribute("isValidPhone","not valid");
             System.out.print("counter is "+counter+" and state of phone is "+ request.getAttribute("isValidPhone"));
        }
        else{
            request.setAttribute("isValidPhone","hidden");
        }
        if(account.getEmail()==null)
        {
             counter++;
            request.setAttribute("isValidEmail","not valid");
             System.out.print("counter is "+counter+" and state of Email is "+ request.getAttribute("isValidEmail"));
        }
        else{
            request.setAttribute("isValidEmail","hidden");
        }
        if(counter>0){
            request.setAttribute("firstTime", "");
%>
<jsp:forward page="register.jsp" />
<%
        }
        if(db.register(account)){
%>
<jsp:forward page="index.jsp"/>
<%}
        else{
        %>
        <strong>Account already exists</strong>
        <jsp:include page="register.jsp"></jsp:include>
        <%
        }
        }
        %>
    </body>
</html>
