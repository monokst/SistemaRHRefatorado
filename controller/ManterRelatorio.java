package controller;

import Command.ICommand;
import FuncionarioDAO.FuncionarioDAOConsultarTodos;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Funcionario;

@WebServlet(name = "RelatorioController", urlPatterns = {"/RelatorioController"})
public class ManterRelatorio extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");
        
        if ("DASHBOARD".equals(op)) {
            try {
                // Carregar lista de funcionários
                FuncionarioDAOConsultarTodos dao = new FuncionarioDAOConsultarTodos();
                List<Funcionario> lista = dao.consultarTodos();
                request.setAttribute("lista", lista);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("msg", "Erro ao carregar relatório: " + e.getMessage());
            }
            request.getRequestDispatcher("relatorios.jsp").forward(request, response);
        } else {
            response.sendRedirect("homepage.html");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
