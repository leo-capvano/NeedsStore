package controller.routingServlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/toModificaArt")
public class toModificaArticolo extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idArt = (String)req.getParameter("modificaArt");
        req.setAttribute("articoloToEdit",idArt);
        RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/modificaArticolo-page.jsp");
        dispatcher.forward(req,resp);
    }
}
