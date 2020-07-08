package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class VenditaDAO {
    public int doSell(Vendita vendita){
        int r = 0;
        try {
            Connection connection = ConPool.getConnection();
            PreparedStatement statement = connection.prepareStatement("insert into vendite(idVendita,idArticolo,prezzo,dataVendita) " +
                    "values(?,?,?,?)");
            statement.setString(1,vendita.getIdVendita());
            statement.setString(2,vendita.getIdArticolo());
            statement.setDouble(3,vendita.getPrezzo());
            statement.setString(4,vendita.getDataVendita());
            r = statement.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return r;
    }
}
