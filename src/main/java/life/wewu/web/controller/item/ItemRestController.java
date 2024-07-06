/*
 * 작성자 : 최윤정
 * 작성일 : 2024-06-17
 */
package life.wewu.web.controller.item;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.aspectj.apache.bcel.classfile.Module.Require;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JacksonInject;
import com.fasterxml.jackson.annotation.JsonProperty;

import life.wewu.web.common.Search;
import life.wewu.web.domain.item.Item;
import life.wewu.web.domain.item.ItemPurchase;
import life.wewu.web.domain.item.ShoppingCart;
import life.wewu.web.domain.user.User;
import life.wewu.web.service.item.ItemPurchaseService;
import life.wewu.web.service.item.ItemService;
import life.wewu.web.service.item.ShoppingCartService;
import life.wewu.web.service.user.UserService;

@RestController
@RequestMapping("/app/item/*")
public class ItemRestController {

	///필드
	@Autowired
	@Qualifier("itemServiceImpl")
	private ItemService itemService;
	
	@Autowired
	@Qualifier("itemPurchaseServiceImpl")
	private ItemPurchaseService itemPurchaseService;
	
	@Autowired
	@Qualifier("shoppingCartServiceImpl")
	private ShoppingCartService shoppingCartService;
	
	@Autowired //처음 spring boot 올라갈 때 autowired 되어있는 애들 올라가면서 생성
    @Qualifier("userServiceImpl") //자동 생성 시 사용. 구현체인 itemPurchaseServiceImpl을 사용. 
    private UserService userService; //itemService에 itemPurchaseServiceImpl가 담김.
	
	public ItemRestController()
	{
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="deleteItem",method = RequestMethod.POST)
	public String deleteItem(@RequestBody Map<String, Object> rslt) throws Exception 
	{
		System.out.println(":: /app/item/deleteItem ::");
		// Business logic 수행
		String flag = "";
		int itemNo = Integer.parseInt(rslt.get("itemNo").toString());
		
		try
  		{
	  		//삭제시도
			itemService.deleteItem(itemNo);
			flag = "Y";
		}catch(Exception e)
		{
			//삭제 시도 후 오류가 난다면
			flag = "N";
		}
		
		// JSON 형식의 응답 반환
        return "{\"flag\": \"" + flag + "\"}";
	}
	
	@RequestMapping(value="updatePurchase")
	public String updatePurchase(@RequestBody Map<String, Object> rslt, HttpSession session , @SessionAttribute("user")User user) throws Exception 
	{
		System.out.println(":: /app/item/updatePurchase ::");
		// Business logic 수행
		int itemPurchaseNo = Integer.parseInt((String)rslt.get("itemPurchaseNo"));
		
		ItemPurchase itemPurchase = itemPurchaseService.getItemPurchaseHistory(itemPurchaseNo);
		System.out.println(itemPurchase);
        Item item = itemService.getItem(itemPurchase.getItemNo());
        String flag = "";
        if(item.getItemCategory().equals("Y"))
        {
        	//구매정보 리스트 중 선택한 구매정보의 상품이 식물이라면
        	
        	if(itemPurchase.getRefundFlag().equals("N"))
        	{
        		//환불하지 않은 상품이라면
        		if(itemPurchase.getItemStock() == itemPurchase.getItemCnt())
            	{
            		//구매한 식물의 구매갯수와 재고량이 같다면
            		System.out.println("환불가능");
            		ItemPurchase afterItemPurchase = ItemPurchase.builder()
    	        				.itemPurchaseNo(itemPurchase.getItemPurchaseNo())
    	                        .refundFlag("Y")
    	                        .refundPoint(item.getItemPrice())
    	                        .beforeRefundpoint(user.getCurrentPoint())
    	                        .afterRefundpoint(user.getCurrentPoint()+item.getItemPrice())
    	                        .currentPoint(user.getCurrentPoint() + item.getItemPrice())
    	                        .refundAskdate(Date.valueOf("2024-04-02"))
    	                        .refundCompdate(Date.valueOf("2024-04-02"))
    	                        .build();
            		itemPurchaseService.updatePurchase(afterItemPurchase);
            		user.setCurrentPoint(user.getCurrentPoint()+item.getItemPrice());
            		session.setAttribute("user", user);
            		userService.updateUserPoint(user.getUserId(),user.getCurrentPoint()+item.getItemPrice());
            		
            		flag="yes";
            	}else
            	{
            		//구매한 식물의 구매갯수와 재고량이 다르다면
            		System.out.println("사용한 아이템은 환불 불가능");
            		flag="use";
            	}
        	}else
        	{
        		//환불한 상품이라면
        		flag="refund";
        	}
        }else
        {
        	//구매정보 리스트 중 선택한 구매정보의 상품이 장식이라면
        	flag="deco";
        }
		
		// JSON 형식의 응답 반환
        return "{\"flag\": \"" + flag + "\"}";
	}
	
	@RequestMapping( value="addShoppingCart",method = RequestMethod.POST ) 
	public String addShoppingCart(@RequestBody ShoppingCart shoppingCart ) throws Exception{
	
		System.out.println("/app/item/addShoppingCart ::POST");
		System.out.println(shoppingCart);
		
		String flag = "";
		try
  		{
	  		//삭제시도
			shoppingCartService.addShoppingCart(shoppingCart);
			flag = "Y";
		}catch(Exception e)
		{
			//삭제 시도 후 오류가 난다면
			flag = "N";
		}
		
		// JSON 형식의 응답 반환
        return "{\"flag\": \"" + flag + "\"}";
	}
	
}
