package controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import model.GenericException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;

@WebServlet("/selectProvincia")

public class SelectProvinciaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //recupera la stringa scritta in input e cerca le province che matchano, poi restituiscile

        String written = req.getParameter("written").toUpperCase();
        //cerca nel json italia.json
        ArrayList<String> provs = new ArrayList<>();
        JsonParser parser = new JsonParser();
        try {
            JsonObject json =(JsonObject) parser.parse(new FileReader(getServletContext().getRealPath("json/italia.json")));
            JsonArray regioni = (JsonArray) json.get("regioni");
            for (int i= 0; i<regioni.size(); i++){
                JsonArray province =(JsonArray) regioni.get(i).getAsJsonObject().get("capoluoghi");
                Iterator iterator = province.iterator();
                while (iterator.hasNext()){
                    String val = (String) iterator.next().toString().toUpperCase();
                    String valClear = val.substring(1,val.length()-1);
                    if (valClear.contains(written)){
                        provs.add(valClear);
                    }
                }
            }
        } catch (FileNotFoundException e) {
            throw new GenericException("Errore");
        }

        String json = new Gson().toJson(provs);
        resp.setContentType("application/json");
        PrintWriter writer = resp.getWriter();
        writer.write(json);
        writer.flush();
        writer.close();

    }
}
