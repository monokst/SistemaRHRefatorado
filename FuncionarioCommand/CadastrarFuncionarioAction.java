package FuncionarioCommand;

import Command.ICommand;
import DepartamentoDAO.DepartamentoDAOCadastrar;
import EnderecoDAO.EnderecoDAOCadastrar;
import FuncionarioDAO.FuncionarioDAOCadastrar;
import java.sql.Date;
import model.Departamento;
import model.Endereco;
import model.Funcionario;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CadastrarFuncionarioAction implements ICommand {

    @Override
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String msg = "";

        try {
            String nome = request.getParameter("nome");
            String cpf = request.getParameter("cpf");
            String genero = request.getParameter("genero");
            String telefone = request.getParameter("telefone");
            String email = request.getParameter("email");
            Date dataNasc = Date.valueOf(request.getParameter("dataDeNascimento"));
            Date dataAdmissao = Date.valueOf(request.getParameter("dataDeAdmissao"));

            String rua = request.getParameter("rua");
            String bairro = request.getParameter("bairro");
            String cidade = request.getParameter("cidade");
            String estado = request.getParameter("estado");
            int cep = Integer.parseInt(request.getParameter("cep"));

            String nomeCargo = request.getParameter("nomeCargo");
            String funcao = request.getParameter("funcao");
            double salario = Double.parseDouble(request.getParameter("salarioBase"));

            Endereco endereco = new Endereco();
            endereco.setRua(rua);
            endereco.setBairro(bairro);
            endereco.setCidade(cidade);
            endereco.setEstado(estado);
            endereco.setCep(cep);

            Departamento departamento = new Departamento();
            departamento.setNome(nomeCargo);
            departamento.setFuncao(funcao);
            departamento.setSalarioBase(salario);

            EnderecoDAOCadastrar enderecoDao = new EnderecoDAOCadastrar();
            enderecoDao.cadastrar(endereco);

            DepartamentoDAOCadastrar departamentoDao = new DepartamentoDAOCadastrar();
            departamentoDao.cadastrar(departamento);

            Funcionario f = new Funcionario.FuncionarioBuilder(nome, cpf, dataAdmissao, departamento)
                    .dataDeNascimento(dataNasc)
                    .endereco(endereco)
                    .genero(genero)
                    .telefone(telefone)
                    .email(email)
                    .build();

            FuncionarioDAOCadastrar dao = new FuncionarioDAOCadastrar();
            dao.cadastrar(f);

            msg = "Funcionário cadastrado com sucesso!";

        } catch (Exception ex) {
            request.setAttribute(
                    "msg",
                    "Erro ao cadastrar funcionário: "
                    + ex.getMessage()
            );

            request.setAttribute("sucesso", false);
        }

        request.setAttribute("sucesso", true);
        return "cadastrar.jsp";
    }
}
