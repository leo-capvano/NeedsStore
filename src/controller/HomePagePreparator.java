package controller;

import model.Articolo;
import model.ArticoloDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

@WebServlet(name = "HomePagePreparator",urlPatterns = "/index.html")
public class HomePagePreparator extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //inizializzo la sessione dei preferiti e rimando alla homepage
        HttpSession session = req.getSession();
        HashMap<String,String> preferiti = new HashMap<>();
        session.setAttribute("preferiti",preferiti);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/homepage.jsp");
        dispatcher.forward(req,resp);
    }
}
