package life.wewu.web.controller.pay;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import life.wewu.web.domain.user.User;


@Controller
@RequestMapping("/pay/*")
public class PayController {
	@RequestMapping(value="kakaoPay/success")
	public String kakaoPaySucess(@RequestParam String pg_token, HttpSession session) throws Exception 
	{
		System.out.println("/pay/kakaoPay/success");
		
		ObjectMapper objectMapper = new ObjectMapper();
        
        String apiUrl = "https://open-api.kakaopay.com/online/v1/payment/approve";	//전달할 api 주소
        String auth = "SECRET_KEY DEV2A934096C80C2209BAF69D180963DA7A10B91";		//전달을 위한 key 값
        
        HttpHeaders headers = new HttpHeaders();	//데이터 전달을 위한 header 생성
        headers.set("Content-type","application/json");
        headers.set("Authorization", auth);
        
        Map<String, Object> requestBodyMap = new LinkedHashMap<>(); //데이터전달할 json data 생성
        
        requestBodyMap.put("cid", "TC0ONETIME"); //테스트 결제는 가맹점 코드로 'TC0ONETIME'를 사용
        requestBodyMap.put("tid", session.getAttribute("tid")); //일단 아무값이나 hard coding.
        requestBodyMap.put("partner_user_id", ((User)session.getAttribute("user")).getUserName()); //일단 아무값이나 hard coding.
        requestBodyMap.put("partner_order_id", "wewu");
        requestBodyMap.put("pg_token", pg_token); //결제 실패시 넘어갈 url
        System.out.println(requestBodyMap);
        String requestBody;
        try 
        {
            requestBody = objectMapper.writeValueAsString(requestBodyMap);
        }catch (JsonProcessingException e) 
        {
            e.printStackTrace();
            return "JSON 변환에 실패했습니다.";
        }
        
        HttpEntity<String> requestEntity  = new HttpEntity<>(requestBody, headers);	//전달할 객체 생성(헤더 + 바디)
        RestTemplate restTemplate = new RestTemplate();
        
        ResponseEntity<String> response = restTemplate.postForEntity(apiUrl, requestEntity, String.class);	//객체를 request하여 response 받을 객체
        
        if (response.getStatusCode().is2xxSuccessful()) 
        {
        	//전달된 body(jsonData return)
        	System.out.println();
        	 JSONObject json = new JSONObject(response.getBody());

             // 원하는 값 추출
             String tid = json.getString("tid");
             session.setAttribute("tid", tid);
        	return response.getBody();
        	
        } else 
        {
            return "/";
        }
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
