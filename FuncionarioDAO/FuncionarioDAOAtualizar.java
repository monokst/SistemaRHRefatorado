package FuncionarioDAO;

import DepartamentoDAO.DepartamentoDAOAtualizar;
import EnderecoDAO.EnderecoDAOAtualizar;
import java.sql.*;
import model.Funcionario;
import util.Conexao;

public class FuncionarioDAOAtualizar {

    public void atualizar(Funcionario f) throws ClassNotFoundException, SQLException {
        
        Connection con = Conexao.getConexao();
        
        try {
            // Atualiza Endereço
            if (f.getEndereco() != null) {
                EnderecoDAOAtualizar endDao = new EnderecoDAOAtualizar();
                endDao.atualizar(f.getEndereco());
            }

            // Atualiza Cargo
            if (f.getDepartamento() != null) {
                DepartamentoDAOAtualizar departamentoDao = new DepartamentoDAOAtualizar();
                departamentoDao.atualizar(f.getDepartamento());
            }

            // Atualiza Funcionário
            String sql = "UPDATE funcionario SET nome=?, cpf=?, data_nascimento=?, " +
                        "data_admissao=?, genero=?, telefone=?, email=?, " +
                        "departamento_id=?, endereco_id=? WHERE id_fun=?";

            PreparedStatement comando = con.prepareStatement(sql);
            
            comando.setString(1, f.getNome());
            comando.setString(2, f.getCpf());
            comando.setDate(3, new java.sql.Date(f.getDataDeNascimento().getTime()));
            comando.setDate(4, new java.sql.Date(f.getDataDeAdmissao().getTime()));
            comando.setString(5, f.getGenero());
            comando.setString(6, f.getTelefone());
            comando.setString(7, f.getEmail());
            comando.setInt(8, f.getDepartamento().getId_departamento());
            comando.setInt(9, f.getEndereco().getId_end());
            comando.setInt(10, f.getId_Fun());

            comando.executeUpdate();

        } finally {
            con.close();
        }
    }
}