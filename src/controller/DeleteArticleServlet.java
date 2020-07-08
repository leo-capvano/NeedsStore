package controller;

import model.Articolo;
import model.ArticoloDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/delArticle")
public class DeleteArticleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String idArticolo = req.getParameter("idArticolo");
        ArticoloDAO articoloDAO = new ArticoloDAO();
        String r = articoloDAO.doDelete(idArticolo);
        PrintWriter writer = resp.getWriter();
        resp.setContentType("UTF-8");
        writer.write(r);
        writer.flush();
        writer.close();

    }
}
