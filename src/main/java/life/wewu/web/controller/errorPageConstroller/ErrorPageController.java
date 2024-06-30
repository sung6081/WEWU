package life.wewu.web.controller.errorPageConstroller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorPageController implements ErrorController {
	
	@RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {
        Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
        String errorMessage = "Unknown error";

        if (statusCode != null) {
            switch (statusCode) {
                case 404:
                    errorMessage = "Page not found";
                    model.addAttribute("statusCode", statusCode);
                    model.addAttribute("errorMessage", errorMessage);
                    return "error/404";
                case 500:
                    errorMessage = "Internal server error";
                    model.addAttribute("statusCode", statusCode);
                    model.addAttribute("errorMessage", errorMessage);
                    return "error/500";
                default:
                    errorMessage = "Error occurred";
                    model.addAttribute("statusCode", statusCode);
                    model.addAttribute("errorMessage", errorMessage);
                    return "error/404";
            }
        }

        model.addAttribute("statusCode", statusCode);
        model.addAttribute("errorMessage", errorMessage);
        return "error/error";
    }

}
