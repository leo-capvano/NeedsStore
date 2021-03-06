package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

public class ArticoloDAO {

    public int doUpdateTitolo(String idArticolo, String newTitolo){
        int result = 0;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("update articoli set titolo = ? where" +
                    " idArticolo = ?");
            statement.setString(1,newTitolo);
            statement.setString(2, idArticolo);
            result = statement.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return result;
    }

    public int doUpdatePrezzo(String idArticolo, String newPrezzo){
        int result = 0;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("update articoli set prezzo = ? where" +
                    " idArticolo = ?");
            statement.setString(1,newPrezzo);
            statement.setString(2, idArticolo);
            result = statement.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return result;
    }

    public int doUpdateDescrizione(String idArticolo, String newDescrizione){
        int result = 0;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("update articoli set descrizione = ? where" +
                    " idArticolo = ?");
            statement.setString(1,newDescrizione);
            statement.setString(2, idArticolo);
            result = statement.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return result;
    }


    public ArrayList<Articolo> doRetrieveByEmail(String email){
        ArrayList<Articolo> articoli = new ArrayList<>();
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from articoli where email_vend = ? and venduto = 0" +
                    " order by data_inserimento");
            statement.setString(1,email);
            ResultSet r = statement.executeQuery();
            while (r.next()){
                articoli.add(new Articolo(r.getString(1),r.getString(2),r.getString(3),
                        r.getString(4),r.getDouble(5),r.getString(6),r.getString(7),r.getBoolean(8)));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return articoli;
    }

    public ArrayList<Articolo> doRetrieveByTitolo(String titolo, int limit){
        ArrayList<Articolo> articoli = new ArrayList<>();
        try {
            Connection conn = ConPool.getConnection();
            PreparedStatement statement = conn.prepareStatement("select * from articoli where venduto = 0" +
                    " and titolo like '"+titolo+"%' order by data_inserimento desc limit "+limit);
            ResultSet r = statement.executeQuery();
            while (r.next()){
                articoli.add(new Articolo(r.getString(1),r.getString(2),r.getString(3),
                        r.getString(4),r.getDouble(5),r.getString(6),r.getString(7),r.getBoolean(8)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return articoli;
    }

    public ArrayList<Articolo> doRetrieveByTitoloCat(String titolo, int limit){
        ArrayList<Articolo> articoli = new ArrayList<>();
        try {
            Connection conn = ConPool.getConnection();
            PreparedStatement statement = conn.prepareStatement("select * from articoli where venduto = 0" +
                    " and titolo like '"+titolo+"%' order by data_inserimento desc limit "+limit);
            ResultSet r = statement.executeQuery();
            while (r.next()){
                articoli.add(new Articolo(r.getString(1),r.getString(2),r.getString(3),
                        r.getString(4),r.getDouble(5),r.getString(6),r.getString(7),r.getBoolean(8)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return articoli;
    }


    public void doPublish(Articolo a){
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("insert into articoli(idArticolo,titolo,descrizione,email_vend,prezzo,luogo,data_inserimento,venduto)" +
                    "values (?,?,?,?,?,?,?,0)");
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
            PreparedStatement statement = connection.prepareStatement("select * from articoli where venduto = 0 " +
                    "order by data_inserimento, titolo desc limit ? offset ?");
            statement.setInt(1, l);
            statement.setInt(2, offset);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                    articoli.add(new Articolo(resultSet.getString(1),resultSet.getString(2),resultSet.getString(3),
                            resultSet.getString(4),resultSet.getDouble(5),resultSet.getString(6),resultSet.getString(7),resultSet.getBoolean(8)));
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
                        resultSet.getString(4),resultSet.getDouble(5),resultSet.getString(6), resultSet.getString(7),resultSet.getBoolean(8));
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
                        resultSet.getString(4),resultSet.getDouble(5),resultSet.getString(6),resultSet.getString(7),resultSet.getBoolean(8)));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return articoli;
    }

    public ArrayList<Articolo> doRetrieveSold(){
        ArrayList<Articolo> articoli = new ArrayList<Articolo>();
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from articoli where venduto = 1 and idArticolo in " +
                    "(select idArticolo from vendite);");
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

    public String doSell(String idArticolo) {
        int r=0;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement2 = connection.prepareStatement("update articoli set venduto = 1 where idArticolo = ?");
            statement2.setString(1,idArticolo);
            r = statement2.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        if (r==1)
            return "si";
        return "no";
    }


    public String doDelete(String idArticolo) {
        int r=0;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement2 = connection.prepareStatement("delete from articoli where idArticolo = ?");
            statement2.setString(1,idArticolo);
            r = statement2.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        if (r==1)
            return "si";
        return "no";
    }

}
