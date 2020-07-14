package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class VenditaDAO {

    public ArrayList<Vendita> doRetrieveAll(){
        ArrayList<Vendita> vendite = new ArrayList<>();
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from vendite");
            ResultSet r = statement.executeQuery();
            while (r.next()){
                vendite.add(new Vendita(r.getString(1),r.getString(2),r.getDouble(3),r.getString(4),r.getString(5)));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return vendite;
    }


    public ArrayList<Vendita> doRetrieveByUser(String email){
        ArrayList<Vendita> vendite = new ArrayList<>();
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from vendite where emailVend = ?");
            statement.setString(1,email);
            ResultSet r = statement.executeQuery();
            while (r.next()){
                vendite.add(new Vendita(r.getString(1),r.getString(2),r.getDouble(3),r.getString(4),r.getString(5)));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return vendite;
    }


    public int doSell(Vendita vendita){
        int r = 0;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("insert into vendite(idVendita,idArticolo,prezzo,dataVendita,emailVend) " +
                    "values(?,?,?,?,?)");
            statement.setString(1,vendita.getIdVendita());
            statement.setString(2,vendita.getIdArticolo());
            statement.setDouble(3,vendita.getPrezzo());
            statement.setString(4,vendita.getDataVendita());
            statement.setString(5, vendita.getEmailVend());
            r = statement.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return r;
    }


    public Vendita doRetrieveByIdArticolo(String idArticolo){
        Vendita vendita = null;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from vendite where idArticolo = ?");
            statement.setString(1,idArticolo);
            ResultSet r = statement.executeQuery();
            while (r.next()){
                vendita = new Vendita(r.getString(1),r.getString(2),r.getDouble(3),r.getString(4),r.getString(5));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return vendita;
    }


}
