/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;

import java.util.ArrayList;

/**
 *
 * @author Ehab Attia
 */
public class Order implements java.io.Serializable{
    
    private int id;
    private int numberOfCups, numberOfCones, numberOfItems;
    private ArrayList<IceCream> items=new ArrayList<>();
    private double totalCost;
    
    public Order()
    {
        numberOfCups=0;
        numberOfCones=0;
        numberOfItems=0;
        totalCost=0;
        id=DataBase.reterieveMaxOrderId();
    }
    //---------------------------------------------------------------------------------------------
    //---------------------------------------------------------------------------------------------
    public int getNumberOfCups() {
        return numberOfCups;
    }
//neshel el setter


    public int getNumberOfCones() {
        return numberOfCones;
    }

    public int getNumberOfItems() {
        return numberOfItems;
    }

    public ArrayList<IceCream> getItems() {
        return items;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    public int getId() {
        return id;
    }
    
    //---------------------------------------------------------------------------------------------
    //---------------------------------------------------------------------------------------------
    public void addItem(IceCream o)
    {
        
        //add price to the total cost before adding in the array list.
        items.add(o);
        if(o.getIceCreamType().equals("cup"))
            
            numberOfCups++;
        else
            numberOfCones++;
        updateTotal(o);
            
    }
    public void updateTotal(IceCream o){
        this.totalCost+=o.calculateTotal();
        System.out.println("total order price:"+totalCost);
    }
    /*public String checkOutOrder()
    {//betl3 details w testana el confirmation bet3 el user
        return 
        "<%for(int i=0;i<order.getItems().size();i++){%>\n" +
"        <tr>\n" +
"            <td width=\"200px\">"+ order.getItems().get(i).getMainFlavor() + 8\" Icecream\"%></td>\n" +
"            <td width=\"200px\" style=\"text-align: center\"><%= order.getItems().get(i).getQuantity() %></td>\n" +
"            <td width=\"200px\" style=\"text-align: center\"><%= order.getItems().get(i).calculateTotal() + \"LE\" %></td>  \n" +
"        </tr>\n" +
"        <tr>\n" +
"            <td colspan=\"3\">\n" +
"                <%= \"Main Flavor : \"+order.getItems().get(i).getMainFlavor() %><br>\n" +
"                <% if(order.getItems().get(i).isExtraScoop()) {%>\n" +
"                <%= \"Extra Flavor: \"+order.getItems().get(i).getExtraScoopFlavor() %><br><%}%>\n" +
"                <% if(order.getItems().get(i).isTopping()) {for(int j=0;j<order.getItems().get(i).getToppings().length;j++) {%>\n" +
"                <%= \"Topping \"+(j+1)+\": \"+order.getItems().get(i).getToppings()[j]%><br><%}}%><br><br>\n" +
"\n" +
"            </td>\n" +
"        </tr>\n" +
"        <%}%>";
    }/*/
    public void confirmOrder()
    {
        DataBase.saveOrder(this);
        //collect quantity and calculate total price.
        //the updating process will be done in the jsp aw al servlet.
    }
    
    
    
}
