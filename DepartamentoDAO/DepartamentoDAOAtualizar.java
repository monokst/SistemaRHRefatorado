package DepartamentoDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.Departamento;
import util.Conexao;

public class DepartamentoDAOAtualizar {
    public void atualizar (Departamento d) throws ClassNotFoundException, SQLException {
        Connection con = Conexao.getConexao();
        PreparedStatement comando = con.prepareStatement("update departamento set nome = ?, funcao = ?, salariobase = ? where id_departamento = ?");
        comando.setString(1, d.getNome());
        comando.setString(2, d.getFuncao());
        comando.setDouble(3, d.getSalarioBase());
        comando.setInt(4, d.getId_departamento());
        comando.execute();
        con.close();
    }
}
