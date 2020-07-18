package controller.routingServlets;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import model.Articolo;
import model.GenericException;
import model.Utente;
import netscape.javascript.JSObject;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.util.Iterator;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet("/toUploadphoto")
public class toUploadphoto extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Utente utenteLoggato = (Utente) req.getSession().getAttribute("utenteLoggato");
        if (utenteLoggato==null){
            throw new GenericException("Non sei autorizzato a visualizzare questa pagina!");
        }

        String idArticolo = UUID.randomUUID().toString();

        String titolo = req.getParameter("titolo");
        if(!validateTitolo(titolo)){
            throw new GenericException("I caratteri .\\()=&%$£!' non sono ammessi nel titolo");
        }

        String descrizione = req.getParameter("descrizione");

        //ricerca in json provincie italiane, controlla se è presente nel file json
        String luogo = req.getParameter("luogo");
        if (!validateLuogo(luogo.toUpperCase())){
            throw new GenericException("Provincia di vendita non valida");
        }

        //non necessario
        Double prezzo = Double.parseDouble(req.getParameter("prezzo"));


        String email_vend = utenteLoggato.getEmail();
        LocalDate data_inserimento = LocalDate.now();
        Articolo newArticolo = new Articolo(idArticolo,titolo,descrizione,email_vend,prezzo,luogo,data_inserimento.toString());

        HttpSession session = req.getSession();
        synchronized (session){
            session.setAttribute("newArticolo",newArticolo);
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/uploadphoto.jsp");
        dispatcher.forward(req,resp);
    }

    private boolean validateTitolo(String titolo) {
        Pattern pattern = Pattern.compile("([^(.\\()=&%$£!')]+)");
        Matcher matcher = pattern.matcher(titolo);
        return matcher.matches();

    }

    private boolean validateLuogo(String luogo) {
        JsonParser parser = new JsonParser();
        try {
            JsonObject json =(JsonObject) parser.parse(new FileReader(getServletContext().getRealPath("json/italia.json")));
            JsonArray regioni = (JsonArray) json.get("regioni");
            for (int i= 0; i<regioni.size(); i++){
                JsonArray province =(JsonArray) regioni.get(i).getAsJsonObject().get("capoluoghi");
                Iterator iterator = province.iterator();
                while (iterator.hasNext()){
                    String val = (String) iterator.next().toString();
                    String valClear = val.substring(1,val.length()-1).toUpperCase();
                    if (luogo.compareTo(valClear)==0)
                        return true;
                }
            }
        } catch (FileNotFoundException e) {
            throw new GenericException("Errore nel controllo dei dati");
        }
        return false;
    }
}
