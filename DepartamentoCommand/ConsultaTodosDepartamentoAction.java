package DepartamentoCommand;

import Command.ICommand;
import DepartamentoDAO.DepartamentoDAOConsultarTodos;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Departamento;

public class ConsultaTodosDepartamentoAction implements ICommand{
        @Override
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DepartamentoDAOConsultarTodos ddao = new DepartamentoDAOConsultarTodos();
        try {
            List<Departamento> ldep = ddao.consultarTodos();
            request.setAttribute("ldep", ldep);
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
        return "resultadoconsultartodos.jsp";
    }
}