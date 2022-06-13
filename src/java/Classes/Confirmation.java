/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


//mail
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
//------------------------------------
/**
 *
 * @author Ehab Attia
 */
@WebServlet(name = "Confirmation", urlPatterns = {"/Confirmation"})
public class Confirmation extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        response.setContentType("text/html");
        HttpSession session= request.getSession();
        //System.out.println("session is---------:  "+ session.getAttribute("isSession"));
        if(!session.getAttribute("flag").equals("")){
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        Account account= (Account)session.getAttribute("account");
        Order order=(Order)session.getAttribute("Order");
        order.confirmOrder();
        try {
            sendMail(account, order);
        } catch (Exception ex) {
            Logger.getLogger(Confirmation.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(request.getParameter("Confirm").equals("confirm")){
            request.getRequestDispatcher("Logout.jsp").forward(request, response);
        }
        if(request.getParameter("Confirm").equals("order again")){
            session.removeAttribute("Order");
            request.getRequestDispatcher("OrderPage.jsp").forward(request, response);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        
    }
    
    public static void sendMail(Account account, Order order) throws MessagingException
    {
        String to= account.getEmail();
        Properties properties=new Properties();
        properties.put("mail.smtp.auth","true");
        properties.put("mail.smtp.starttls.enable","true");
        properties.put("mail.smtp.host","smtp.gmail.com");
        properties.put("mail.smtp.port","587");
        String myAccount="icecreamprojectaast@gmail.com";
        String Pass="ElGamden1";
        Session session=Session.getInstance(properties, new Authenticator(){
            @Override
            protected PasswordAuthentication getPasswordAuthentication()
            {
             return new PasswordAuthentication (myAccount,Pass);
            }
        });
        Message message=prepareMessage(session,myAccount,to,order);
        Transport.send(message);
        System.out.println("message send successfully");
    }

    private static Message prepareMessage(Session session, String myAccount, String to, Order order) {
        try {
            Message message=new MimeMessage(session);
            message.setFrom(new InternetAddress(myAccount));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject("Order Confirmation");
            
            
            
            
            String htmlCode="<h1>Order Confirmation</h1>"
                    + "<h3>you've ordered icecream from icecream shop"
                    + "<br> your total order is "+ order.getTotalCost() + " LE</h3>";
            
            
            
            
            
            message.setContent(htmlCode, "text/html");
            //message.setText("hey there,\nlook my email");
            return message;
        } catch (Exception ex) {
            Logger.getLogger(Confirmation.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
