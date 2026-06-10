package EnderecoDAO;

import model.Endereco;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.Conexao;

public class EnderecoDAOConsultarTodos {

    public List<Endereco> consultarTodos() throws ClassNotFoundException, SQLException {

        Connection con = Conexao.getConexao();
        PreparedStatement comando = con.prepareStatement("select * from endereco");
        ResultSet rs = comando.executeQuery();
        List<Endereco> lista = new ArrayList<>();
        while (rs.next()) {
            Endereco e = new Endereco(
                rs.getInt("id_end"),
                rs.getString("rua"),
                rs.getString("bairro"),
                rs.getString("cidade"),
                rs.getString("estado"),
                rs.getInt("cep")
            );
            lista.add(e);
        }
        con.close();
        return lista;
    }
}


