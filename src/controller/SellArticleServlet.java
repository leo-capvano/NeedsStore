package controller;

import model.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.UUID;

@WebServlet("/sellArticle")
public class SellArticleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String idArticolo = req.getParameter("idArticolo");
        ArticoloDAO articoloDAO = new ArticoloDAO();
        Articolo articolo = articoloDAO.doRetrieveById(idArticolo);
        Utente utenteLoggato = (Utente) req.getSession().getAttribute("utenteLoggato");
        //controllo se l'utenteloggato è nullo
        //se l'articolo che si sta vendendo appartiene a utenteloggato
        if ((utenteLoggato==null)||(!utenteLoggato.getEmail().equals(articolo.getEmail_vend()))){
            throw new GenericException("Non sei autorizzato a visualizzare questa pagina");
        }

        //crea oggetto vendita
        String idVendita = UUID.randomUUID().toString();
        Double prezzo = articoloDAO.doRetrieveById(idArticolo).getPrezzo();
        String dataVendita = LocalDate.now().toString();
        String emailVend = utenteLoggato.getEmail();

        Vendita vendita = new Vendita(idVendita,idArticolo,prezzo,dataVendita,emailVend);
        //carica vendita nel db
        VenditaDAO venditaDAO = new VenditaDAO();
        int r = venditaDAO.doSell(vendita);

        String responseText = new String();
        if (r>0){
            //elimina record dal db articoli
            articoloDAO.doSell(idArticolo);
            responseText = "ok";
        }else{
            responseText = "no";
        }
        PrintWriter writer = resp.getWriter();
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        writer.write(responseText);
        writer.flush();
        writer.close();

    }
}
