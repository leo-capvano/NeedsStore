package controller;

import com.google.gson.Gson;
import model.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/adminPage")
public class AdminPageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        //recupero utente admin
        Utente utenteLoggato =(Utente) req.getSession().getAttribute("utenteLoggato");
        if ((utenteLoggato==null)||(!utenteLoggato.isAdmin()))
            throw new GenericException("Non sei autorizzato :(");

        if (req.getParameter("btnAdmin")!=null) {
            //è stato premuto btnAdmin, si effettua solo controllo e ridirezione verso la jsp
            //controllo se l'utente è admin
            String dest = "";
            if (utenteLoggato.isAdmin()) {
                dest = "WEB-INF/admin-page.jsp";
            } else {
                dest = "homepage.jsp";
                req.setAttribute("error", "Mi dispiace, non sei autorizzato! :(");
            }

            RequestDispatcher dispatcher = req.getRequestDispatcher(dest);
            dispatcher.forward(req, resp);
        }else if (req.getParameter("btnGetUsers")!=null){
            //è stato premuto ul btnGetUsers => carichiamo e restituiamo tutti gli utenti nel db
            UtenteDAO utenteDAO = new UtenteDAO();
            ArrayList<Utente> utenti = utenteDAO.doRetrieveAll();
            String utentiJson = new Gson().toJson(utenti);

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            PrintWriter writer = resp.getWriter();
            writer.write(utentiJson);
            writer.flush();
            writer.close();
        }else if (req.getParameter("btnGetVendite")!=null) {
            //è stato premuto il btnGetVendite => carichiamo e restituiamo tutte le vendite nel db
            ArticoloDAO articoloDAO = new ArticoloDAO();
            ArrayList<Articolo> articoliVenduti = articoloDAO.doRetrieveSold();

            String articoliJson = new Gson().toJson(articoliVenduti);

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            PrintWriter writer = resp.getWriter();
            writer.write(articoliJson);
            writer.flush();
            writer.close();
        }else if (req.getParameter("btnAddCat")!=null){
            //è statop premuto il pulsante addCat => aggiungi una categoria al db
            String nome = req.getParameter("nome");
            String descrizione = req.getParameter("descrizione");

            CategoriaDAO categoriaDAO = new CategoriaDAO();
            int r = categoriaDAO.doInsert(nome, descrizione);
            if (r<=0){
                throw new GenericException("errore nell'aggiunta di una categoria, assicurati che il nome sia unico! :(");
            }
            ArrayList<Categoria> categorie = (ArrayList<Categoria>)getServletContext().getAttribute("categorie");
            categorie.add(categoriaDAO.doRetrieveByNome(nome));
            getServletContext().setAttribute("categorie",categorie);

            RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/admin-page.jsp");
            dispatcher.forward(req,resp);
        }



    }
}
