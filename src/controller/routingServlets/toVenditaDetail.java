package controller.routingServlets;

import model.Utente;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/venditaDetail")
public class toVenditaDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utente utenteLoggato = (Utente) req.getSession().getAttribute("utenteLoggato");

        //recupera idArticolo venduto
        String idArticoloVenduto = req.getParameter("idArticoloVenduto");
        req.setAttribute("idArticoloVenduto",idArticoloVenduto);

        if ((utenteLoggato!=null)&&(utenteLoggato.isAdmin())){
            RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/venditaDetail-page.jsp");
            dispatcher.forward(req,resp);
        }else {
            req.setAttribute("error","non sei autorizzato! :(");
            RequestDispatcher dispatcher = req.getRequestDispatcher("homepage.jsp");
            dispatcher.forward(req,resp);
        }
    }
}
