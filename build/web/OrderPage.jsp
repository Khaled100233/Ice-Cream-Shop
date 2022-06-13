<%-- 
    Document   : OrderPage
    Created on : Apr 26, 2022, 8:45:58 PM
    Author     : Ice Cream Shop
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="db" class="Classes.DataBase" scope="session" />
<%
    if(request.getAttribute("firstTime")==null){
        request.setAttribute("firstTime", "");
        request.setAttribute("mainFlavorMsg", "");                    //da ally bytl3 al msg bta3et al error
        request.setAttribute("extraScoopFlavorMsg", "");              //da ally bytl3 al msg bta3et al error
        request.setAttribute("checkToppingsMsg", "");                 //da ally bytl3 al msg bta3et al error
        request.setAttribute("checkMainFlavor", "none");              //da ally b5ly al error msg tzhr aw la
        request.setAttribute("checkExtraScoopFlavor", "none");        //da ally b5ly al error msg tzhr aw la
        request.setAttribute("checkToppings", "none");                //da ally b5ly al error msg tzhr aw la
        System.out.print("order page loaded");
    }
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
                            <<button class=" fa fa-sign-out" formaction="Logout.jsp" name="logout" value="signout" >
                                            Logout
                                    </button>
                            </label>
                        </form>
                    </div>
                    <div style="background-color: palegoldenrod; width:400px; padding-top: 20px; border-radius: 20px; border: solid teal; box-shadow: 5px 10px 30px black;">
                            <form action="OrderConfiguration.jsp" method="get">
                                <div>
					<span class="login100-form-title p-b-49">
						Order Page
					</span>
                                    <div style="margin-left: 25%">
					<div >
                                            <span >Ice Cream type:</span><br>
                                            <pre><input type="radio" name="iceCreamType" checked value="cup">cup <input type="radio" name="iceCreamType" value="cone">cone<br></pre>
						
					</div>
					<div>
                                            <span >scoops:</span><br>
                                            	
					</div>
					<div>
                                            <span>Main scoop flavor:</span><br><span style="color: red; display: <%= request.getAttribute("checkMainFlavor") %>;" ><%= request.getAttribute("mainFlavorMsg") %></span>
                                            <br>
                                        <select name="mainFlavor">
                                            <option value=" ">
                                                please choose the flavor
                                            </option>
                                            <%
                                                ResultSet rs=db.getFlavors();
                                                while(rs.next()){
                                            %>
                                            <option value='<%=rs.getString("fname")%>'>
                                                <%= rs.getString("fname") + "  " + rs.getInt("quantity")+ "  " + rs.getDouble("price")+ "LE" %>
                                            </option>
                                            <%}%>
                                        </select ><br>
                                        <input type="checkbox" name="extraScoop" value="true" onclick="myFunction()" id="chkbx" > <label for="chkbx">extra scoop</label>
                                        <span style="color: red; display: <%= request.getAttribute("checkExtraScoopFlavor") %>;" ><%= request.getAttribute("extraScoopFlavorMsg") %></span>
                                        </div>
                                        <div id="s" style="display:none;">
                                            <span>2nd scoop flavor:</span><br>
                                        <select name="extraScoopFlavor">
                                            <option>
                                                please choose the flavor
                                            </option>
                                            <%
                                                
                                                rs.close();
                                                rs=db.getFlavors();
                                                while(rs.next()){     
                                            %>
                                            <option value='<%=rs.getString("fname")%>'>
                                            <%= rs.getString("fname") + "  " + rs.getInt("quantity")+ "  " + rs.getDouble("price")+ "LE" %>
                                            </option>
                                            <%}
                                           
                                            %>
                                        </select>
                                            <script type="text/javascript">
                                                function myFunction() {
                                                var x = document.getElementById("s");
                                                if(x.style.display==="none")
                                                    x.style.display="block";
                                                else
                                                    x.style.display="none";
}

                                                </script>
                                        </div>
                                        <div>
                                            <input type="checkbox" name="topping" value="true" onclick="func3()" id="toppingss"><label for="toppingss">add toppings</label>
                                            <br><span style="color: red; display: <%= request.getAttribute("checkToppings") %>;" ><%= request.getAttribute("checkToppingsMsg") %></span>
					</div>
                                        
					<div id="t" style="display:none;overflow:scroll; height: 100px">
                                            <%
                                                rs.close();
                                                rs=db.getToppings();
                                                while(rs.next()){
                                            %>
                                            <input type="checkbox" name="toppings" value='<%=rs.getString("tname")%>'>
                                            <%= rs.getString("tname") + "  " + rs.getInt("quantity")+ "  " + rs.getDouble("price")+ "LE" %><br>
                                            <%}%>
                                        <br>
					</div>
                                        <script>
                                            function func3(){
                                                var x = document.getElementById("t");
                                                if(x.style.display==="none"){
                                                    x.style.display="block";
                                                }
                                                else{
                                                    x.style.display="none";
                                                }
                                            }
                                            
                                        </script>
                                        <br>
                                    </div>
                                        <div class="counter">
                                            <span >quantity:</span><br>
                                            <span class="down" onclick='decreaseCount(event,this)'>-</span>
                                            <input type="text" name="quantity" value="1">
                                            <span class="up" onclick='increaseCount(event,this)'>+</span>
					</div>
                                        <script type="text/javascript">
                                        function increaseCount(a, b) {
                                        var input = b.previousElementSibling;
                                         var value = parseInt(input.value, 10);
                                         value = isNaN(value) ? 0 : value;
                                         value++;
                                         input.value = value;
                                         }
                                        function decreaseCount(a, b) {
                                          var input = b.nextElementSibling;
                                          var value = parseInt(input.value, 10);
                                          if (value > 1) {
                                            value = isNaN(value) ? 0 : value;
                                            value--;
                                            input.value = value;
                                          }
                                        }
                                        </script><br>
                                        <div class="container-login100-form-btnO">
                                            <div class="wrap-login100-form-btnO">
                                                <div class="login100-form-bgbtnO"></div>
                                                    <button class="login100-form-btnO" type="submit" formaction="OrderConfiguration.jsp" name="Confirm" value="Add to Cart">
                                                            Add to Cart
                                                    </button>
                                            </div>
                                </div><br>
                                        <div class="container-login100-form-btnO">
                                            <div class="wrap-login100-form-btnO">
                                                <div class="login100-form-bgbtnO"></div>
                                                <button class="login100-form-btnO" type="submit" formaction="OrderConfiguration.jsp" name="Confirm" value="Check out">
                                                        Check Out
                                                </button>
                                            </div>
                                        </div><br>
                                </div>
                                                 </div>
                    
                            </form>
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
