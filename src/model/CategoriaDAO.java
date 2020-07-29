package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CategoriaDAO {
    public ArrayList<Categoria> doRetrieveAll(){
        ArrayList<Categoria> categorie = new ArrayList<Categoria>();
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from categorie");
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                categorie.add(new Categoria(resultSet.getInt(1),resultSet.getString(2),resultSet.getString(3)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categorie;
    }

    public Categoria doRetrieveById(int idCategoria){
        Categoria c = null;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from categorie" +
                    " where idCategoria = ?");
            statement.setInt(1,idCategoria);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                c = new Categoria(resultSet.getInt(1),resultSet.getString(2),resultSet.getString(3));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return c;
    }

    public Categoria doRetrieveByNome(String nome){
        Categoria c = null;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from categorie" +
                    " where nome = ?");
            statement.setString(1,nome);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                c = new Categoria(resultSet.getInt(1),resultSet.getString(2),resultSet.getString(3));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return c;
    }

    public int doInsert(String nome, String descrizione) {
        int r = 0;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("insert into categorie(nome,descrizione)" +
                    " values(?,?)");
            statement.setString(1,nome);
            statement.setString(2,descrizione);
            r = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return r;
    }
}
