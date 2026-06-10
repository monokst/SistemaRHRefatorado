package FuncionarioCommand;

import Command.ICommand;
import FuncionarioDAO.FuncionarioDAOAtualizar;
import java.sql.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Departamento;
import model.Endereco;
import model.Funcionario;
 
public class AtualizaFuncionarioAction implements ICommand {
 
    @Override
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String msg = "";
 
        try {
            int idFun = Integer.parseInt(request.getParameter("id_fun"));
            String nome = request.getParameter("nome");
            String cpf = request.getParameter("cpf");
            String genero = request.getParameter("genero");
            String telefone = request.getParameter("telefone");
            String email = request.getParameter("email");
            Date dataNasc = Date.valueOf(request.getParameter("dataDeNascimento"));
            Date dataAdmissao = Date.valueOf(request.getParameter("dataDeAdmissao"));
 
            int idEnd = Integer.parseInt(request.getParameter("id_end"));
            String rua = request.getParameter("rua");
            String bairro = request.getParameter("bairro");
            String cidade = request.getParameter("cidade");
            String estado = request.getParameter("estado");
            int cep = Integer.parseInt(request.getParameter("cep"));
 
            int idDep = Integer.parseInt(request.getParameter("id_departamento"));
            String nomeCargo = request.getParameter("nomeCargo");
            String funcao = request.getParameter("funcao");
            double salario = Double.parseDouble(request.getParameter("salarioBase"));
 
            Endereco endereco = new Endereco(idEnd, rua, bairro, cidade, estado, cep);
            Departamento departamento = new Departamento(idDep, nomeCargo, funcao, salario);
 
            Funcionario f = new Funcionario.FuncionarioBuilder(nome, cpf, dataAdmissao, departamento)
                    .id_fun(idFun)
                    .dataDeNascimento(dataNasc)
                    .endereco(endereco)
                    .genero(genero)
                    .telefone(telefone)
                    .email(email)
                    .build();
 
                FuncionarioDAOAtualizar dao = new FuncionarioDAOAtualizar();
            dao.atualizar(f);

            msg = "Funcionário atualizado com sucesso!";
            request.setAttribute("funcionario", f);
            request.setAttribute("sucesso", true);

        } catch (Exception ex) {
            msg = "Erro ao atualizar funcionário: " + ex.getMessage();
            request.setAttribute("sucesso", false);
        }

        request.setAttribute("msg", msg);
        return "atualizarpage.jsp";  
    }
}

