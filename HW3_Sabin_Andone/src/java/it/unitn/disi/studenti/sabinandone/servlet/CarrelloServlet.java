/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unitn.disi.studenti.sabinandone.servlet;

import it.unitn.disi.studenti.sabinandone.utilities.Carrello;
import it.unitn.disi.studenti.sabinandone.utilities.Product;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "CarrelloServlet", urlPatterns = {"/CarrelloServlet"})
public class CarrelloServlet extends HttpServlet {

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
            out.println("<title>Servlet CarrelloServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CarrelloServlet at " + request.getContextPath() + "</h1>");
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
        String quantity = request.getParameter("quantity");
        HttpSession session = request.getSession(true);
        ServletContext context = request.getServletContext();
        
        Carrello cart = (Carrello)session.getAttribute("carrello");        
        //se il carrello è nullo, ne creiamo uno nuovo, cosi non si opera su carrelli nulli
        if (cart==null){
            cart = new Carrello();
        }
        
        String destPage = "/Carrello.jsp";
        String productName = request.getParameter("product");
        
        /*productName è una variabile che indica il nome del prodotto nel caso in cui si è deciso di cambiare la 
        sua quantità nel carrello. Se è nullo, allora significa
        che stiamo aggiungendo un nuovo prodotto al carrello*/
        if (productName == null){
            Product productInsertedInCart = new Product((String)context.getAttribute("product"),(String)context.getAttribute("description"),(String)context.getAttribute("price"));
            productInsertedInCart.setQuantity(Integer.parseInt(quantity));
            cart.add(productInsertedInCart);
            session.setAttribute("carrello",cart);
            
            //se abbiamo premuto su procedi col pagamento dobbiamo andare direttamente alla pagina di riepilogo dell'ordine
            if (request.getParameter("acquista")!=null){
                destPage = "/Riepilogo.jsp";
            }
        }else{
            /*in questo caso abbiamo cambiato la quantità di un prodotto nella paggina Carrello.jsp, 
            dobbiamo trovare il prodotto cercato e cambiare la sua quantità*/
            for(Product p: cart.cart){
            if (productName.equals(p.getName())){
                p.setQuantity(Integer.parseInt(quantity));
                break;
            }
        }
        }
                          
            response.sendRedirect(request.getContextPath() + destPage);

        
        
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
