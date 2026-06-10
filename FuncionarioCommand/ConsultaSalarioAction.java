package FuncionarioCommand;

import Command.ICommand;
import FuncionarioDAO.FuncionarioDAOPorID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Funcionario;

public class ConsultaSalarioAction implements ICommand {

    @Override
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String msg = "";

        try {
            int idFun = Integer.parseInt(request.getParameter("id_fun"));

            FuncionarioDAOPorID dao = new FuncionarioDAOPorID();
            Funcionario f = dao.buscarPorId(idFun);

            if (f != null) {
                request.setAttribute("funcionario", f);
                return "salario.jsp";
            } else {
                msg = "Funcionário não encontrado.";
            }

        } catch (Exception ex) {
            msg = "Erro ao consultar salário: " + ex.getMessage();
        }

        request.setAttribute("msg", msg);
        return "resultado.jsp";
    }
}
