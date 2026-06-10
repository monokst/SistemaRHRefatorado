package EnderecoDAO;

import java.sql.*;
import model.Endereco;
import util.Conexao;

public class EnderecoDAOCadastrar {
    public int cadastrar(Endereco e) throws ClassNotFoundException, SQLException {
        Connection con = Conexao.getConexao();
        PreparedStatement comando = con.prepareStatement(
            "INSERT INTO endereco (rua, bairro, cidade, estado, cep) VALUES (?, ?, ?, ?, ?)",
            Statement.RETURN_GENERATED_KEYS
        );

        comando.setString(1, e.getRua());
        comando.setString(2, e.getBairro());
        comando.setString(3, e.getCidade());
        comando.setString(4, e.getEstado());
        comando.setInt(5, e.getCep());

        comando.executeUpdate();

        ResultSet rs = comando.getGeneratedKeys();
        int idGerado = 0;
        if (rs.next()) {
            idGerado = rs.getInt(1);
            e.setId_end(idGerado);
        }

        con.close();
        return idGerado;
    }
}