package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ArticoloDAO {


    public void doPublish(Articolo a){
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("insert into articoli(idArticolo,titolo,descrizione,email_vend,prezzo,luogo)" +
                    "values (?,?,?,?,?,?)");
            statement.setString(1,a.getIdArticolo());
            statement.setString(2,a.getTitolo());
            statement.setString(3,a.getDescrizione());
            statement.setString(4,a.getEmail_vend());
            statement.setDouble(5,a.getPrezzo());
            statement.setString(6,a.getLuogo());
            int r = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Articolo> doRetrieveNonVendutiFromIndex(int index){
        ArrayList<Articolo> articoli = new ArrayList<Articolo>();
        int i = 0;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from articoli where idArticolo not in " +
                    "(select idArticolo from acquisti)");
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                if (i>=index){
                    articoli.add(new Articolo(resultSet.getString(1),resultSet.getString(2),resultSet.getString(3),
                            resultSet.getString(4),resultSet.getDouble(5),resultSet.getString(6)));
                }
                i++;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return articoli;
    }

    public ArrayList<Articolo> doRetrieveNonVendutiTen(){
        ArrayList<Articolo> articoli = new ArrayList<Articolo>();
        int i = 0;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from articoli where idArticolo not in " +
                    "(select idArticolo from acquisti)");
            ResultSet resultSet = statement.executeQuery();
            while ((resultSet.next())&&(i<10)){
                articoli.add(new Articolo(resultSet.getString(1),resultSet.getString(2),resultSet.getString(3),
                        resultSet.getString(4),resultSet.getDouble(5),resultSet.getString(6)));
                i++;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return articoli;
    }

    public ArrayList<Articolo> doRetrieveNonVenduti(){
        ArrayList<Articolo> articoli = new ArrayList<Articolo>();
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from articoli where idArticolo not in " +
                    "(select idArticolo from acquisti)");
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
