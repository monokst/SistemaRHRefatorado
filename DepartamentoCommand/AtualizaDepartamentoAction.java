package DepartamentoCommand;

import Command.ICommand;
import DepartamentoDAO.DepartamentoDAOAtualizar;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Departamento;

/**
 *
 * @author PC
 */
public class AtualizaDepartamentoAction implements ICommand {
        @Override
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String msg = "";
        DepartamentoDAOAtualizar ddao = new DepartamentoDAOAtualizar();
        Departamento d = new Departamento();
        try {
            int id = Integer.parseInt(request.getParameter("id_departamento"));
            String nome = request.getParameter("nome");
            String funcao = request.getParameter("funcao");
            double salariobase = Double.parseDouble(request.getParameter("salarioBase"));
            d.setId_departamento(id);
            d.setNome(nome);
            d.setFuncao(funcao);
            d.setSalarioBase(salariobase);
            ddao.atualizar(d);
            msg = "Atualizado com sucesso.";
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            msg = "Erro ao Atualizar.";
        }
        request.setAttribute("msg", msg);
        return "resultado.jsp";
    }
}
