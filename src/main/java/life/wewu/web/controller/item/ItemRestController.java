/*
 * 작성자 : 최윤정
 * 작성일 : 2024-06-17
 */
package life.wewu.web.controller.item;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JacksonInject;
import com.fasterxml.jackson.annotation.JsonProperty;

import life.wewu.web.common.Search;
import life.wewu.web.domain.item.ShoppingCart;
import life.wewu.web.service.item.ItemService;
import life.wewu.web.service.item.ShoppingCartService;

@RestController
@RequestMapping("/app/item/*")
public class ItemRestController {

	///필드
	@Autowired
	@Qualifier("itemServiceImpl")
	private ItemService itemService;
	
	@Autowired
	@Qualifier("shoppingCartServiceImpl")
	private ShoppingCartService shoppingCartService;
	
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
		int itemNo = (int)rslt.get("itemNo");
		
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
	
	//오리날다............덕슨날다.....
}
