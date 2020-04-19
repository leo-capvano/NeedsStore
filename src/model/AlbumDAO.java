package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class AlbumDAO {

    public ArrayList<Album> doRetrieveByIdArticolo(String a){
        ArrayList<Album> album = new ArrayList<Album>();
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from album where idArticolo = ?");
            statement.setString(1,a);
            ResultSet r = statement.executeQuery();
            while (r.next()){
                album.add(new Album(r.getString(1),r.getString(2),r.getString(3)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return album;
    }

    public ArrayList<Album> doRetrieveByArticolo(Articolo a){
        ArrayList<Album> album = new ArrayList<Album>();
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("select * from album where idArticolo = ?");
            statement.setString(1,a.getIdArticolo());
            ResultSet r = statement.executeQuery();
            while (r.next()){
                album.add(new Album(r.getString(1),r.getString(2),r.getString(3)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return album;
    }


    public void doInsertAlbum(Album a){
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("insert into album(idAlbum,path,idArticolo)" +
                    "values (?,?,?)");
            statement.setString(1,a.getIdAlbum());
            statement.setString(2,a.getPath());
            statement.setString(3,a.getIdArticolo());
            int r = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


}
