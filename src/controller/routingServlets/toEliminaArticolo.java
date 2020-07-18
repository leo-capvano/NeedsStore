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

@WebServlet("/toEliminaArt")
public class toEliminaArticolo extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        Utente utenteLoggato = (Utente)session.getAttribute("utenteLoggato");
        String idArticolo = req.getParameter("eliminaArt");
        ArticoloDAO articoloDAO = new ArticoloDAO();
        Articolo articolo = articoloDAO.doRetrieveById(idArticolo);
        //solo gli utenti loggati possono eliminare un annuncio
        if (utenteLoggato!=null){
            //controllo se l'articolo appartiene all'utenteloggato
            if (articolo.getEmail_vend().equals(utenteLoggato.getEmail())) {
                req.setAttribute("idArticolo", idArticolo);
                RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/eliminaArticolo-page.jsp");
                dispatcher.forward(req, resp);
            }
        }else{
            //usr non autorizzato ad accedere, devi loggarti
            RequestDispatcher dispatcher = req.getRequestDispatcher("homepage.jsp");
            req.setAttribute("error","Devi loggarti per poter eliminare un annuncio!");
            dispatcher.forward(req,resp);
        }
    }
}
