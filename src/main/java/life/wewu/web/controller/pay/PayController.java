package life.wewu.web.controller.pay;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import life.wewu.web.domain.pay.Pay;
import life.wewu.web.domain.user.User;
import life.wewu.web.service.pay.PayService;
import life.wewu.web.service.user.UserService;


@Controller
@RequestMapping("/pay/*")
public class PayController {
   ///필드
    @Autowired //처음 spring boot 올라갈 때 autowired 되어있는 애들 올라가면서 생성
    @Qualifier("payService") //자동 생성 시 사용. 구현체인 itemPurchaseServiceImpl을 사용. 
    private PayService payService; //itemService에 itemPurchaseServiceImpl가 담김. 
    
    @Autowired //처음 spring boot 올라갈 때 autowired 되어있는 애들 올라가면서 생성
    @Qualifier("userServiceImpl") //자동 생성 시 사용. 구현체인 itemPurchaseServiceImpl을 사용. 
    private UserService userService; //itemService에 itemPurchaseServiceImpl가 담김. 
    
   @RequestMapping(value="kakaoPay/success")
   public ModelAndView kakaoPaySucess(@ModelAttribute Pay pay, @SessionAttribute("user")User user, HttpSession session) throws Exception 
   {
      System.out.println("/pay/kakaoPay/success");
      
      //구매 후 유저 예상 포인트
        int afterPoint = (pay.getCurrentPoint() + pay.getPayAmount());
        pay.setAfterChargePoint(afterPoint);
        
        //충전내역 저장 
        payService.addPointCharge(pay);
        
        //유저의 현재포인트를 구매후 포인트로 set
        user.setCurrentPoint(afterPoint);
        userService.updateUserPoint(user.getUserId(), afterPoint);
        
        //세션에 저장된 유저 정보를 업데이트
        session.setAttribute("user", user);
        
        //완료 페이지로 이동
        ModelAndView model = new ModelAndView("forward:/pay/getPointChargeRslt.jsp");
        model.addObject("pay", pay);
       return model;
      
   }
   
   @RequestMapping(value="kakaoPay/cancel")
   public String kakaoPayCancel() throws Exception 
   {
      return "/";
   }
   
   @RequestMapping(value="kakaoPay/fail")
   public String kakaoPayFail() throws Exception 
   {
      return "/";
   }
}
