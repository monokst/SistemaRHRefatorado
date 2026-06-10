
package EnderecoCommand;

import Command.ICommand;
import EnderecoDAO.EnderecoDAOConsultarTodos;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Endereco;


public class ConsultaTodosEnderecoAction implements ICommand{
          @Override
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        EnderecoDAOConsultarTodos edao = new EnderecoDAOConsultarTodos();
        try {
            List<Endereco> lend = edao.consultarTodos();
            request.setAttribute("lend", lend);
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
        return "resultadoconsultartodos.jsp";
    }
}