package controller.routingServlets;

import model.GenericException;
import model.Utente;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/toPreferite")
public class toPreferite extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utente utenteLoggato = (Utente) req.getSession().getAttribute("utenteLoggato");
        if (utenteLoggato==null)
            throw new GenericException("Effettua l'accesso per cominciare a salvare i preferiti!");
        else {
            RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/preferite-page.jsp");
            dispatcher.forward(req, resp);
        }
    }
}
