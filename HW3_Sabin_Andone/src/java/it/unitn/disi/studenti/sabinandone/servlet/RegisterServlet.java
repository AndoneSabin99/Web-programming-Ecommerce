/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unitn.disi.studenti.sabinandone.servlet;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import static java.lang.System.in;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Amministratore
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

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
            out.println("<title>Servlet RegisterServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        //processRequest(request, response);
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmedPassword = request.getParameter("confirmedPassword");
        String address = request.getParameter("address");
        String credit = request.getParameter("credit");
        
        if (!password.equals(confirmedPassword)){
            String message = "Assicurati di aver confermato correttamente la password!";
            request.setAttribute("message", message);
            request.getRequestDispatcher("Register.jsp").forward(request, response);
            return;
        }
        
        //Devo prendere la path giusta del file Users.txt affinchè la scrittura sul file avvenga correttamente
        String contextPath = getServletContext().getRealPath("/");
        contextPath = contextPath.substring(0, contextPath.length()-10);
        String filename = contextPath + "web\\resources\\users\\Users.txt";

        BufferedReader in = new BufferedReader(new FileReader(filename));
        
        String line = "";
        boolean alreadyRegistered = false;
        StringBuilder users = new StringBuilder();
        while((line=in.readLine())!= null && !alreadyRegistered){
            if (username.equals(line)){
                alreadyRegistered = true;
                String message = "Utente già registrato!";
                request.setAttribute("message", message);
                }
            users.append(line);
            users.append("\n");
            }
        in.close();
        if (alreadyRegistered){
            request.getRequestDispatcher("Register.jsp").forward(request, response);
            return;
        }
 
        String utenti = users.toString();
        //aggiungo i dati dell'utente insieme a quello degli altri
        
        utenti = utenti + username + "\n";
        utenti = utenti + "" + "\n";
        utenti = utenti + password + "\n";
        utenti = utenti + "" + "\n";
        utenti = utenti + address + "\n";
        utenti = utenti + "" + "\n";
        utenti = utenti + credit + "\n";
        utenti = utenti + "===========" + "\n";
        
        String message = "Registrazione avvenuta con successo, vai al login per accedere!";
        request.setAttribute("message", message);    
        
         try {
      //String filename2="C:\\Users\\Amministratore\\Desktop\\università\\terzo anno\\2° semestre\\programmazione web\\esercizi e compiti\\HW3-Andone-Sabin\\HW3_Sabin_Andone\\web\\resources\\users\\Users.txt";
      //BufferedWriter out = new BufferedWriter(new FileWriter(filename2,true));
      FileWriter out = new FileWriter(filename);
      out.write(utenti);
      out.flush();
      out.close();
    } catch (IOException e) {
      System.out.println("An error occurred.");
      e.printStackTrace();
    }
        
        request.getRequestDispatcher("Register.jsp").forward(request, response);
                
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
