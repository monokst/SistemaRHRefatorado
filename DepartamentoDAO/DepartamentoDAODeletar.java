package DepartamentoDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.Departamento;
import util.Conexao;

public class DepartamentoDAODeletar {
        public void deletar(Departamento d) throws ClassNotFoundException, SQLException {
        Connection con = Conexao.getConexao();
        PreparedStatement comando = con.prepareStatement("delete from departamento where id_departamento = ?");
        comando.setInt(1, d.getId_departamento());
        comando.execute();
        con.close();
    }
}
