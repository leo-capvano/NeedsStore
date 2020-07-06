package controller;

import model.ArticoloDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/edit-servlet")
public class editArticoloServlet extends HttpServlet {
    ArticoloDAO ardao = new ArticoloDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String idArticolo = req.getParameter("idArticolo");
        String op = req.getParameter("edit");
        PrintWriter writer = resp.getWriter();

        if (op.equals("desc")){
            String descrizione = req.getParameter("descrizione");
            int r = ardao.doUpdateDescrizione(idArticolo, descrizione);
            resp.setCharacterEncoding("UTF-8");
            resp.setContentType("text/plain");
            if (r==1){
                //success!, restituisci la nuova descrizione
                descrizione = ardao.doRetrieveById(idArticolo).getDescrizione();
                writer.write(descrizione);
                writer.flush();
                writer.close();
            }else{
                writer.write("errore");
                writer.flush();
                writer.close();
            }
        }else if (op.equals("przz")){
            String prezzo = req.getParameter("prezzo");
            int r = ardao.doUpdatePrezzo(idArticolo, prezzo);
            resp.setCharacterEncoding("UTF-8");
            resp.setContentType("text/plain");
            if (r==1){
                //success!, restituisci la nuova descrizione
                prezzo = ardao.doRetrieveById(idArticolo).getDescrizione();
                writer.write(prezzo);
                writer.flush();
                writer.close();
            }else{
                writer.write("errore");
                writer.flush();
                writer.close();
            }
        }else if (op.equals("ttl")){
            String titolo = req.getParameter("titolo");
            int r = ardao.doUpdateTitolo(idArticolo, titolo);
            resp.setCharacterEncoding("UTF-8");
            resp.setContentType("text/plain");
            if (r==1){
                //success!, restituisci la nuova descrizione
                titolo = ardao.doRetrieveById(idArticolo).getDescrizione();
                writer.write(titolo);
                writer.flush();
                writer.close();
            }else{
                writer.write("errore");
                writer.flush();
                writer.close();
            }
        }

    }
}
