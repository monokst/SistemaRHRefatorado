package util;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Classe utilitária para gerenciar conexões com o banco de dados MySQL.
 */
public class Conexao {

    /**
     * Estabelece uma conexão com o banco de dados MySQL.
     * @return Objeto Connection para interagir com o banco
     * @throws ClassNotFoundException Se o driver JDBC não for encontrado
     * @throws SQLException Se ocorrer um erro na conexão com o banco
     */
    public static Connection getConexao() throws ClassNotFoundException, SQLException {
        // Carrega o driver JDBC do MySQL
        Class.forName("com.mysql.cj.jdbc.Driver");
        // Define a URL de conexão com o banco, incluindo configurações de codificação e fuso horário
        String url = "jdbc:mysql://localhost:3306/SistemaRH?useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
        // Estabelece a conexão com o banco usando usuário e senha
        Connection con = DriverManager.getConnection(url, "root", "1234");
        return con;
    }
}