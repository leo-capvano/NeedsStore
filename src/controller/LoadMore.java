package controller;

import com.google.gson.Gson;
import model.Album;
import model.Articolo;
import model.ArticoloDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.List;

@WebServlet("/LoadMore")
public class LoadMore extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int index = Integer.parseInt(req.getParameter("index"));
        ArticoloDAO ardao = new ArticoloDAO();
        List<Articolo> articoli = ardao.doRetrieveNonVendutiTenFromIndex(index);
        if (articoli.size()==0){
            articoli.add(new Articolo("empty","empty","empty","empty",1.0,"empty","empty"));
        }
        String json = new Gson().toJson(articoli);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        out.write(json);
        out.flush();
        out.close();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }
}
