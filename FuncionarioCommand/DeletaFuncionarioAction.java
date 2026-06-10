package FuncionarioCommand;
import Command.ICommand;
import FuncionarioDAO.FuncionarioDAODeletar;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class DeletaFuncionarioAction implements ICommand {
 
   @Override
public String processRequest(HttpServletRequest request,
        HttpServletResponse response) throws Exception {

    try {

        int idFun = Integer.parseInt(
                request.getParameter("id_fun"));

        FuncionarioDAODeletar dao =
                new FuncionarioDAODeletar();

        dao.deletar(idFun);

        response.sendRedirect(
            "FuncionarioControllerConsultarTodos?op=ConsultaTodosFuncionarioAction"
        );

        return null;

    } catch (Exception ex) {

        request.setAttribute(
            "msg",
            "Erro ao deletar funcionário: " + ex.getMessage()
        );

        return "deletar.jsp";
    }
}}