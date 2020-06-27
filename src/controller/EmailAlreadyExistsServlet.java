package controller;


import model.UtenteDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/email-already-exists")
public class EmailAlreadyExistsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String email = req.getParameter("email");
        //controlla se esiste nel db con utenteDAO
        UtenteDAO udao = new UtenteDAO();
        int e = udao.emailAlreadyExists(email);

        PrintWriter writer = resp.getWriter();
        resp.setContentType("text/plain");
        resp.setContentType("UTF-8");
        if (e>0)
            writer.write("esiste");
        else
            writer.write("nonesiste");
        writer.flush();
        writer.close();

    }
}
