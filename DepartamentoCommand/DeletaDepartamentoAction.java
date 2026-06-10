package DepartamentoCommand;

import Command.ICommand;
import DepartamentoDAO.DepartamentoDAODeletar;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Departamento;


public class DeletaDepartamentoAction implements ICommand {

    @Override
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String msg = "";
        DepartamentoDAODeletar ddao = new DepartamentoDAODeletar();
        Departamento d = new Departamento();
        try {
            int id = Integer.parseInt(request.getParameter("txtid"));
            d.setId_departamento(id);
            ddao.deletar(d);
            msg = "Deletado com sucesso.";
            System.out.println("Deletado com sucesso.");
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            msg = "Erro ao deletar.";
        }
        request.setAttribute("msg", msg);
        return "resultado.jsp";
    }
}
