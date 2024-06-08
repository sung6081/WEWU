package life.wewu.web.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import life.wewu.web.service.user.SmsService;
import life.wewu.web.service.user.UserService;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/test")
@RequiredArgsConstructor
public class UserRestController {
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("smsService")
	private SmsService smsService;
	
	@GetMapping("/send-sms/{to}")
	public ResponseEntity<String>sendSms(@PathVariable("to")String to){
		
		ResponseEntity<String> response = userService.sendSms(to);
		
		return response;
	}
	

	
}
