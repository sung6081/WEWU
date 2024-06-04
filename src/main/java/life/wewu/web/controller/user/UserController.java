package life.wewu.web.controller.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import life.wewu.web.domain.user.User;
import life.wewu.web.service.user.UserService;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(value="login", method=RequestMethod.POST)
    public String login(@ModelAttribute("user") User user, HttpSession session) throws Exception {
        System.out.println("/user/login : POST");
        // 로그인 서비스 호출
        User dbUser = userService.login(user);
        
        if (dbUser != null) {
            session.setAttribute("user", dbUser);
            return "redirect:/index.jsp";
        }
        
        // 로그인 실패 시 처리 (예: 로그인 페이지로 리다이렉트)
        return "redirect:/login.jsp";
    }
    
	@RequestMapping( value="logout", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{
		
		System.out.println("/user/logout : POST");
		
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
}

