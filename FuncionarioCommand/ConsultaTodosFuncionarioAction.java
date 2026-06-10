package FuncionarioCommand;

import Command.ICommand;
import FuncionarioDAO.FuncionarioDAOConsultarTodos;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Funcionario;
 
public class ConsultaTodosFuncionarioAction implements ICommand {
 
    @Override
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String msg = "";
 
        try {
            FuncionarioDAOConsultarTodos dao = new FuncionarioDAOConsultarTodos();
            List<Funcionario> lista = dao.consultarTodos();
 
            request.setAttribute("lista", lista);
            return "consultartodos.jsp";
 
        } catch (Exception ex) {
            msg = "Erro ao consultar funcionários: " + ex.getMessage();
        }
 
        request.setAttribute("msg", msg);
        return "resultado.jsp";
    }
}