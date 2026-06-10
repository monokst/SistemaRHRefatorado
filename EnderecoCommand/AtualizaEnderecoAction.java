
package EnderecoCommand;

import Command.ICommand;
import EnderecoDAO.EnderecoDAOAtualizar;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Endereco;

public class AtualizaEnderecoAction implements ICommand {

    @Override
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String msg = "";
        EnderecoDAOAtualizar edao = new EnderecoDAOAtualizar();
        try {
            int idEnd = Integer.parseInt(request.getParameter("id_end"));
            String estado = request.getParameter("estado");
            String cidade = request.getParameter("cidade");
            String bairro = request.getParameter("bairro");
            String rua = request.getParameter("rua");
            int cep = Integer.parseInt(request.getParameter("cep"));

            Endereco e = new Endereco(idEnd, rua, bairro, cidade, estado, cep);
            edao.atualizar(e);
            msg = "Endereço atualizado com sucesso.";
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            msg = "Erro ao atualizar endereço: " + ex.getMessage();
        }
        request.setAttribute("msg", msg);
        return "resultado.jsp";
    }
}
