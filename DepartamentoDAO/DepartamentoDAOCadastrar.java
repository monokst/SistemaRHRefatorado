package DepartamentoDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import model.Departamento;
import util.Conexao;

public class DepartamentoDAOCadastrar {
    public int cadastrar(Departamento d) throws ClassNotFoundException, SQLException {
        Connection con = Conexao.getConexao();
        PreparedStatement comando = con.prepareStatement(
            "INSERT INTO departamento (nome, funcao, salarioBase) VALUES (?, ?, ?)",
            Statement.RETURN_GENERATED_KEYS
        );

        comando.setString(1, d.getNome());
        comando.setString(2, d.getFuncao());
        comando.setDouble(3, d.getSalarioBase());

        comando.executeUpdate();

        ResultSet rs = comando.getGeneratedKeys();
        int idGerado = 0;
        if (rs.next()) {
            idGerado = rs.getInt(1);
            d.setId_departamento(idGerado);
        }

        con.close();
        return idGerado;
    }
}
