<%-- 
    Document   : Carrello
    Created on : 7-mag-2021, 23.10.38
    Author     : Amministratore
--%>

<%@page import="it.unitn.disi.studenti.sabinandone.utilities.Carrello"%>
<%@page import="java.util.ArrayList"%>
<%@page import="it.unitn.disi.studenti.sabinandone.utilities.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%Carrello cart = new Carrello();
cart = (Carrello)session.getAttribute("carrello");
String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Carrello</title>
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
        
        <h3>Carrello: </h3>
        
        <% if (cart == null || cart.cart.isEmpty()){
            out.println("<h3>Il carrello è vuoto...</h3>");
        }else{
            /*la variabile p serve come "identificativo" in questa pagina, servirà per la funzione js 
            che permette di settare il nuovo prezzo in base alla quantità selezionata*/
            int p = 0;  
            String originalPrice;
            double realPrice, totalPrice; 
            totalPrice = 0;
            for (Product product : cart.cart) {
            p++;
            originalPrice = product.getPrice();
            originalPrice = originalPrice.replace(",", ".");
            originalPrice = originalPrice.replace("€", "");
            originalPrice = originalPrice.replace(" ", "");

            realPrice = Double.parseDouble(originalPrice)*product.getQuantity();
            totalPrice = totalPrice + realPrice;
        %>           
        <div id="p<%=p%>" class="card" style="width: 18rem;">
            <div class="card-body">
                <h5 class="card-title"><a href="/HW3_Sabin_Andone/SelectProductServlet?selectedProduct=<%=product.getName()%>"><%= product.getName()%></a></h5>
                <p class="card-text" id="price<%=p%>"><%=realPrice+" €"%></p>
                <form name="quantityForm">
                    <div class="form-group form-inline">              
                    Quantità: <select class="form-control" name="quantity" style="width: 75px;" onChange=setNewPrice(<%=p%>,<%=product.getName()%>)>
                    <%for(int i=1; i<21; i++){
                        if(product.getQuantity() == i){%>
                            <option value="<%=i%>" selected="true"><%=i%></option>
                            <%
                                }else{
                            %>
                            <option value="<%=i%>"><%=i%></option>
                    <%}}%>
                    </select> 
                    <a href="/HW3_Sabin_Andone/RemoveFromCartServlet?removedProduct=<%=product.getName()%>" class="text-primary">Rimuovi</a>
                    
                    </div>
                </form>
            </div>
        </div><% }%>
        <p id="totalPrice">Totale ordine: <%=totalPrice%>€</p>
        <button class="btn btn-primary" onclick="window.location.href='/HW3_Sabin_Andone/Riepilogo.jsp'">Procedi all'ordine</button>
                  
        
        
    <script>
        function setNewPrice(product,name){
            var quantità, prodotti;
            prodotti = <%=p%>;
            if (prodotti == 1){
                quantità = document.quantityForm.quantity.selectedIndex;
            }else{
                quantità = document.quantityForm[product-1].quantity.selectedIndex;
            }           
            quantità++;
            document.location.href = "/HW3_Sabin_Andone/CarrelloServlet?quantity="+quantità+"&product="+name;

            
  }
        
    </script>
    <%}%> 
    <%Carrello cartS = new Carrello();
        cartS = (Carrello)session.getAttribute("carrello");
        if (cartS == null){
      %>       
            <div class="jumbotron" id="cookieBar" style="height: 16rem; width: 48rem; bottom: 10px; position: fixed; text-align: center;">
            <p style="font-size: 16px;">I cookie aiutano a fornire i servizi che questo sito offre ai propri utenti, come l'utilizzo del carrello e gli acquisti. Utilizzando tali servizi, accetti l'utilizzo dei cookie.</p>
            <a class="btn btn-primary" href="/HW3_Sabin_Andone/InitializeServlet">Accetta</a>            
        </div>
        <%}%>
    </body>
</html>
