package FuncionarioDAO;

import java.sql.*;
import model.Funcionario;
import util.Conexao;

public class FuncionarioDAOCadastrar {
    public void cadastrar(Funcionario f) throws ClassNotFoundException, SQLException {
        Connection con = Conexao.getConexao();
        PreparedStatement comando = con.prepareStatement(
            "INSERT INTO funcionario (nome, cpf, data_nascimento, endereco_id, data_admissao, genero, telefone, email, departamento_id) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"
        );

        comando.setString(1, f.getNome());
        comando.setString(2, f.getCpf());
        comando.setDate(3, new java.sql.Date(f.getDataDeNascimento().getTime()));
        comando.setInt(4, f.getEndereco().getId_end());
        comando.setDate(5, new java.sql.Date(f.getDataDeAdmissao().getTime()));
        comando.setString(6, f.getGenero());
        comando.setString(7, f.getTelefone());
        comando.setString(8, f.getEmail());
        comando.setInt(9, f.getDepartamento().getId_departamento());

        comando.executeUpdate();
        con.close();
    }
}