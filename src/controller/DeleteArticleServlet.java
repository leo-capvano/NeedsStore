package controller;

import model.Articolo;
import model.ArticoloDAO;
import model.GenericException;
import model.Utente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/delArticle")
public class DeleteArticleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String idArticolo = req.getParameter("idArticolo");
        ArticoloDAO articoloDAO = new ArticoloDAO();
        Articolo articolo = articoloDAO.doRetrieveById(idArticolo);
        Utente utenteLoggato = (Utente) req.getSession().getAttribute("utenteLoggato");
        //controllo che chi elimina l'articolo sia effettivamente il proprietario di quest'ultimo
        if ((utenteLoggato==null)||(!articolo.getEmail_vend().equals(utenteLoggato.getEmail())))
            throw new GenericException("Non sei autorizzato a questa azione");

        String r = articoloDAO.doSell(idArticolo);
        PrintWriter writer = resp.getWriter();
        resp.setContentType("UTF-8");
        writer.write(r);
        writer.flush();
        writer.close();

    }
}
