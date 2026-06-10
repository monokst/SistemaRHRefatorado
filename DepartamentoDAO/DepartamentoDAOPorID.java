package DepartamentoDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Departamento;
import util.Conexao;

public class DepartamentoDAOPorID {
public Departamento buscarPorId(int id_departamento) throws ClassNotFoundException, SQLException {
    Connection con = Conexao.getConexao();
    PreparedStatement comando = con.prepareStatement(
        "select id_departamento, nome, funcao, salarioBase from departamento where id_departamento = ?"
    );
    comando.setInt(1, id_departamento);
    ResultSet rs = comando.executeQuery();
    Departamento dep = null;
    if (rs.next()) {
        dep = new Departamento(
            rs.getInt("id_depatamento"),
            rs.getString("nome"),
            rs.getString("funcao"),
            rs.getDouble("salarioBase")
        );
    }
    con.close();
    return dep;
}
 }