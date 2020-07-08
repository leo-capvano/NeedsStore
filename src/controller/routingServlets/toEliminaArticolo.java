package controller.routingServlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/toEliminaArt")
public class toEliminaArticolo extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idArticolo = req.getParameter("eliminaArt");
        req.setAttribute("idArticolo",idArticolo);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/eliminaArticolo-page.jsp");
        dispatcher.forward(req,resp);
    }
}
