<%-- 
    Document   : Login
    Created on : 7-mag-2021, 22.17.51
    Author     : Amministratore
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Accedi</title>
        <!-- link di Bootstrap -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        
    </head>
    <body>
        <div class="container">
            <h1>Accedi</h1>
            <div class="text-danger">
                <%String message = (String)request.getAttribute("message");
                    if (message!=null){
                        out.println("<p>" + message + "</p>");
                    }
                %>
            </div>
            <form action="/HW3_Sabin_Andone/LoginServlet" method="post">
                <div class="form-group">
                    <label for="usr">Nome utente:</label>
                    <input type="text" class="form-control" id="usr" placeholder="Nome utente" name="username">
                </div>
                <div class="form-group">
                    <label for="pwd">Password:</label>
                    <input type="password" class="form-control" id="pwd" placeholder="password" name="password">
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
            <br>
            <a href="/HW3_Sabin_Andone/Register.jsp">Non hai un account? Registrati subito!</a>
            <p> <a href="/HW3_Sabin_Andone/Homepage.jsp">Clicca qui </a>per tornare alla homepage</p>
        </div>
    </body>
</html>
