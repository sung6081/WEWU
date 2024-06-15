/*
 24.06.06 ItemServiceTest.java 최윤정 작성
 */

package life.wewu.web.service.item.impl;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import life.wewu.web.common.Search;
import life.wewu.web.domain.item.Item;
import life.wewu.web.domain.item.ItemPurchase;
import life.wewu.web.domain.user.User;
import life.wewu.web.service.item.ItemPurchaseService;
import life.wewu.web.service.item.ItemService;

@SpringBootTest
public class ItemPurchaseServiceTest {

    ///필드
    @Autowired
    @Qualifier("itemPurchaseServiceImpl") //ItemPurchaseServiceImpl의 @Service("itemPurchaseServiceImpl")과 같아야 함.
    private ItemPurchaseService itemPurchaseService;

  ///필드
    @Autowired
    @Qualifier("itemServiceImpl") //ItemPurchaseServiceImpl의 @Service("itemPurchaseServiceImpl")과 같아야 함.
    private ItemService itemService;

    ///생성자

    ///메소드

    ///Method
    //@Test
    public void testAddPurchase() throws Exception {
        System.out.println("\n===================================");
        ItemPurchase itemPurchase = ItemPurchase.builder()
        		.itemNo(7)
                .buyerNickname("nick1")
                .itemCnt(10)
                .itemStock(10)
                .refundFlag("N")
                .afterRefundpoint(0)
                .beforeRefundpoint(0)
                .currentPoint(100)
                .refundPoint(0)
                //.itemName("마우스 커서 트래커")
               // .itemPrice(1000)
                .build();
        System.out.println(itemPurchase);
        itemPurchaseService.addPurchase(itemPurchase);
        System.out.println("ItemPurchase Add :: " + itemPurchase);
        System.out.println("===================================\n");
    }

    //@Test
    public void testGetRefundPointList() throws Exception {
        System.out.println("\n===================================");
        User user = User.builder()
        			.nickname("nick1")
        			.build();
        List<ItemPurchase> list = itemPurchaseService.getRefundPointList(user.getNickname());
        System.out.println("Refund Point List :: " + list);
        System.out.println("===================================\n");
    }

    //@Test
    public void testGetRefundPoint() throws Exception {
        System.out.println("\n===================================");
        ItemPurchase itemPurchase = itemPurchaseService.getRefundPoint(7);
        System.out.println("Refund Point :: " + itemPurchase);// itemPurchase 호출했을 때, buyerNickname=null이라고 뜨는 이유:innerjoin table 만들었지만, 이후 setter 호출 안 함. 따라서 buyer_nickname은 null임. domain 값도 호출되려면 setter 불러야 함. 그리고 내가 설정한 칼럼만 보여주므로 그럼.
        System.out.println("===================================\n");
    }

    //@Test
    public void testGetItemSalesHistoryList() throws Exception {
        System.out.println("\n===================================");
        List<ItemPurchase> list = itemPurchaseService.getItemSalesHistoryList();
        System.out.println("Item Sales History List :: " + list);
        System.out.println("===================================\n");
    }


    //@Test
    public void testGetItemSalesHistory() throws Exception {
        System.out.println("\n===================================");
        ItemPurchase itemPurchase = itemPurchaseService.getItemSalesHistory(1);
        System.out.println("Item Sales History :: " + itemPurchase);
        System.out.println("===================================\n");
    }

    //@Test
    public void testGetItemPurchaseHistoryList() throws Exception {
        System.out.println("\n===================================");

        Search search = new Search();
        search.setSearchCondition("itemName");
        search.setSearchKeyword("item1");
        String nickName="nick1";
        Map<String,Object> map = new HashMap<>();
        map.put("search", search);
        map.put("buyerNickname", nickName);

        List<ItemPurchase> list = itemPurchaseService.getItemPurchaseHistoryList(map);

        System.out.println("Item Purchase History List :: " + list);
        System.out.println("===================================\n");
    }

    //@Test
    public void testGetItemPurchaseHistory() throws Exception {  //다시 확인
        System.out.println("\n===================================");
        ItemPurchase item = itemPurchaseService.getItemPurchaseHistory(5);
        System.out.println("Item Purchase History :: " + item);
        System.out.println("===================================\n");
    }

    //@Test 
    public void testUpdatePurchase() throws Exception {
        System.out.println("\n===================================");

        ItemPurchase itemPurchase = itemPurchaseService.getItemPurchaseHistory(9);
        Item item = itemService.getItem(itemPurchase.getItemNo());
        if(item.getItemCategory().equals("Y") && itemPurchase.getRefundFlag().equals("N"))
        {
        	//구매정보 리스트 중 선택한 구매정보의 상품이 식물이고 환불을 신청하지 않았다면
        	if(itemPurchase.getItemStock() == itemPurchase.getItemCnt())
        	{
        		//구매한 식물의 구매갯수와 재고량이 같다면
        		System.out.println("환불가능");
        		ItemPurchase afterItemPurchase = ItemPurchase.builder()
	        				.itemPurchaseNo(itemPurchase.getItemPurchaseNo())
	                        .refundFlag("Y")
	                        .refundPoint(item.getItemPrice())
	                        .beforeRefundpoint(90)
	                        .afterRefundpoint(90+item.getItemPrice())
	                        .currentPoint(90 + item.getItemPrice())
	                        .refundAskdate(Date.valueOf("2024-04-02"))
	                        .refundCompdate(Date.valueOf("2024-04-02"))
	                        .build();
        		itemPurchaseService.updatePurchase(afterItemPurchase);

        	}else
        	{
        		//구매한 식물의 구매갯수와 재고량이 다르다면
        		System.out.println("사용한 아이템은 환불 불가능");
        	}
        }else
        {
        	//구매정보 리스트 중 선택한 구매정보의 상품이 장식이라면
        	System.out.println("장식 아이템 및 환불된 아이템은 환불 불가능");
        }

        System.out.println("===================================\n");
    }
}


