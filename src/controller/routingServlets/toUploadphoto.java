package controller.routingServlets;

import model.Articolo;
import model.Utente;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/toUploadphoto")
public class toUploadphoto extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String idArticolo = UUID.randomUUID().toString();
        String titolo = req.getParameter("titolo");
        String descrizione = req.getParameter("descrizione");
        String luogo = req.getParameter("luogo");
        Double prezzo = Double.parseDouble(req.getParameter("prezzo"));
        Utente utenteLoggato = (Utente) req.getSession().getAttribute("utenteLoggato");
        String email_vend = utenteLoggato.getEmail();
        Articolo newArticolo = new Articolo(idArticolo,titolo,descrizione,email_vend,prezzo,luogo);

        HttpSession session = req.getSession();
        synchronized (session){
            session.setAttribute("newArticolo",newArticolo);
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/uploadphoto.jsp");
        dispatcher.forward(req,resp);
    }
}
