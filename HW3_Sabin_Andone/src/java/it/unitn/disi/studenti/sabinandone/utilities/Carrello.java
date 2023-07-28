/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unitn.disi.studenti.sabinandone.utilities;

import java.util.ArrayList;

/**
 *
 * @author Amministratore
 */
public class Carrello {
    public ArrayList<Product> cart;
    public String user;
    
    public Carrello() {
        this.cart = new ArrayList<Product>();
    }
    
    public void add(Product p){
        this.cart.add(p);
    }
    
    public void remove(Product p){
        this.cart.remove(p);
    }
    
    public void setUser(String user){
        this.user = user;
    }
    
    public String getUser(){
        return this.user;
    }
    
    
}
