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
	@Qualifier("itemService")
	private ItemService itemService;
	
	///생성자
	
	///메소드
	//@Test
	public void testAddItem() throws Exception {
		
        System.out.println("\n===================================");
        Item item = Item.builder()
                .itemNo(1)
                .itemName("마우스 커서 파란색")
                .itemCategory("Y")
                .itemEffect("마우스 커서 색을 파란색으로 변경")
                .itemImg("test_img1.jpg")
                .itemPrice(1000)
                .itemRegdate(new Date(2024-04-02))
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
		Item item = itemService.getItem(1);
		System.out.println("pay GetItemList :: " + item);
		System.out.println("===================================\n");
	}

	//@Test
	public void testUpdateItem() throws Exception{

		System.out.println("\n===================================");
		
		Item item = Item.builder()
		        .itemName("커서 초란색")
		        .itemEffect("커서 색을 초록색으로 변경")
		        .itemImg("test_img2.jpg")
		        .itemPrice(2000)
		        .build();
		itemService.updateItem(item);
		item = itemService.getItem(item.getItemNo());
        System.out.println("item UpdateItem :: " + item);
        System.out.println("===================================\n");
	}
	
	//@Test
	public void testDeleteItem() throws Exception{
		
		System.out.println("\n===================================");
		itemService.deleteItem(1);
		System.out.println("item DeleteItem :: " );
		System.out.println("===================================\n");
		
	}
	 
	//@Test   <!--다시 확인-->
	public void testGetItemSearch() throws Exception {
	    System.out.println("\n===================================");
	    Search search = new Search();
	    Map<String, Object> resultMap = itemService.getItemSearch(search);
	    List<Item> list = (List<Item>) resultMap.get("list");
	    int totalCount = (Integer) resultMap.get("totalCount");
	    System.out.println("item search list :: " + list);
	    System.out.println("item search totalCount :: " + totalCount);
	    System.out.println("===================================\n");
	}

	

	
}
