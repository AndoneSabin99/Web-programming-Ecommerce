<%-- 
    Document   : Homepage
    Created on : 7-mag-2021, 22.06.35
    Author     : Amministratore
--%>

<%@page import="it.unitn.disi.studenti.sabinandone.utilities.Carrello"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String username = (String) session.getAttribute("username");%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Homepage</title>
        <!-- link di Bootstrap -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        
    </head>
    <body> 
       
        <nav class="navbar navbar-expand-sm bg-light">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="/HW3_Sabin_Andone/Homepage.jsp">Homepage</a>
                </li>
                <li class="nav-item">
                    
                    <form class="form-inline" action="/HW3_Sabin_Andone/ProductServlet" method="get">
                        <div class="form-group">
                            <select class="form-control" name="category">
                                <option value="All" selected="true">Tutte le categorie</option>
                                <option value="BiciElettriche">Bici Elettriche</option>
                                <option value="FrigoPortatili">Frigo Portatili</option>
                                <option value="TV">TV</option>
                            </select>
                            <input type="text" class="form-control" placeholder="Cerca" name="search">
                            <button type="submit" class="btn btn-primary">&#128269;</button>
                        </div>                       
                    </form>                   
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/HW3_Sabin_Andone/Carrello.jsp">Carrello</a>
                </li>
                <li class="nav-item">
                    <%if (username != null){
                          out.println("<a class=\"nav-link\" href=\"/HW3_Sabin_Andone/LogoutServlet\">"+username+", logout</a>");
                      }else{
                          out.println("<a class=\"nav-link\" href=\"/HW3_Sabin_Andone/Login.jsp\">Login</a>");
                      }
                        %>
                    
                </li>
            </ul>
        </nav> <br>
        
        
        <div class="container-fluid">
            <%if (username != null){
                  out.println("<h3>Benvenuto, " + username + "!</h3>");
                  out.println("<p>Per poter iniziare ad acquistare prodotti, cerca il prodotto che desideri utilizzando la barra di ricerca.</p>");
              }else{
                  out.println("<h3>Benvenuto!</h3>");
                  out.println("<p>Per poter iniziare ad acquistare prodotti, cerca il prodotto che desideri utilizzando la barra di ricerca e assicurati di esserti autenticato per poter effettuare gli acquisti.</p>");
              }
                %>
           
        </div>
        <div class="text-info">
                        <%String message = (String)request.getAttribute("messageSuccess");
                            if (message!=null){
                            out.println("<p>" + message + "</p>");
                            request.setAttribute("messageSuccess", null);
                        }
                        %>
        </div> 
    
      <%Carrello cart = new Carrello();
        cart = (Carrello)session.getAttribute("carrello");
        if (cart == null){
      %>       
            <div class="jumbotron" id="cookieBar" style="height: 16rem; width: 48rem; bottom: 10px; position: fixed; text-align: center;">
            <p style="font-size: 16px;">I cookie aiutano a fornire i servizi che questo sito offre ai propri utenti, come l'utilizzo del carrello e gli acquisti. Utilizzando tali servizi, accetti l'utilizzo dei cookie.</p>
            <a class="btn btn-primary" href="/HW3_Sabin_Andone/InitializeServlet">Accetta</a>            
        </div>
        <%}%>
    </body>
</html>
