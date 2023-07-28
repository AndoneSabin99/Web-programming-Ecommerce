/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unitn.disi.studenti.sabinandone.servlet;

import it.unitn.disi.studenti.sabinandone.utilities.LoginBean;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.PrintWriter;
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
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    //funzione per verificare che l'utente abbian inserito username e password corretti   
    public boolean validate(LoginBean loginBean, HttpSession session) throws FileNotFoundException, IOException{
        
        boolean valid = false;
        String contextPath = getServletContext().getRealPath("/");
        String filename = contextPath + "resources\\users\\Users.txt";
        //String filename="C:\\Users\\Amministratore\\Desktop\\università\\terzo anno\\2° semestre\\programmazione web\\esercizi e compiti\\HW3-Andone-Sabin\\HW3_Sabin_Andone\\web\\resources\\users\\Users.txt";

        System.out.println("login users is in: " + filename);
        BufferedReader in = new BufferedReader(new FileReader(filename));        

        String line = "";
        while((line=in.readLine())!= null && !valid){

            if (loginBean.getUsername().equals(line)){
                in.skip(1);                  //serve per saltare lo spazio presente tra username e password 
                line=in.readLine();

                if (loginBean.getPassword().equals(line)){
                    valid = true;
                    session.setAttribute("username", loginBean.getUsername());
                    in.skip(1);
                    line=in.readLine();

                    session.setAttribute("address",line);
                    in.skip(1);
                    line=in.readLine();

                    session.setAttribute("creditCard", line);
                }
            }
        }

        in.close();
        return valid;
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
            out.println("<title>Servlet LoginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
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
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        LoginBean loginBean = new LoginBean();
        loginBean.setUsername(username);
        loginBean.setPassword(password);
        
        
        HttpSession session = request.getSession();
        if (!this.validate(loginBean,session)) {   
            String message = "Nome utente o password errati!";
            request.setAttribute("message", message);
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }
        String destPage = (String)session.getAttribute("previousPage");
        
        if (destPage == null){
            destPage = request.getContextPath() + "/Homepage.jsp";
        }
        System.out.println(destPage);
        response.sendRedirect(destPage);      
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
