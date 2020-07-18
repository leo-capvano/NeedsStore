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

        HttpSession session = req.getSession();
        //solo gli utenti loggati possono cercare un annuncio
        if (session.getAttribute("utenteLoggato")!=null){
            RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/cerca-page.jsp");
            dispatcher.forward(req,resp);
        }else{
            //usr non autorizzato ad accedere, devi loggarti
            RequestDispatcher dispatcher = req.getRequestDispatcher("homepage.jsp");
            req.setAttribute("error","Devi loggarti per poter cercare un annuncio!");
            dispatcher.forward(req,resp);
        }
    }
}
