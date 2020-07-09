package controller;

import model.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/shaw-sold")
public class ShawSoldServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utente utenteLoggato = (Utente) req.getSession().getAttribute("utenteLoggato");
        if (utenteLoggato==null){
            throw new GenericException("Non sei autorizzato a visualizzare questa pagina");
        }

        //carica tutte le vendite dell'utenteLoggato
        VenditaDAO venditaDAO = new VenditaDAO();
        ArrayList<Vendita> vendite = venditaDAO.doRetrieveByUser(utenteLoggato.getEmail());
        req.setAttribute("vendite",vendite);

        RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/sold-page.jsp");
        dispatcher.forward(req,resp);

    }
}
