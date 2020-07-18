package controller;


import model.GenericException;
import model.Utente;
import model.UtenteDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editUser")
public class EditUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Utente utenteLoggato = (Utente) req.getSession().getAttribute("utenteLoggato");
        if ((!utenteLoggato.isAdmin())||(utenteLoggato==null)){
            throw new GenericException("non sei autorizzato! :(");
        }


        UtenteDAO utenteDAO = new UtenteDAO();
        String emailUtente = req.getParameter("emailUtente");
        Utente utente = utenteDAO.doRetrieveByEmail(emailUtente);

        //recupera parametri
        String nome = req.getParameter("nome");
        String cognome = req.getParameter("cognome");
        String telefono = req.getParameter("telefono");

        if (nome!=null){
            //è stata richiesta la modifica del nome
            utenteDAO.doEditNome(emailUtente,nome);
        }else if (cognome!=null){
            //è stata richiesta la modifica del cognome
            utenteDAO.doEditCognome(emailUtente,cognome);
        }else if (telefono!=null){
            //è stata richiesta la modifica del telefono
            utenteDAO.doEditTelefono(emailUtente,telefono);
        }

        req.setAttribute("email", utente.getEmail());
        RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/userDetail-page.jsp");
        dispatcher.forward(req,resp);


    }
}
