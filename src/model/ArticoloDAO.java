package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

public class ArticoloDAO {

    public ArrayList<Articolo> doRetrieveByTitolo(String titolo, int limit){
        ArrayList<Articolo> articoli = new ArrayList<>();
        try {
            Connection conn = ConPool.getConnection();
            PreparedStatement statement = conn.prepareStatement("select * from articoli where idArticolo not in " +
                    "(select idArticolo from acquisti) and titolo like '"+titolo+"%' order by data_inserimento desc limit "+limit);
            ResultSet r = statement.executeQuery();
            while (r.next()){
                articoli.add(new Articolo(r.getString(1),r.getString(2),r.getString(3),
                        r.getString(4),r.getDouble(5),r.getString(6),r.getString(7)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return articoli;
    }


    public void doPublish(Articolo a){
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("insert into articoli(idArticolo,titolo,descrizione,email_vend,prezzo,luogo,data_inserimento)" +
                    "values (?,?,?,?,?,?,?)");
            statement.setString(1,a.getIdArticolo());
            statement.setString(2,a.getTitolo());
            statement.setString(3,a.getDescrizione());
            statement.setString(4,a.getEmail_vend());
            statement.setDouble(5,a.getPrezzo());
            statement.setString(6,a.getLuogo());
            LocalDate data_inserimento = LocalDate.now();
            statement.setString(7,data_inserimento.toString());
            int r = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Articolo> doRetrieve(int l, int offset){
        ArrayList<Articolo> articoli = new ArrayList<Articolo>();
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from articoli where idArticolo not in " +
                    "(select idArticolo from acquisti) order by data_inserimento desc limit ? offset ?");
            statement.setInt(1, l);
            statement.setInt(2, offset);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                    articoli.add(new Articolo(resultSet.getString(1),resultSet.getString(2),resultSet.getString(3),
                            resultSet.getString(4),resultSet.getDouble(5),resultSet.getString(6),resultSet.getString(7)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return articoli;
    }

    public ArrayList<Articolo> doRetrieveNonVendutiTenFromIndex(int index){
        ArrayList<Articolo> articoli = new ArrayList<Articolo>();
        int i = 0;
        int caricati = 0;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from articoli where idArticolo not in " +
                    "(select idArticolo from acquisti) order by data_inserimento desc");
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                if ((i>=index)&&(caricati<10)){
                    articoli.add(new Articolo(resultSet.getString(1),resultSet.getString(2),resultSet.getString(3),
                            resultSet.getString(4),resultSet.getDouble(5),resultSet.getString(6),resultSet.getString(7)));
                    caricati++;
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
                    "(select idArticolo from acquisti) order by data_inserimento desc");
            ResultSet resultSet = statement.executeQuery();
            while ((resultSet.next())&&(i<10)){
                articoli.add(new Articolo(resultSet.getString(1),resultSet.getString(2),resultSet.getString(3),
                        resultSet.getString(4),resultSet.getDouble(5),resultSet.getString(6),resultSet.getString(7)));
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
                    "(select idArticolo from acquisti) order by data_inserimento desc");
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                articoli.add(new Articolo(resultSet.getString(1),resultSet.getString(2),resultSet.getString(3),
                        resultSet.getString(4),resultSet.getDouble(5),resultSet.getString(6),resultSet.getString(7)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return articoli;
    }

    public Articolo doRetrieveById(String idArticolo){
        Articolo a = null;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from articoli where idArticolo = ?");
            statement.setString(1,idArticolo);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                a = new Articolo(resultSet.getString(1),resultSet.getString(2),resultSet.getString(3),
                        resultSet.getString(4),resultSet.getDouble(5),resultSet.getString(6), resultSet.getString(7));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return a;
    }

    public ArrayList<Articolo> doRetrieveAll(){
        ArrayList<Articolo> articoli = new ArrayList<Articolo>();
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from articoli");
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                articoli.add(new Articolo(resultSet.getString(1),resultSet.getString(2),resultSet.getString(3),
                        resultSet.getString(4),resultSet.getDouble(5),resultSet.getString(6),resultSet.getString(7)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return articoli;
    }

}
