package DepartamentoCommand;

import Command.ICommand;
import DepartamentoDAO.DepartamentoDAOCadastrar;
import java.sql.SQLException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Departamento;

public class CadastrarDepartamentoAction implements ICommand{
    @Override
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String msg = "";
        DepartamentoDAOCadastrar ddao = new DepartamentoDAOCadastrar();
        try {
            String nome = request.getParameter("nome");
            String funcao = request.getParameter("funcao");
            double salariobase = Double.parseDouble(request.getParameter("salarioBase"));

            Departamento d = new Departamento();
            d.setNome(nome);
            d.setFuncao(funcao);
            d.setSalarioBase(salariobase);

            ddao.cadastrar(d);
            msg = "Departamento cadastrado com sucesso.";
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            msg = "Erro ao cadastrar departamento: " + ex.getMessage();
        }
        request.setAttribute("msg", msg);
        return "resultado.jsp";
    }
}
