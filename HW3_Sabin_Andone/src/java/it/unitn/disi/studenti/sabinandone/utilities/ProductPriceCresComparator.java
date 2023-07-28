/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unitn.disi.studenti.sabinandone.utilities;

import java.util.Comparator;

/**
 *
 * @author Amministratore
 */
public class ProductPriceCresComparator implements Comparator<Product>{

    @Override
    public int compare(Product p1, Product p2) {
        String price1 = p1.getPrice().substring(0, p1.getPrice().length()-2);
        String price2 = p2.getPrice().substring(0, p2.getPrice().length()-2);
        
        double val = Double.parseDouble(price1.replace(',', '.')) - Double.parseDouble(price2.replace(',','.'));        
        return (int)val;
    }
    
}
