package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ArticoloCategoriaDAO {
    public ArrayList<ArticoloCategoria> doRetrieveByIdArticolo(String idArticolo){
        ArrayList<ArticoloCategoria> articolo_categoria = new ArrayList<ArticoloCategoria>();
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from articoli_categorie" +
                    " where idArticolo = ?");
            statement.setString(1,idArticolo);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                articolo_categoria.add(new ArticoloCategoria(resultSet.getString(1),resultSet.getInt(2)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return articolo_categoria;
    }
}
