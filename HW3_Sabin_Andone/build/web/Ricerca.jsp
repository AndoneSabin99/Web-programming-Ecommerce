<%-- 
    Document   : Ricerca
    Created on : 7-mag-2021, 23.10.16
    Author     : Amministratore
--%>

<%@page import="it.unitn.disi.studenti.sabinandone.utilities.Carrello"%>
<%@page import="it.unitn.disi.studenti.sabinandone.utilities.ProductPriceDecComparator"%>
<%@page import="it.unitn.disi.studenti.sabinandone.utilities.ProductPriceCresComparator"%>
<%@page import="it.unitn.disi.studenti.sabinandone.utilities.ProductNameDecComparator"%>
<%@page import="it.unitn.disi.studenti.sabinandone.utilities.ProductNameCresComparator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="it.unitn.disi.studenti.sabinandone.utilities.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%ArrayList<Product> productList = new ArrayList<Product>();
ServletContext context = request.getServletContext();
productList = (ArrayList<Product>)getServletContext().getAttribute("productList");
String username = (String) session.getAttribute("username");
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=(String)session.getAttribute("search")%></title>
        
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
        
        <% if (productList.isEmpty()){
            out.println("<h3>Nessun prodotto trovato...</h3>");
        }else{%>
        
            <form class="form-inline" name="orderForm">
                <div class="form-group">
                    <select class="form-control" name="order" onChange=setOrder()>
                        <option value="">Ordina per ...</option>
                        <option value="nomeCres">Ordina per: ordine alfabetico crescente</option>  
                        <option value="nomeDec">Ordina per: ordine alfabetico decrescente</option>  
                        <option value="prezzoCres">Ordina per: prezzo crescente</option>  
                        <option value="prezzoDec">Ordina per: prezzo decrescente</option>  
                    </select>
                </div>                 
            </form>
        
        <%for (Product product : productList) {%>
        <div class="card" style="width: 18rem;">
            <div class="card-body">
                <h5 class="card-title"><a href="/HW3_Sabin_Andone/SelectProductServlet?selectedProduct=<%=product.getName()%>"><%= product.getName()%></a></h5>
                <p class="card-text"><%=product.getPrice()%></p>
            </div>
        </div><% }}%>           
        
        <script>
            function setOrder(){
                var choice;
                choice = document.orderForm.order.selectedIndex;
                document.location.href = "/HW3_Sabin_Andone/ProductServlet?choice="+choice;
            }
        </script>
        
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
