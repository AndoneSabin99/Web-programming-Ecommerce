<%-- 
    Document   : Riepilogo
    Created on : 7-mag-2021, 23.17.13
    Author     : Amministratore
--%>

<%@page import="it.unitn.disi.studenti.sabinandone.utilities.Product"%>
<%@page import="it.unitn.disi.studenti.sabinandone.utilities.Carrello"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%Carrello cart = new Carrello();
cart = (Carrello)session.getAttribute("carrello");
String username = (String) session.getAttribute("username");
String address = (String) session.getAttribute("address");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Riepilogo ordine</title>
        <!-- link di Bootstrap -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        
    </head>
    <body>
        <h1>Riepilogo ordine</h1>
        
        <div class="card" style="width: 36rem;">
            <div class="card-body">
                <h5>Indirizzo di consegna:</h5>
                <p class="card-text"><%=username%></p>
                <p class="card-text"><%=address%></p>
            </div>
        </div>
            
        <div class="card" style="width: 36rem;">
            <div class="card-body">
                <h5>Per favore, inserisci la carta di credito per poter procedere col pagamento</h5>
                <form action="/HW3_Sabin_Andone/BuyServlet" method="post">
                    <div class="form-group">
                        <div class="text-danger">
                        <%String message = (String)request.getAttribute("message");
                            if (message!=null){
                            out.println("<p>" + message + "</p>");
                        }
                        %>
                        </div>    
                        <input id="credit" type="password" class="form-control" placeholder="**** **** **** ****" name="creditCard">                        
                        <input id="creditCheck" type="checkbox" onclick="show()">Mostra la carta di credito
                        <br><br>
                        
                        <% if (cart == null || cart.cart.isEmpty()){
                           out.println("<h3>Il carrello è vuoto, non c'è nulla da acquistare...</h3>");
        }else{
            int p = 0;  //questa variabile serve come "identificativo" in questa pagina, servirà per le funzioni js
            String originalPrice;
            double realPrice, totalPrice; 
            totalPrice = 0;
            out.println("<h5>Rivedi gli articoli e la spedizione</h5>");
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
                <p class="card-text">Quantità: <%=product.getQuantity()%></p>
            </div>
        </div><% }%>
        <p id="totalPrice">Totale ordine: <%=totalPrice%>€</p>
        <a href="/HW3_Sabin_Andone/Carrello.jsp">Torna al carrello</a>
        <br>
        <button type="submit" class="btn btn-primary">Acquista ora</button>
        <%}%> 
                    </div>                       
                </form> 
            </div>
        </div>
                    
        <script>
            function show() {               
                var checkBox = document.getElementById("creditCheck");
                var credit = document.getElementById("credit");
                if (checkBox.checked == true){
                    credit.type = "text";
                } else {
                    credit.type = "password";
                }
            }
        </script>
    </body>
</html>
