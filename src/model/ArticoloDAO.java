package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ArticoloDAO {

    public ArrayList<Articolo> doRetrieveAll(){
        ArrayList<Articolo> articoli = new ArrayList<Articolo>();
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from articoli");
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                articoli.add(new Articolo(resultSet.getString(1),resultSet.getString(2),resultSet.getString(3),
                        resultSet.getString(4),resultSet.getDouble(5),resultSet.getString(6)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return articoli;
    }

}
