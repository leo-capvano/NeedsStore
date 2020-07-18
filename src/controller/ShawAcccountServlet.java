package controller;

import model.GenericException;
import model.Utente;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/shaw-account")
public class ShawAcccountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utente utenteLoggato = (Utente) req.getSession().getAttribute("utenteLoggato");
        if (utenteLoggato==null){
            throw new GenericException("Non sei autorizzato a visitare questa pagina!");
        }
        RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/account-page.jsp");
        dispatcher.forward(req,resp);
    }
}
