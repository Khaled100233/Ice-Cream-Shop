<%-- 
    Document   : OrderConfiguration
    Created on : May 9, 2022, 4:04:38 PM
    Author     : Ice Cream Shop
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="iceCream" class="Classes.IceCream" scope="request"/>
<jsp:setProperty name="iceCream" property="*"/>
<jsp:useBean id="Order" class="Classes.Order" scope="session"/>
<%
    if( ! (session.getAttribute("flag").equals(""))){
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
    request.setAttribute("checkMainFlavor", "none");
    request.setAttribute("checkExtraScoopFlavor", "none");
    request.setAttribute("checkToppings", "none");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Configuration</title>
    </head>
    <body>
        <%
            if(request.getParameter("Confirm").equals("Check out")){
                //session.setAttribute("Order",Order);
        %>
        <jsp:forward page="Receipt.jsp"/>
        <%  }
            else if(request.getParameter("Confirm").equals("Add to Cart")){
        %>
        
        <%
            if(iceCream.getMainFlavor().equals(" ")){
                request.setAttribute("checkMainFlavor", "block");
                request.setAttribute("mainFlavorMsg", "*Please choose main flavor");
                request.setAttribute("firstTime", "");
        %>
        <jsp:forward page="OrderPage.jsp"/>
        <%}%>
        <%
            int counter=0;
            if(!iceCream.checkMainFlavor()){
                request.setAttribute("checkMainFlavor","block");
                request.setAttribute("mainFlavorMsg", "*The Flavor you've chosen is out of stock");
                counter++;
            }
            if(!iceCream.checkExtraScoopFlavor()){
                request.setAttribute("checkExtraScoopFlavor","block");
                request.setAttribute("extraScoopFlavorMsg", "*The Flavor you've chosen is out of stock");
                counter++;
            }
            if(!iceCream.checkToppings()){
                request.setAttribute("checkToppings", "block");
                request.setAttribute("checkToppingsMsg", "*One or more topping is out of stock");
                counter++;
            }
            if(counter>0){
                request.setAttribute("firstTime", "");
        %>
        <jsp:forward page="OrderPage.jsp"/>
        <%}
            Order.addItem(iceCream);
        %>
        <jsp:forward page="OrderPage.jsp"/>
        <%}%>
        
    </body>
</html>
