package model;

import javax.swing.plaf.nimbus.State;
import java.sql.*;

public class UtenteDAO {

    public int emailAlreadyExists(String email){
        int numEmails = 0;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select count(*) from utenti" +
                    " where email = ?");
            statement.setString(1,email);
            ResultSet resultSet = statement.executeQuery();
            resultSet.next();
            numEmails =  resultSet.getInt(1);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return numEmails;
    }

    public Utente doRetrieveByEmail(String email){
        Utente u = null;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from utenti where email = ?");
            statement.setString(1,email);
            ResultSet r = statement.executeQuery();
            if (r.next()){
                u = new Utente(r.getString(1),r.getString(2),r.getString(3),r.getString(4),
                        r.getString(5),r.getBoolean(6));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return u;
    }

    public void doRegister(Utente u){
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("insert into utenti(email,pwd,nome,cognome,telefono,admin) " +
                    "values(?,sha1(?),?,?,?,?)");
            statement.setString(1,u.getEmail());
            statement.setString(2,u.getPwd());
            statement.setString(3,u.getNome());
            statement.setString(4,u.getCognome());
            statement.setString(5,u.getTelefono());
            statement.setBoolean(6,u.isAdmin());
            int r = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Utente doLogin(String email, String pwd){
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from utenti where email = ? and pwd = SHA1(?)");
            statement.setString(1,email);
            statement.setString(2,pwd);
            ResultSet r = statement.executeQuery();
            if (r.next()){
                Utente u = new Utente(r.getString(1),r.getString(2),r.getString(3), r.getString(4),
                        r.getString(5),r.getBoolean(6));
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
