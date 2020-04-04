package controller;

import model.Articolo;
import model.ArticoloDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "HomePagePreparator",urlPatterns = "/index.html")
public class HomePagePreparator extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //carica il catalogo di articoli
        var adao = new ArticoloDAO();
        ArrayList<Articolo> articoli = adao.doRetrieveAll();
        req.getSession().setAttribute("articoli",articoli);

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/homepage.jsp");
        dispatcher.forward(req,resp);
    }
}