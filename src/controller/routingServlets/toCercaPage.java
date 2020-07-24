package controller.routingServlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/cerca-servlet")
public class toCercaPage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //tutti gli utenti possono cercare un annuncio
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/cerca-page.jsp");
        dispatcher.forward(req,resp);

    }
}
