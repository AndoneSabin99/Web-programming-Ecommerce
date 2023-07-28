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
public class ProductNameCresComparator implements Comparator<Product>{

    @Override
    public int compare(Product p1, Product p2) {
        return p1.getName().compareTo(p2.getName());
    }
    
}
