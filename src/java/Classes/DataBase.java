/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author youss
 */
public class DataBase implements java.io.Serializable{
    private static Connection con;
    
    public DataBase()
    {
        try{
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con=DriverManager.getConnection("jdbc:derby://localhost:1527/iceCreamShop","root","root");
        }
        catch (ClassNotFoundException | SQLException ex){
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
            ex.getStackTrace();
        }
        /*finally{
            if(con!=null)
                try{
                          con.close();
                }
                catch (SQLException ex) {
                      Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
                }
        }*/
    }

    public boolean login(Account account)
    {
        try{
            PreparedStatement pstmt=con.prepareStatement("select * from account where username=? and password=?");
            pstmt.setString(1,account.getUserName());
            pstmt.setString(2,account.getPassword());
            ResultSet rs=pstmt.executeQuery();
            return rs.next();
        }
        catch (SQLException ex) {
          Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean register(Account account)
    {
        boolean status=false;
        try {
            PreparedStatement pstmt1=con.prepareStatement("insert into account values(?,?,?,?,?)");
            PreparedStatement pstmt2=con.prepareStatement("select * from account where username=? or email=?");
            pstmt2.setString(1,account.getUserName());
            pstmt2.setString(2, account.getEmail());
            ResultSet rs=pstmt2.executeQuery();
            if(rs.next())
                status=false;
            else{
                pstmt1.setString(1,account.getUserName());
                pstmt1.setString(2,account.getPassword());
                pstmt1.setString(3,account.getPhone());
                pstmt1.setString(4,account.getAddress());
                pstmt1.setString(5,account.getEmail());
                pstmt1.executeUpdate();
                status=true;
            }
        }
        catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }
        return status;
    }
    
    public boolean isValidUserName(Account account)
    {
        
        try {
            PreparedStatement pstmt=con.prepareStatement("select * from account where username=?");
            pstmt.setString(1,account.getUserName());
            ResultSet rs=pstmt.executeQuery();
            return !(rs.next());
        }
        catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }
        return true;
    }
    public boolean closeDBConnection(){
        if(con!=null)
            try{
                con.close();
                return true;
            }
            catch (SQLException ex) {
                Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
                return false;
            }
        else
            return true;
    }
    
    public ResultSet getFlavors(){
        ResultSet rs=null;
        try {
            Statement stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            /*
            TYPE_SCROLL_INSENSITIVE 3lshan el rs msh scorllable msh byrg3 tany lel first b3d ma y3ml el next
            read only 3lshan man3dlsh fy el record
            bensd5dm rs.first();
            */
            rs=stmt.executeQuery("select * from flavors where quantity>0");
        }
        catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    public ResultSet getToppings(){
        ResultSet rs=null;
        try {
            Statement stmt=con.createStatement();
            rs=stmt.executeQuery("select * from toppings where quantity>0");
        }
        catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    private static void updateQuantity(IceCream ic){
        try{
            PreparedStatement pstmt1=con.prepareStatement("update flavors set quantity=(quantity-?) where FName=?");//UPDATE ROOT.FLAVORS SET "QUANTITY" = 50 WHERE FNAME = 'pistachio';
            PreparedStatement pstmt2=con.prepareStatement("update toppings set quantity=(quantity-?) where TName=?");
            
            pstmt1.setInt(1, ic.getQuantity());
            pstmt1.setString(2, ic.getMainFlavor());
            pstmt1.executeUpdate();
            
            if(ic.isExtraScoop()){
                pstmt1.setInt(1, ic.getQuantity());
                pstmt1.setString(2, ic.getExtraScoopFlavor());
                pstmt1.executeUpdate();
            }
            
            if(ic.isTopping()){
                pstmt2.setInt(1, ic.getQuantity());
                for(int i=0; i<ic.getToppings().length;i++){
                    pstmt2.setString(2, ic.getToppings()[i]);
                    pstmt2.executeUpdate();
                }
            }
        }
        catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public static void saveOrder(Order order){
        try{
            PreparedStatement pstmt1=con.prepareStatement("insert into orders values(?,?,?)");
            PreparedStatement pstmt2=con.prepareStatement("insert into icecream values(?,?,?,?,?,?)");
            PreparedStatement pstmt3=con.prepareStatement("insert into topping_icecream values(?,?)");
            
            pstmt1.setInt(1, order.getId());
            pstmt1.setDate(2,new java.sql.Date(System.currentTimeMillis()));
            pstmt1.setDouble(3, order.getTotalCost());
            pstmt1.executeUpdate();
            
            for(int i=0; i<order.getItems().size(); i++){
                pstmt2.setInt(1, order.getItems().get(i).getId());
                pstmt2.setString(2, order.getItems().get(i).getIceCreamType());
                pstmt2.setString(3, order.getItems().get(i).getMainFlavor());
                if(order.getItems().get(i).isExtraScoop())
                    pstmt2.setString(4, order.getItems().get(i).getExtraScoopFlavor());
                else
                    pstmt2.setString(4, "none");
                pstmt2.setDouble(5, order.getItems().get(i).calculateTotal());
                pstmt2.setInt(6, order.getId());
                pstmt2.executeUpdate();
                updateQuantity(order.getItems().get(i));
                if(order.getItems().get(i).isTopping()){
                    for(int j=0; j<order.getItems().get(i).getToppings().length;j++){
                        pstmt3.setInt(1, order.getItems().get(i).getId());
                        pstmt3.setString(2, order.getItems().get(i).getToppings()[j]);
                        pstmt3.executeUpdate();
                    }
                }
            }
        }
        catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public static int reterieveMaxOrderId(){
        ResultSet rs=null;
        int id=0;
        try {
            Statement stmt=con.createStatement();
            rs=stmt.executeQuery("select max(O_ID) as O_ID from orders");
            if(rs.next())
                id=rs.getInt("O_ID");
        }
        catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (id+1);
    }
    public static int reterieveMaxIceCreamId(){
        ResultSet rs=null;
        int id=0;
        try {
            Statement stmt=con.createStatement();
            rs=stmt.executeQuery("select max(IC_ID) as IC_ID from icecream");
            if(rs.next())
                id=rs.getInt("IC_ID");
        }
        catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (id+1);
    }
    public String retrieveEmail(Account account){
        String email="";
        try{
            PreparedStatement pstmt=con.prepareStatement("select email from account where username=?");
            pstmt.setString(1, account.getUserName());
            ResultSet rs=pstmt.executeQuery();
            while(rs.next())
                email=rs.getString("email");
        }
        catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }
        return email;
    }
    public String retrieveAddress(Account account){
        String address="";
        try{
            PreparedStatement pstmt=con.prepareStatement("select address from account where username=?");
            pstmt.setString(1, account.getUserName());
            ResultSet rs=pstmt.executeQuery();
            while(rs.next())
                address=rs.getString("address");
        }
        catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }
        return address;
    }
    public String retrievePhone(Account account){
        String Phone="";
        try{
            PreparedStatement pstmt=con.prepareStatement("select phone from account where username=?");
            pstmt.setString(1, account.getUserName());
            ResultSet rs=pstmt.executeQuery();
            while(rs.next())
                Phone=rs.getString("phone");
        }
        catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }
        return Phone;
    }
    
}
