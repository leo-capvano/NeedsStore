package controller;

import model.Utente;
import model.UtenteDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/registration-servlet")
public class RegistrationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String nome = req.getParameter("nome");
        String cognome = req.getParameter("cognome");
        String email1 = req.getParameter("email1");
        String email2 = req.getParameter("email2");
        String pwd1 = req.getParameter("pwd1");
        String pwd2 = req.getParameter("pwd2");
        String telefono = req.getParameter("telefono");

        if ((!email1.equals(email2))||(!pwd1.equals(pwd2))){
            //error
        }else{
            Utente u = new Utente(email1,pwd1,nome,cognome,telefono,false);
            UtenteDAO udao = new UtenteDAO();
            udao.doRegister(u);
            req.getSession().setAttribute("utenteLoggato",u);
            resp.sendRedirect("pagelogin.jsp");
        }

    }
}
