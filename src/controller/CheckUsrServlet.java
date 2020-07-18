package controller;

import com.google.gson.Gson;
import model.Utente;
import model.UtenteDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/checkUsr")
public class CheckUsrServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //ricevo email e pwd e controllo se sono corrette
        //se si => ok altrimenti => not ok

        String email = req.getParameter("email");
        String pwd = req.getParameter("pwd");

        UtenteDAO udao = new UtenteDAO();
        Utente u = udao.doLogin(email,pwd);

        String responseString;
        if (u!=null){
            responseString = "ok";
        }else{
            responseString = "not ok";
        }

        PrintWriter writer = resp.getWriter();
        resp.setCharacterEncoding("UTF-8");
        writer.write(responseString);
        writer.flush();
        writer.close();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }
}
