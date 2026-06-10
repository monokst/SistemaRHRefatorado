package DepartamentoCommand;

import Command.ICommand;
import DepartamentoDAO.DepartamentoDAOPorID;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Departamento;

/**
 *
 * @author PC
 */
public class ConsultaByIdDepartamentoAction implements ICommand{
        @Override
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String msg = "";
        DepartamentoDAOPorID ddao = new DepartamentoDAOPorID();
        try {
            int id = Integer.parseInt(request.getParameter("id_departamento"));
            Departamento dep = ddao.buscarPorId(id);
            request.setAttribute("dep", dep);
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            msg = "Erro ao consultar departamento: " + ex.getMessage();
            request.setAttribute("msg", msg);
        }
        return "resultadoconsultarbyid.jsp";
    }
}
