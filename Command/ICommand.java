
package Command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public interface ICommand {
    
    public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception;
    
}