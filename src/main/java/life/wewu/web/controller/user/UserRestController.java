package life.wewu.web.controller.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import life.wewu.web.domain.user.User;
import life.wewu.web.service.user.SmsService;
import life.wewu.web.service.user.UserDao;
import life.wewu.web.service.user.UserService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserRestController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    @Autowired
    @Qualifier("smsService")
    private SmsService smsService;

    // 인증번호 발송 메소드
    @PostMapping("/send-verification-code")
    public ResponseEntity<String> sendVerificationCode(@RequestParam String phoneNum) {
        userService.sendVerificationCode(phoneNum);
        return ResponseEntity.ok("인증번호가 전송되었습니다.");
    }

    @PostMapping("/verify-code-userId")
    public String verifyCodeUserId(@RequestParam String phoneNum,
                             @RequestParam String code,
                             @RequestParam String userName,
                             Model model) throws Exception {
        System.out.println("verifyCodeUserId 호출됨");
        System.out.println("phoneNum:" + phoneNum);
        System.out.println("code:" + code);
        System.out.println("userName:" + userName);

        boolean isVerified = userService.verifyCode(phoneNum, code);
        System.out.println("isVerified:" + isVerified);
        if (isVerified) {
            // 인증 성공: 아이디 보여주는 페이지로 리디렉션
            User user = userService.findUserId(phoneNum, userName);
            if (user != null) {
                model.addAttribute("userId", user.getUserId());
                return "user/findUserId";
            } else {
                model.addAttribute("phoneNum", phoneNum);
                model.addAttribute("userName", userName);
                model.addAttribute("error", "사용자를 찾을 수 없습니다.");
                return "user/verification";
            }
        } else {
            // 인증 실패
            model.addAttribute("phoneNum", phoneNum);
            model.addAttribute("userName", userName);
            model.addAttribute("error", "인증 실패");
            return "user/verification";
        }
    }
    
    @PostMapping("/verify-code-userPwd")
    public String verifyCodeUserPwd(@RequestParam String phoneNum,
                             @RequestParam String code,
                             @RequestParam String userId,
                             Model model) throws Exception {
        System.out.println("verifyCodePwd 호출됨");
        System.out.println("phoneNum:" + phoneNum);
        System.out.println("code:" + code);
        System.out.println("userId:" + userId);

        boolean isVerified = userService.verifyCode(phoneNum, code);
        System.out.println("isVerified:" + isVerified);
        if (isVerified) {
            // 인증 성공: 비밀번호 변경 페이지로 리디렉션
            User user = userService.findUserPwd(phoneNum, userId);
            if (user != null) {
                model.addAttribute("userId", user.getUserId());
                return "user/updatePwd";
            } else {
                model.addAttribute("phoneNum", phoneNum);
                model.addAttribute("userId", userId);
                model.addAttribute("error", "사용자를 찾을 수 없습니다.");
                return "user/findPwd";
            }
        } else {
            // 인증 실패
            model.addAttribute("phoneNum", phoneNum);
            model.addAttribute("userId", userId);
            model.addAttribute("error", "인증 실패");
            return "user/findPwd";
        }
    }
    
    
    // 테스트용 인증번호 발송 메소드
    @PostMapping("/send-test-verification-code")
    public ResponseEntity<String> sendTestVerificationCode(@RequestParam String phoneNum) {
        userService.sendTestVerificationCode(phoneNum);
        return ResponseEntity.ok("테스트용 인증번호가 전송되었습니다.");
    }
    
    //아이디 닉네임 중복체크 검사
	    @GetMapping("/checkId")
	    public ResponseEntity<Map<String, Boolean>> checkId(@RequestParam String userId) {
	        if (!userId.matches("^[a-zA-Z가-힣0-9]{2,10}$")) {
	            Map<String, Boolean> response = new HashMap<>();
	            response.put("available", false);
	            return ResponseEntity.ok(response);
	        }
	        boolean available;
	        try {
	            available = !userService.checkUserId(userId);
	        } catch (Exception e) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	        }
	        Map<String, Boolean> response = new HashMap<>();
	        response.put("available", available);
	        return ResponseEntity.ok(response);
	    }
	
	    @GetMapping("/checkNickname")
	    public ResponseEntity<Map<String, Boolean>> checkNickname(@RequestParam String nickname) {
	        if (!nickname.matches("^[a-zA-Z가-힣0-9]{2,10}$")) {
	            Map<String, Boolean> response = new HashMap<>();
	            response.put("available", false);
	            return ResponseEntity.ok(response);
	        }
	        boolean available;
	        try {
	            available = !userService.checkNickName(nickname);
	        } catch (Exception e) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	        }
	        Map<String, Boolean> response = new HashMap<>();
	        response.put("available", available);
	        return ResponseEntity.ok(response);
	    }
    
       //비밀번호 유효성검사, 같음 검사
        @PostMapping("/pwdCheck")
        public ResponseEntity<String> addUser(@RequestBody User user) {
            if (!user.getUserPwd().matches("^(?=.*[a-zA-Z])(?=.*[!@#$%^&*]).{8,16}$")) {
                return ResponseEntity.badRequest().body("비밀번호는 8자 이상 16자 이하, 영문과 특수기호를 포함해야 합니다.");
            }
            if (!user.getUserPwd().equals(user.getUserPwd())) {
                return ResponseEntity.badRequest().body("비밀번호가 일치하지 않습니다.");
            }
            try {
                userService.addUser(user);
            } catch (Exception e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("회원가입 중 오류가 발생했습니다.");
            }
            return ResponseEntity.ok("회원가입 성공");
        }
        
        @GetMapping("/validatePassword")
        public ResponseEntity<Map<String, Boolean>> validatePassword(@RequestParam String password) {
            boolean isValid = password.matches("^(?=.*[a-zA-Z])(?=.*[!@#$%^&*]).{8,16}$");
            Map<String, Boolean> response = new HashMap<>();
            response.put("isValid", isValid);
            return ResponseEntity.ok(response);
        }
        
        @PostMapping("/verify-code-user")
        public ResponseEntity<Map<String, Object>> verifyCodeUser(@RequestParam String phoneNum, 
                                                                  @RequestParam String code) {
            Map<String, Object> response = new HashMap<>();
            try {
                boolean isVerified = userService.verifyCode(phoneNum, code);
                response.put("valid", isVerified);
                if (isVerified) {
                    response.put("message", "인증 성공");
                    return ResponseEntity.ok(response);
                } else {
                    response.put("message", "인증 실패");
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
                }
            } catch (Exception e) {
                response.put("message", "인증 과정에서 오류가 발생했습니다.");
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
            }
        }
        
//        @PostMapping("/verify-code")
//        public ResponseEntity<Map<String, Boolean>> verifyCode(@RequestParam String phoneNum, @RequestParam String code) {
//            boolean isValid = userService.verifyCode(phoneNum, code);
//            
//            System.out.println("verify-code");
//            Map<String, Boolean> response = new HashMap<>();
//            response.put("valid", isValid);
//            return ResponseEntity.ok(response);
//        }
}
