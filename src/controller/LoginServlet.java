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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String email = req.getParameter("email");
        String pwd = req.getParameter("pwd");

        UtenteDAO udao = new UtenteDAO();
        Utente u = udao.doLogin(email,pwd);

        if (u!=null){
            //logged in
            req.getSession().setAttribute("utenteLoggato", u);
        }else{
            //not logged
            RequestDispatcher dispatcher1 = req.getRequestDispatcher("/pagelogin.jsp");
            req.setAttribute("errorLogin", "errorLogin");
            dispatcher1.forward(req,resp);
        }

        resp.sendRedirect(req.getContextPath()+"/homepage.jsp");

    }
}
