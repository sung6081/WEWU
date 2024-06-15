/*
 24.06.06 ItemServiceTest.java 최윤정 작성
 */

package life.wewu.web.service.item.impl;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.stereotype.Service;

import life.wewu.web.common.Search;
import life.wewu.web.domain.item.Item;
import life.wewu.web.service.item.ItemDao;
import life.wewu.web.service.item.ItemService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.sql.Date;
import java.util.ArrayList;

@SpringBootTest
public class ItemServiceTest{
	
	///필드
	@Autowired
	@Qualifier("itemServiceImpl")
	private ItemService itemService;
	
	///생성자
	
	///메소드
	//@Test
	public void testAddItem() throws Exception {
		
        System.out.println("\n===================================");
        Item item = Item.builder()
                .itemName("영양제")
                .itemCategory("Y")
                .itemEffect("10")
                .itemImg("test_img1.jpg")
                .itemPrice(1000)
                .build();
        itemService.addItem(item);
        System.out.println("Item AddItem :: " + item);
        System.out.println("===================================\n");
	    }
	
	//@Test
	public void testGetItem() throws Exception{

		System.out.println("\n===================================");
		Item item = itemService.getItem(1);
		System.out.println("pay GetItem :: " + item);
		System.out.println("===================================\n");
	}

	//@Test
	public void testGetItemList() throws Exception{
		
		System.out.println("\n===================================");
		List<Item> item = itemService.getItemList();
		System.out.println("pay GetItemList :: " + item);
		System.out.println("===================================\n");
	}

	//@Test 
	public void testUpdateItem() throws Exception{ 

		System.out.println("\n===================================");

		Item item = itemService.getItem(3);
		System.out.println(item);
		item.setItemName("커서 초록색");
		item.setItemEffect("커서 색을 초록색으로 변경");
		item.setItemImg("test_img2.jpg");
		item.setItemPrice(2000);
		System.out.println(item);
		itemService.updateItem(item);
		item = itemService.getItem(item.getItemNo()); //수정완료 된 뒤, 한 번 더 확인해서 볼 수 있도록 getItem이 다시 들어간 것. 
        System.out.println("item UpdateItem :: " + item);
        System.out.println("===================================\n");
	}
	
	//@Test //이거 다시 해야 함. 수정 이후로 얘 때문에 계속 오류 남. 
	public void testDeleteItem() throws Exception{
		
		System.out.println("\n===================================");
		itemService.deleteItem(1);
		System.out.println("item DeleteItem :: " );
		System.out.println("===================================\n");
		
	}
	 
	//@Test   
	public void testGetItemSearch() throws Exception {
		
	    System.out.println("\n===================================");
	    Search search = new Search();
	    search.setSearchCondition("0");
	    search.setSearchKeyword("Item");
	    List<Item> list = itemService.getItemSearch(search);
	    System.out.println("item search list :: " + list);
	    System.out.println("===================================\n");
	}

	

	
}
