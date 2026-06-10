/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package EnderecoCommand;

import Command.ICommand;
import EnderecoDAO.EnderecoDAOCadastrar;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Endereco;

public class CadastrarEnderecoAction implements ICommand {

    @Override
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String msg = "";
        EnderecoDAOCadastrar edao = new EnderecoDAOCadastrar();
        try {
            String estado = request.getParameter("estado");
            String cidade = request.getParameter("cidade");
            String bairro = request.getParameter("bairro");
            String rua = request.getParameter("rua");
            int cep = Integer.parseInt(request.getParameter("cep"));

            Endereco e = new Endereco();
            e.setEstado(estado);
            e.setCidade(cidade);
            e.setBairro(bairro);
            e.setRua(rua);
            e.setCep(cep);

            edao.cadastrar(e);
            msg = "Endereço cadastrado com sucesso.";
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            msg = "Erro ao cadastrar endereço: " + ex.getMessage();
        }
        request.setAttribute("msg", msg);
        return "resultado.jsp";
    }
}
