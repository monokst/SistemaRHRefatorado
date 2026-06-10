package DepartamentoDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Departamento;
import util.Conexao;

/**
 *
 * @author thamy
 */
public class DepartamentoDAOConsultarTodos {

    public List<Departamento> consultarTodos() throws ClassNotFoundException, SQLException {

        Connection con = Conexao.getConexao();
        PreparedStatement comando = con.prepareStatement("SELECT * FROM departamento");
        ResultSet rs = comando.executeQuery();

        List<Departamento> lista = new ArrayList<>();

        while (rs.next()) {
            Departamento dep = new Departamento(
                rs.getInt("id_departamento"),  
                rs.getString("nome"),
                rs.getString("funcao"),
                rs.getDouble("salarioBase")
            );

            lista.add(dep);
        }

        con.close();
        return lista;
    }
}
