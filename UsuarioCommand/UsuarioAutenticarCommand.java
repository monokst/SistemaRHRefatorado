package UsuarioCommand;

import Command.ICommand;
import UsuarioDAO.UsuarioDAOAutenticar;
import model.Usuario;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UsuarioAutenticarCommand implements ICommand {

    @Override
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        UsuarioDAOAutenticar dao = new UsuarioDAOAutenticar();
        Usuario usuario = dao.autenticar(email, senha);

        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogado", usuario);
            return "homepage.html";
        } else {
            request.setAttribute("msg", "E-mail ou senha inválidos!");
            return "index.jsp";
        }
    }
}