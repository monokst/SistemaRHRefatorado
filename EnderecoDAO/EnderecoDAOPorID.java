package EnderecoDAO;

import model.Endereco;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.Conexao;

/**
 *
 * @author thamy
 */
public class EnderecoDAOPorID {

 public Endereco buscarPorId(int id_end) throws ClassNotFoundException, SQLException {
    Connection con = Conexao.getConexao();
    PreparedStatement comando = con.prepareStatement(
        "select * from endereco where id_end = ?"
    );
    comando.setInt(1, id_end);
    ResultSet rs = comando.executeQuery();
    Endereco e = null;
    if (rs.next()) {
        e = new Endereco(
            rs.getInt("id_end"),
            rs.getString("rua"),
            rs.getString("bairro"),
            rs.getString("cidade"),
            rs.getString("estado"),
            rs.getInt("cep")
        );
    }
    con.close();
    return e;
}}