/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;

/**
 *
 * @author youss
 */
public class Account implements java.io.Serializable{
    private String userName;
    private String password;
    private String address;
    private String email;
    private String phone;

    public String getUserName(){
        return userName;
    }

    public void setUserName(String username) {
        this.userName = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        if(isValidPassword(password))
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        if(isValidPhoneNumber(phone))
        this.phone = phone;
    }
    public boolean isValidPassword(String password){
        boolean digitFlag=false, letterFlag=false;
        if(password.length()>=8)
        {
            for(int i=0; i<password.length(); i++)
            {
                if(Character.isDigit(password.charAt(i)) || Character.isLetter(password.charAt(i))) // kjdsoritgng
                {// admin1234
                    if(Character.isDigit(password.charAt(i)))
                        digitFlag=true;
                    else if(Character.isLetter(password.charAt(i)))
                        letterFlag=true;
                }
                else
                    return false;
            }
            if(digitFlag && letterFlag)  
            {
                return true;
            }
            else 
            {
                System.out.println("Not Valid.");
                return false;
            }

        }
        else
        {
            System.out.println("Not Valid.");
            return false;
        }
    }
        public boolean isValidPhoneNumber(String a){
        boolean flag=false;
        for(int i=0;i<a.length();i++){
            if(a.length()==11 && a.charAt(0)=='0' && java.lang.Character.isDigit(a.charAt(i)))
                flag=true;
            else 
                return false;
        }
        return flag;
    }
    public boolean validateRegistration()
    {
        
        return true;
    }
}
