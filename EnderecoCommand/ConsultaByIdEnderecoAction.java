/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package EnderecoCommand;

import Command.ICommand;
import EnderecoDAO.EnderecoDAOPorID;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Endereco;

/**
 *
 * @author PC
 */
public class ConsultaByIdEnderecoAction implements ICommand{

    @Override
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String msg = "";
        EnderecoDAOPorID edao = new EnderecoDAOPorID();
        Endereco e = new Endereco();
        try {
            int id = Integer.parseInt(request.getParameter("txtid"));
            e.setId_end(id);
            Endereco end = edao.buscarPorId(id);
            request.setAttribute("end", end);
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            msg = "Erro ao consultar";
            request.setAttribute("msg", msg);
        }
        return "resultadoconsultarbyid.jsp";
    }
}
