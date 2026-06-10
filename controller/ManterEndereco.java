package controller;

import Command.ICommand;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "EnderecoController", urlPatterns = {
    "/EnderecoControllerCadastrar",
    "/EnderecoControllerConsultarTodos",
    "/EnderecoControllerPorID",
    "/EnderecoControllerAtualizar",
    "/EnderecoControllerDeletar"
})
public class ManterEndereco extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");
        String actionClass = "EnderecoCommand." + op;

        try {
            Class<?> clazz = Class.forName(actionClass);
            ICommand command = (ICommand) clazz.getDeclaredConstructor().newInstance();
            String pagina = command.processRequest(request, response);
            request.getRequestDispatcher(pagina).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro: " + e.getMessage());
            request.getRequestDispatcher("resultado.jsp").forward(request, response);
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
