package Controller;


import Command.ICommand;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ManterSair implements ICommand {

    @Override
    public String processRequest(HttpServletRequest request,
            HttpServletResponse response) {

        request.getSession().invalidate();

        return "index.jsp";
    }
}
