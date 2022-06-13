<%--
    Document   : Receipt
    Created on : May 12, 2022, 7:32:50 PM
    Author     : Ice Cream Shop
--%>
<%@page import="Classes.Order"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="db" class="Classes.DataBase" scope="page" />
<%
        Order order= (Order)session.getAttribute("Order");
%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>order page</title>
        <link rel="icon" type="image/png" href="orderpage/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="orderpage/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="orderpage/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="orderpage/fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="orderpage/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="orderpage/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="orderpage/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="orderpage/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="orderpage/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="orderpage/css/util.css">
	<link rel="stylesheet" type="text/css" href="orderpage/css/main.css">
<!--===============================================================================================-->
<style>
    .counter{
       width: 150px;
    margin: auto;
    display: flex;
    align-items: center;
    justify-content: center; 
    }
    .counter input {
    width: 50px;
    border: 0;
    line-height: 30px;
    font-size: 20px;
    text-align: center;
    background: #0052cc;
    color: #fff;
    appearance: none;
    outline: 0;
}
.counter span {
    display: block;
    font-size: 25px;
    padding: 0 10px;
    cursor: pointer;
    color: #0052cc;
    user-select: none;
}
.logout{
    position:fixed;
    right:10px;
    top:5px;
}
.container-login100-form-btnO {
  display: -webkit-box;
  display: -webkit-flex;
  display: -moz-box;
  display: -ms-flexbox;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}
.wrap-login100-form-btnO {
  width: 30%;
  display: block;
  position: relative;
  z-index: 1;
  border-radius: 25px;
  overflow: hidden;
  margin: 0 auto;

  box-shadow: 0 5px 30px 0px /gba(3, 216, 222, 0.2);
  -moz-box-shadow: 0 5px 30px 0px rgba(3, 216, 222, 0.2);
  -webkit-box-shadow: 0 5px 30px 0px rgba(3, 216, 222, 0.2);
  -o-box-shadow: 0 5px 30px 0px rgba(3, 216, 222, 0.2);
  -ms-box-shadow: 0 5px 30px 0px rgba(3, 216, 222, 0.2);
}
.login100-form-bgbtnO {
  position: absolute;
  z-index: -1;
  width: 300%;
  height: 100%;
  
  background: #a64bf4;
  background: -webkit-linear-gradient(right, #00dbde, #fc00ff, #00dbde, #fc00ff);
  background: -o-linear-gradient(right, #00dbde, #fc00ff, #00dbde, #fc00ff);
  background: -moz-linear-gradient(right, #00dbde, #fc00ff, #00dbde, #fc00ff);
  background-image: linear-gradient(to right, #16222A 0%, #3A6073  51%, #16222A  100%);
  top: 0;
  left: -100%;

  -webkit-transition: all 0.4s;
  -o-transition: all 0.4s;
  -moz-transition: all 0.4s;
  transition: all 0.4s;
}
.login100-form-btnO {
  font-family: Poppins-Medium;
  font-size: 16px;
  color: #fff;
  line-height: 1.2;
  text-transform: uppercase;

  display: -webkit-box;
  display: -webkit-flex;
  display: -moz-box;
  display: -ms-flexbox;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 0 20px;
  width: 100%;
  height: 50px;
}
.wrap-login100-form-btnO:hover .login100-form-bgbtnO {
  /*left: 0;*/
  background-position: right center; /* change the direction of the change here */
  color: #fff;
  text-decoration: none;
}
</style>
    </head>
    <body>

        <div class="limiter">
		<div class="container-login100" style="background-image: url('orderpage/images/wallpaperflare.com_wallpaper.jpg');">
                    <div>
                        <form action="OrderConfiguration.jsp" method="get">
                        <label style="algin:right" class="logout">
                        <<button class=" fa fa-sign-out" formaction="Logout.jsp" name="logout" value="signout">
                                            Logout
                                    </button>
                            </label>
                        </form>
                    </div>
                    <div style="background-color: #ffc0a8; padding-top: 20px; border-radius: 20px; border: solid teal; box-shadow: 5px 10px 30px black">
                        <form action="OrderConfiguration.jsp" method="get" >
                                <div>
					<span class="login100-form-title p-b-49">
						Order Receipt
					</span>
                                    <div style="margin-left: 5%; margin-right: 5%">
                                        <table border="0px" width="600px">
                                            <tr>
                                                <td >Items</td>
                                                <td style="text-align: center">Quantity</td>
                                                <td style="text-align: center">Price</td>
                                            </tr>
                                            <%for(int i=0;i<order.getItems().size();i++){%>
                                                    <tr>
                                                        <td width="200px" style="color: #1d21ac"><b><%= order.getItems().get(i).getMainFlavor() + " Icecream"%></b></td>
                                                        <td width="200px" style="text-align: center"><%= order.getItems().get(i).getQuantity() %></td>
                                                        <td width="200px" style="text-align: center"><%= order.getItems().get(i).calculateTotal() + "LE" %></td>  
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3">
                                                            <%= "Main Flavor : "+order.getItems().get(i).getMainFlavor() %><br>
                                                            <% if(order.getItems().get(i).isExtraScoop()) {%>
                                                            <%= "Extra Flavor: "+order.getItems().get(i).getExtraScoopFlavor() %><br><%}%>
                                                            <% if(order.getItems().get(i).isTopping()) {for(int j=0;j<order.getItems().get(i).getToppings().length;j++) {%>
                                                            <%= "Topping "+(j+1)+": "+order.getItems().get(i).getToppings()[j]%><br><%}}%><br>
                                                            
                                                        </td>
                                                    </tr>
                                                    <%}%>
                                                    <tr>
                                                        <td colspan="2"></td>
                                                        <td style="text-align: center; color: #1d21ac"><b>Total</b></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2"></td>
                                                        <td style="text-align: center; color: #1d21ac"><b><%= order.getTotalCost()+"LE" %></b></td>
                                                    </tr>
                                        </table>
                                        
                                    </div>
                                        <div class="container-login100-form-btnO">
                                                <div class="wrap-login100-form-btnO">
                                                        <div class="login100-form-bgbtnO"></div>
                                                        <button class="login100-form-btnO" type="submit" formaction="Confirmation" name="Confirm" value="confirm">
                                                                Confirm & Log Out
                                                        </button>
                                                </div>
                                        </div><br>
                                        <div class="container-login100-form-btnO">
                                                <div class="wrap-login100-form-btnO">
                                                        <div class="login100-form-bgbtnO"></div>
                                                        <button class="login100-form-btnO" type="submit" formaction="Confirmation" name="Confirm" value="order again">
                                                                Confirm & Order Again
                                                        </button>
                                                </div>
                                        </div><br>
                                </div>
				</form>
			</div>
		</div>
        </div>
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

