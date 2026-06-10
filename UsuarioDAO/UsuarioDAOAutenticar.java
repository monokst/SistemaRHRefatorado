package UsuarioDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Usuario;
import util.Conexao;

public class UsuarioDAOAutenticar {
     public Usuario autenticar(String email, String senha) throws ClassNotFoundException, SQLException {
       
        Connection con = Conexao.getConexao();
        
        PreparedStatement comando = con.prepareStatement("SELECT * FROM usuario WHERE email = ? AND senha = ?");
     
        comando.setString(1, email);
        comando.setString(2, senha);
     
        
        ResultSet rs = comando.executeQuery();
       
        Usuario usuario = null;
        if (rs.next()) {
           
            usuario = new Usuario();
            usuario.setId(rs.getInt("id"));
            usuario.setEmail(rs.getString("email"));
            usuario.setSenha(rs.getString("senha"));
        }
       
        con.close();
        return usuario;
    }
}
