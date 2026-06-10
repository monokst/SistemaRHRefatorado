package EnderecoCommand;

import Command.ICommand;
import EnderecoDAO.EnderecoDAODeletar;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Endereco;

public class DeletaEnderecoAction implements ICommand{
    
    @Override
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String msg = "";
        EnderecoDAODeletar edao = new EnderecoDAODeletar();
        Endereco e = new Endereco();
        try {
            int id = Integer.parseInt(request.getParameter("txtid"));
            e.setId_end(id);
            edao.deletar(id);
            msg = "Deletado com sucesso.";
            System.out.println("Deletado com sucesso.");
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            msg = "Erro ao deletar.";
        }
        request.setAttribute("msg", msg);
        return "resultado.jsp";
    }
}
