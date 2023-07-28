/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unitn.disi.studenti.sabinandone.servlet;

import it.unitn.disi.studenti.sabinandone.utilities.Product;
import it.unitn.disi.studenti.sabinandone.utilities.ProductNameCresComparator;
import it.unitn.disi.studenti.sabinandone.utilities.ProductNameDecComparator;
import it.unitn.disi.studenti.sabinandone.utilities.ProductPriceCresComparator;
import it.unitn.disi.studenti.sabinandone.utilities.ProductPriceDecComparator;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Amministratore
 */
@WebServlet(name = "ProductServlet", urlPatterns = {"/ProductServlet"})
public class ProductServlet extends HttpServlet {

    ArrayList<Product> productList = new ArrayList<Product>();
    
    public void populate(String category, String search) throws FileNotFoundException, IOException{
        
        productList.clear();  //nel caso in cui abbiamo già fatto una ricerca in precedenza
        
        String contextPath = getServletContext().getRealPath("/");
        //se abbiamo scelto tutte le categorie guardiamo su tutti i file, altrimenti solo su quello della categoria selezionata
        if (category.equals("All") && !search.equals("")){
            
            String filename1 = contextPath + "\\resources\\products\\BiciElettriche.txt";
            BufferedReader in1 = new BufferedReader(new FileReader(filename1));
            String filename2 = contextPath + "\\resources\\products\\FrigoPortatili.txt";
            BufferedReader in2 = new BufferedReader(new FileReader(filename2));
            String filename3 = contextPath + "\\resources\\products\\TV.txt";
            BufferedReader in3 = new BufferedReader(new FileReader(filename3));
            
            String line = "";
            while((line=in1.readLine())!=null){
                if (line.contains(search)){
                    String name = line;
                    in1.skip(1);
                    String description = in1.readLine();
                    in1.skip(1);
                    String price = in1.readLine();
                    price = price.substring(0, price.length()-4);
                    price = price + " €";
                    productList.add(new Product(name, description, price));
                    in1.skip(12);
                }
            }
            
            while((line=in2.readLine())!=null){
                if (line.contains(search)){
                    String name = line;
                    in2.skip(1);
                    String description = in2.readLine();
                    in2.skip(1);
                    String price = in2.readLine();
                    price = price.substring(0, price.length()-4);
                    price = price + " €";
                    productList.add(new Product(name, description, price));
                    in2.skip(12);
                }
            }
            
            while((line=in3.readLine())!=null){
                if (line.contains(search)){
                    String name = line;
                    in3.skip(1);
                    String description = in3.readLine();
                    in3.skip(1);
                    String price = in3.readLine();
                    price = price.substring(0, price.length()-4);
                    price = price + " €";                    
                    productList.add(new Product(name, description, price));
                    in3.skip(12);
                }
            }
            in1.close();
            in2.close();
            in3.close();
        }else{
            String filename = contextPath + "\\resources\\products\\" + category + ".txt";
            BufferedReader in = new BufferedReader(new FileReader(filename));
            
            String line = "";
            while((line=in.readLine())!=null){
                if (line.contains(search) || search.equals("")){
                    String name = line;
                    in.skip(1);
                    String description = in.readLine();
                    in.skip(1);
                    String price = in.readLine();
                    price = price.substring(0, price.length()-4);
                    price = price + " €";
                    productList.add(new Product(name, description, price));
                    in.skip(12);      //per saltare il separatore
                }
            }
            in.close();
        }
    }
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet productServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet productServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        
        String choice = request.getParameter("choice");
        HttpSession session = request.getSession(true);
        ServletContext context = request.getServletContext();
        //se voglio solo ordinare la lista, avrò choice non nullo, altrimenti significa che ho usato la barra di ricerca
        if (choice!=null){
            productList = (ArrayList<Product>)context.getAttribute("productList");
            
            switch(choice){
                    case "1": productList.sort(new ProductNameCresComparator());
                            break;
                    case "2": productList.sort(new ProductNameDecComparator());
                            break;
                    case "3": productList.sort(new ProductPriceCresComparator());
                            break;
                    case "4": productList.sort(new ProductPriceDecComparator());
                            break;      
                }
        }else{
        
        String category = request.getParameter("category");
        String search = request.getParameter("search");
        
        //se ho selezionato tutte le categorie ma non metto nulla in ricerca, ricarico la homepage
        if(category.equals("All") && search.equals("")){
            response.sendRedirect(request.getContextPath() + "/Homepage.jsp");
            return;
        }
        
        //populate serve per popolare la productList, che conterrà i prodotti che corrisponderanno alla ricerca
        populate(category, search);        
        
        
        session.setAttribute("search", search);}
        context.setAttribute("productList",productList);
        response.sendRedirect(request.getContextPath() + "/Ricerca.jsp");
        
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
