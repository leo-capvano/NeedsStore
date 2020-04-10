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
import java.util.List;

@WebServlet("/LoadMore")
public class LoadMore extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int index = Integer.parseInt(req.getParameter("index"));
        ArticoloDAO ardao = new ArticoloDAO();
        List<Articolo> articoli = ardao.doRetrieveNonVendutiFromIndex(index);
        String json = new Gson().toJson(articoli);

        resp.getWriter().write(json);

    }
}
