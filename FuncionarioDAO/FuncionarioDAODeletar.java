package FuncionarioDAO;

import DepartamentoDAO.DepartamentoDAODeletar;
import EnderecoDAO.EnderecoDAODeletar;
import java.sql.*;
import model.Funcionario;
import util.Conexao;

public class FuncionarioDAODeletar {

    public void deletar(int id_fun) throws ClassNotFoundException, SQLException {
        
        Connection con = Conexao.getConexao();
        
        try {
            FuncionarioDAOPorID busca = new FuncionarioDAOPorID();
            Funcionario f = busca.buscarPorId(id_fun);

            if (f != null) {
                // Deleta Funcionário
                String sql = "DELETE FROM funcionario WHERE id_fun = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, id_fun);
                ps.executeUpdate();

               
                if (f.getEndereco() != null) {
                    EnderecoDAODeletar endDao = new EnderecoDAODeletar();
                    endDao.deletar(f.getEndereco().getId_end());
                }

                if (f.getDepartamento() != null) {
                    DepartamentoDAODeletar departamentoDao = new DepartamentoDAODeletar();
                    departamentoDao.deletar(f.getDepartamento());
                }
            }
        } finally {
            con.close();
        }
    }
}