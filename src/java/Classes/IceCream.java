/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;
import java.sql.*;
import java.util.logging.*;
/**
 *
 * @author Ehab Attia
 */
public class IceCream implements java.io.Serializable{//revise names in html form and class
    private int id;
    private String  iceCreamType;
    private String  mainFlavor, extraScoopFlavor;
    private boolean  extraScoop, topping;
    private int quantity;
    private String toppings[];

    public IceCream()
    {
        //extrascoopflavor initialize?
        this.extraScoop=false;
        toppings= new String[20];//mfrod n initalize el topping t2reban
        id=DataBase.reterieveMaxIceCreamId();
    }
    //momken nstkhdem final?
 //enum Flavor {vanilla, chocolate, strawberry, fudgeRipple, coffee,
              //   rockyRoad, mintChocolateChip, cookieDough}

    public int getId() {
        return id;
    }
    
    public String getIceCreamType() {
        return iceCreamType;
    }

    public void setIceCreamType(String iceCreamType) {
        this.iceCreamType = iceCreamType;
    }

    public String getMainFlavor() {
        return mainFlavor;
    }

    public void setMainFlavor(String mainFlavor) {
        this.mainFlavor = mainFlavor;
    }

    public boolean isExtraScoop() {
        return extraScoop;
    }

    public void setExtraScoop(boolean extraScoop ) {
        this.extraScoop = extraScoop;
    }

    public String getExtraScoopFlavor() {
        return extraScoopFlavor;
    }

    public void setExtraScoopFlavor(String extraScoopeFlavor) {
        if(isExtraScoop()){
            this.extraScoopFlavor = extraScoopeFlavor;
        }
    }

    public boolean isTopping() {
        return topping;
    }

    public void setTopping(boolean topping) {
        this.topping = topping;
    }
    
    public String[] getToppings() {
        return toppings;
    }

    public void setToppings(String[] toppings) {
        if(isTopping()){
            this.toppings = toppings;
        }
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public boolean checkMainFlavor(){
        Connection con=null;
        try{
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con=DriverManager.getConnection("jdbc:derby://localhost:1527/iceCreamShop","root","root");
            
            PreparedStatement pstmt=con.prepareStatement("select quantity from flavors where fname=? and quantity>=?");
            pstmt.setString(1, mainFlavor);
            System.out.println("the quantity is: "+ quantity);
            pstmt.setInt(2, quantity);
            ResultSet rs=pstmt.executeQuery();
            return rs.next();
        }
        catch (ClassNotFoundException | SQLException ex){
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
            ex.getStackTrace();
        }
        finally{
            if(con!=null)
                try{
                          con.close();
                }
                catch (SQLException ex) {
                      Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
                }
        }
        return false;
    }
    
    public boolean checkExtraScoopFlavor(){
        Connection con=null;
        if(isExtraScoop()){
            try{
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                con=DriverManager.getConnection("jdbc:derby://localhost:1527/iceCreamShop","root","root");

                PreparedStatement pstmt=con.prepareStatement("select quantity from flavors where fname=? and quantity>=?");
                pstmt.setString(1, extraScoopFlavor);
                if(this.mainFlavor.equals(this.extraScoopFlavor))
                    pstmt.setInt(2, quantity*2);
                else
                    pstmt.setInt(2, quantity);
                ResultSet rs=pstmt.executeQuery();
                return rs.next();
            }
            catch (ClassNotFoundException | SQLException ex){
                Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
                ex.getStackTrace();
            }
            finally{
                if(con!=null)
                    try{
                              con.close();
                    }
                    catch (SQLException ex) {
                          Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
                    }
            }
            
        }
           return true; 
    }
    
    public boolean checkToppings(){
        Connection con=null;
        ResultSet rs;
        if(topping){
            try{
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                con=DriverManager.getConnection("jdbc:derby://localhost:1527/iceCreamShop","root","root");

                PreparedStatement pstmt=con.prepareStatement("select quantity from toppings where tname=? and quantity>0");
                for(int i=0;i<toppings.length;i++){
                    pstmt.setString(1, toppings[i]);
                    rs=pstmt.executeQuery();
                    if(rs.next()==false)
                        return false;
                    rs.close();//loop in the order Configuration page to check on the toppings flag array
                }
            }
            catch (ClassNotFoundException | SQLException ex){
                Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
                ex.getStackTrace();
            }
            finally{
                if(con!=null)
                    try{
                              con.close();
                    }
                    catch (SQLException ex) {
                          Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
                    }
            }
        }
        return true;
        //fy return yet7t zy method el check extra scoop elly fy satr 146
        //3mlna kda 34an nt2kd mn al extra scoop lw mawgooda wla la al awl
    }
    
    public double calculateTotal()
    {
        Connection con=null;
        ResultSet rs;
        //database
        //mafesh pricses?
        double total=0;
        try{
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con=DriverManager.getConnection("jdbc:derby://localhost:1527/iceCreamShop","root","root");
            
            PreparedStatement pstmt=con.prepareStatement("select price from flavors where fname=?");
            pstmt.setString(1, mainFlavor);
            rs=pstmt.executeQuery();
            if(rs.next())
            total+=(rs.getDouble("price")*quantity);
            System.out.print(total);
            if(isExtraScoop()){
                rs.close();
                pstmt.setString(1, extraScoopFlavor);
                rs=pstmt.executeQuery();
                if(rs.next())
                    total+=(rs.getDouble("price"))*quantity;
            }
            rs.close();
            System.out.print(isTopping());
            if(isTopping()){
                PreparedStatement pstmt1= con.prepareStatement("select price from toppings where tName=?");
                for(int i=0; i<toppings.length; i++){
                    pstmt1.setString(1, toppings[i]);
                    rs= pstmt1.executeQuery();
                    if(rs.next()){
                        total+=(rs.getDouble("price")*quantity);
                        rs.close();
                    }
                }
                
            }
            System.out.print("The total is: "+ total);
            return total;
        }
        catch (ClassNotFoundException | SQLException ex){
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
            ex.getStackTrace();
        }
        finally{
            if(con!=null)
                try{
                          con.close();
                }
                catch (SQLException ex) {
                      Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
                }
        }
        
        return total;
    }
   
}
