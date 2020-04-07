package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AlbumDAO {

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
