package controller;


import com.google.gson.Gson;
import com.mysql.cj.protocol.x.Notice;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;

@WebServlet("/cercaServlet")
public class cercaServlet extends HttpServlet {
    ArticoloDAO articoloDAO = new ArticoloDAO();
    ArticoloCategoriaDAO articoloCategoriaDAO = new ArticoloCategoriaDAO();
    CategoriaDAO categoriaDAO = new CategoriaDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //recupero il titolo da cercare
        String written = req.getParameter("written");

        //recupero le categorie da cercare(con valore a true)
        ArrayList<String> categorieDaCercare = new ArrayList<>();
        Enumeration parametriEnum = req.getParameterNames();
        Iterator parametri = parametriEnum.asIterator();
        parametri.next(); //skippo il primo parametro "written"
        //per ogni parametro(categoria) controllo se il suo valore (categoria=true/false)
        //è true. Se si, aggiungo la categoria alle categorieDaCercare
        while (parametri.hasNext()){
            String parametro = (String) parametri.next();
            String valore = req.getParameter(parametro);
            if (valore.equals("true")){
                categorieDaCercare.add(parametro);
            }
        }


        ArrayList<Articolo> articoli = articoloDAO.doRetrieveByTitolo(written, 10);
        ArrayList<Articolo> articoliResult = new ArrayList<>(); //articoli idonei ai filtri di categorie
        if (articoli.size()<=0){
            //non è stato trovato nulla, restituisco IDLE
            articoli.add(new Articolo("empty","empty","empty","empty",1.0,"empty","empty"));
        }
        //filtro ogni articolo che matcha col titolo
        for (Articolo a: articoli){
            //per ogni articolo recupero le categorie a cui appartiene
            ArrayList<ArticoloCategoria> articoloCategoria = articoloCategoriaDAO.doRetrieveByIdArticolo(a.getIdArticolo());
            ArrayList<String> categorieArticoloA = new ArrayList<>();

            //recupero le categorie dell'articolo a e vedo se almeno una
            //è presente nelle categorie da cercare, altrimenti lo rimuovo da
            //articoli
            //per ogni categoria recupero il suo nome(UNIQUE)
            for (ArticoloCategoria ac: articoloCategoria){
                Categoria categoria = categoriaDAO.doRetrieveById(ac.getIdCategoria());
                categorieArticoloA.add(categoria.getNome());
            }

            //controllo se almeno una categoria dell'articolo a
            //è presente in categorieDaCercare
            Boolean ok = false;
            for (String cat:categorieArticoloA){
                if (categorieDaCercare.contains(cat))
                    ok=true;
            }
            //se ok=true, allora almeno una categoria di a
            //appartiene a quelle che cercavo
            //allora aggiungo a, all'arraylist che darò in output
            if (ok)
                articoliResult.add(a);
        }


        //converto lista di articoli in json e la restituisco
        String json = new Gson().toJson(articoliResult);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter writer = resp.getWriter();
        writer.write(json);
        writer.flush();
        writer.close();


    }
}
