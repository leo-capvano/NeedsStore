package controller;

import com.google.gson.Gson;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/cercaByCat")
public class CercaByCatServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //recupera la categoria cercata
        String cat = req.getParameter("cat");
        CategoriaDAO categoriaDAO = new CategoriaDAO();
        ArticoloCategoriaDAO articoloCategoriaDAO = new ArticoloCategoriaDAO();
        ArticoloDAO articoloDAO = new ArticoloDAO();

        //si cercano tutti gli articoli in quella categoria
        Categoria c = categoriaDAO.doRetrieveByNome(cat);
        ArrayList<ArticoloCategoria> articoloCategorias = articoloCategoriaDAO.doRetrieveByIdCategoria(c.getIdCategoria());
        ArrayList<Articolo> articolos = new ArrayList<>();
        //per ogni articolo che corrisponde a quella cat. si recuperano tutti i dati articolo
        for (ArticoloCategoria a: articoloCategorias){
            //inserisco solo se l'articolo non è stato venduto
            Articolo art = articoloDAO.doRetrieveById(a.getIdArticolo());
            if (!art.isVenduto())
                articolos.add(art);
        }
        if (articolos.size()<=0){
            //non è stato trovato nulla, restituisco IDLE
            articolos.add(new Articolo("empty","empty","empty","empty",1.0,"empty","empty"));
        }


        PrintWriter writer = resp.getWriter();
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        String json = new Gson().toJson(articolos);
        writer.write(json);
        writer.flush();
        writer.close();


    }
}
