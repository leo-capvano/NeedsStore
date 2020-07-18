package controller.routingServlets;

import model.Articolo;
import model.ArticoloDAO;
import model.Utente;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/toModificaArt")
public class toModificaArticolo extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        HttpSession session = req.getSession();
        Utente utenteLoggato = (Utente)session.getAttribute("utenteLoggato");
        String idArt = (String)req.getParameter("modificaArt");
        ArticoloDAO articoloDAO = new ArticoloDAO();
        Articolo articolo = articoloDAO.doRetrieveById(idArt);
        //solo gli utenti loggati possono modificare un annuncio
        if (utenteLoggato!=null){
            //controllo se l'articolo appartiene all'utenteloggato
            if (articolo.getEmail_vend().equals(utenteLoggato.getEmail())) {
                req.setAttribute("articoloToEdit", idArt);
                RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/modificaArticolo-page.jsp");
                dispatcher.forward(req,resp);
            }
        }else{
            //usr non autorizzato ad accedere, devi loggarti
            RequestDispatcher dispatcher = req.getRequestDispatcher("homepage.jsp");
            req.setAttribute("error","Non sei autorizzato a modificare questo annuncio!");
            dispatcher.forward(req,resp);
        }
    }
}
