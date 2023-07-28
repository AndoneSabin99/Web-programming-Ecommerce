<%-- 
    Document   : Register
    Created on : 21-mag-2021, 22.12.03
    Author     : Amministratore
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrati</title>
        <!-- link di Bootstrap -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        
    </head>
    <body>
        <div class="container">
            <h1>Registrati</h1>
            <div class="text-danger">
                <%String message = (String)request.getAttribute("message");
                    if (message!=null){
                        out.println("<p>" + message + "</p>");
                    }
                %>
            </div>
            <form action="/HW3_Sabin_Andone/RegisterServlet" method="post">
                <div class="form-group">
                    <label for="usr">Nome utente:</label>
                    <input type="text" class="form-control" id="usr" placeholder="Nome utente" name="username">
                </div>
                <div class="form-group">
                    <label for="pwd">Password:</label>
                    <input type="password" class="form-control" id="pwd" placeholder="password" name="password">
                </div>
                <div class="form-group">
                    <label for="pwd">Conferma password:</label>
                    <input type="password" class="form-control" id="pwd" placeholder="password" name="confirmedPassword">
                </div>
                <div class="form-group">
                    <label for="usr">Indirizzo:</label>
                    <input type="text" class="form-control" id="usr" placeholder="Indirizzo" name="address">
                </div>
                <div class="form-group">
                    <label for="pwd">Carta di credito:</label>
                    <input type="password" class="form-control" id="pwd" placeholder="**** **** **** ****" name="credit">
                </div>                
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
            <br>
            <a href="/HW3_Sabin_Andone/Login.jsp">Torna al login</a>
            <p> <a href="/HW3_Sabin_Andone/Homepage.jsp">Clicca qui </a>per tornare alla homepage</p>
        </div>
    </body>
</html>
