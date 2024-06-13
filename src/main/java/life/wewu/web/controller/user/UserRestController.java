package life.wewu.web.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import life.wewu.web.domain.user.User;
import life.wewu.web.service.user.SmsService;
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
            // 인증 성공: 아이디 보여주는 페이지로 리디렉션
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
    
}
