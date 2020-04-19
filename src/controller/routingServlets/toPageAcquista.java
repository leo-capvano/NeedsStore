package controller.routingServlets;

import model.Album;
import model.AlbumDAO;
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

@WebServlet("/toPageAcquista")
public class toPageAcquista extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //get idArticolo
        String idArticolo = req.getParameter("idArticolo");
        ArticoloDAO ardao = new ArticoloDAO();
        AlbumDAO aldao = new AlbumDAO();
        Articolo articolo = ardao.doRetrieveById(idArticolo);
        ArrayList<Album> album = null;

        if (articolo!=null) {
            album = aldao.doRetrieveByArticolo(articolo);

            req.setAttribute("articolo",articolo);
            req.setAttribute("album",album);

            RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/pageacquista.jsp");
            dispatcher.forward(req,resp);
        }else {
            //error articolo non trovato
        }

    }
}
