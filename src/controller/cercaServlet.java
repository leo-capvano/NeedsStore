package controller;


import com.google.gson.Gson;
import model.Articolo;
import model.ArticoloDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/cercaServlet")
public class cercaServlet extends HttpServlet {
    ArticoloDAO articoloDAO = new ArticoloDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String written = req.getParameter("written");
        ArrayList<Articolo> articoli = articoloDAO.doRetrieveByTitolo(written, 10);
        if (articoli.size()<=0){
            //non è stato trovato nulla
            articoli.add(new Articolo("empty","empty","empty","empty",1.0,"empty","empty"));
        }
        String json = new Gson().toJson(articoli);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter writer = resp.getWriter();
        writer.write(json);
        writer.flush();
        writer.close();


    }
}
