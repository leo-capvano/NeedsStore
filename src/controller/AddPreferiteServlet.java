package controller;

import model.Articolo;
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
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

@WebServlet("/addPreferite")
public class AddPreferiteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Utente utenteLoggato = (Utente) req.getSession().getAttribute("utenteLoggato");
        if (utenteLoggato==null)
            throw new GenericException("Effettua l'accesso per cominciare a salvare i preferiti!");

        //articolo da aggiungere ai preferiti
        String idArticolo = req.getParameter("idArticolo");
        HttpSession session = req.getSession();
        boolean ok = false;
        synchronized (session){
            HashMap<String,String> preferiti = (HashMap<String,String>) session.getAttribute("preferiti");
                preferiti.put(idArticolo,idArticolo);
                session.setAttribute("preferiti",preferiti);
                ok=true;
        }
        RequestDispatcher dispatcher = req.getRequestDispatcher("/homepage.jsp");
        dispatcher.forward(req,resp);
    }
}
