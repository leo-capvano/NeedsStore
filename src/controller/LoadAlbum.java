package controller;

import com.google.gson.Gson;
import model.Album;
import model.AlbumDAO;
import model.Articolo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Array;
import java.util.ArrayList;

@WebServlet("/LoadAlbum")
public class LoadAlbum extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //idArticolo
        String idArticolo = req.getParameter("idArticolo");
        var aldao = new AlbumDAO();
        ArrayList<Album> articoli = aldao.doRetrieveByIdArticolo(idArticolo);
        if (articoli.size()==0){
            articoli.add(new Album("empty","empty","empty"));
        }
        String json = new Gson().toJson(articoli);

        PrintWriter out = resp.getWriter();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        out.write(json);
        out.flush();
        out.close();
    }
}
