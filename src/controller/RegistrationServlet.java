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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet("/registration-servlet")
public class RegistrationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String nome = req.getParameter("nome");
        if(!checkTxt(nome)){
            throw new GenericException("Formato nome non corretto");
        }
        String cognome = req.getParameter("cognome");
        if(!checkTxt(cognome)){
            throw new GenericException("Formato cognome non corretto");
        }

        String email1 = req.getParameter("email1");
        if (!checkEmail(email1)){
            throw new GenericException("Formato email non corretto");
        }
        String email2 = req.getParameter("email2");
        if (!email2.equals(email1)){throw new GenericException("Formato email non corretto");}

        String pwd1 = req.getParameter("pwd1");
        if (!checkPwd(pwd1)){
            throw new GenericException("La password deve essere lunga almeno 8 caratteri");
        }
        String pwd2 = req.getParameter("pwd2");
        if (!pwd2.equals(pwd1)){throw new GenericException("La password deve essere lunga almeno 8 caratteri");}
        String telefono = req.getParameter("telefono");

        Utente u = new Utente(email1,pwd1,nome,cognome,telefono,false);
        UtenteDAO udao = new UtenteDAO();
        udao.doRegister(u);
        req.getSession().setAttribute("utenteLoggato",u);
        resp.sendRedirect("pagelogin.jsp");


    }

    private boolean checkTxt(String txt) {
        String regex = "[A-Za-z]+";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(txt);
        return matcher.matches();
    }

    private boolean checkEmail(String email) {
        String regex = "[a-z0-9]+@(.[a-z]+)+";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    private boolean checkPwd(String pwd) {
        if (pwd.length()<8)
            return false;
        return true;
    }
}
