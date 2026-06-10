package FuncionarioCommand;

import Command.ICommand;
import FuncionarioDAO.FuncionarioDAOPorID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Funcionario;
 
public class ConsultaByIdFuncionarioAction implements ICommand {
 
    @Override
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String msg = "";
 
        try {
            int idFun = Integer.parseInt(request.getParameter("id_fun"));
            String view = request.getParameter("view");
 
            FuncionarioDAOPorID dao = new FuncionarioDAOPorID();
            Funcionario f = dao.buscarPorId(idFun);
 
            if (f != null) {
                request.setAttribute("funcionario", f);
                if ("edit".equals(view)) {
                    return "atualizarpage.jsp";
                }
                return "consultarporid.jsp";
            } else {
                msg = "Funcionário não encontrado.";
            }
 
        } catch (Exception ex) {
            msg = "Erro ao consultar funcionário: " + ex.getMessage();
        }
 
        request.setAttribute("msg", msg);
        return "consultarporid.jsp";
    }
}