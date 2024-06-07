/*
 24.06.06 ItemServiceTest.java 최윤정 작성
 */

package life.wewu.web.service.item.impl;

import java.sql.Date;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import life.wewu.web.common.Search;
import life.wewu.web.domain.item.ItemPurchase;
import life.wewu.web.service.item.ItemPurchaseService;

@SpringBootTest
public class ItemPurchaseServiceTest {

    ///필드
    @Autowired
    @Qualifier("itemPurchaseServiceImpl")
    private ItemPurchaseService itemPurchaseService;

    ///생성자

    ///메소드

    ///Method
    //@Test
    public void testAddPurchase() throws Exception {
        System.out.println("\n===================================");
        ItemPurchase itemPurchase = ItemPurchase.builder()
                .itemNo(1)
                .buyerNickname("user1")
                .itemCnt(2)
                .itemPurchaseDate(java.sql.Date.valueOf("2024-04-02"))
                .refundCompdate(null)
                .refundAskdate(null)
                .itemStock(10)
                .refundFlag("N")
                .afterRefundpoint(0)
                .beforeRefundpoint(0)
                .currentPoint(100)
                .refundPoint(0)
                //.itemName("마우스 커서 트래커")
               // .itemPrice(1000)
                .build();
        itemPurchaseService.addPurchase(itemPurchase);
        System.out.println("ItemPurchase Add :: " + itemPurchase);
        System.out.println("===================================\n");
    }

    //@Test
    public void testGetRefundPointList() throws Exception {
        System.out.println("\n===================================");
        ItemPurchase itemPurchase = itemPurchaseService.getRefundPointList(1);
        System.out.println("Refund Point List :: " + itemPurchase);
        System.out.println("===================================\n");
    }

    //@Test
    public void testGetRefundPoint() throws Exception {
        System.out.println("\n===================================");
        ItemPurchase itemPurchase = itemPurchaseService.getRefundPoint(1);
        System.out.println("Refund Point :: " + itemPurchase);
        System.out.println("===================================\n");
    }

    //@Test
    public void testGetItemSalesHistoryList() throws Exception {
        System.out.println("\n===================================");
        ItemPurchase itemPurchase = itemPurchaseService.getItemSalesHistoryList(1);
        System.out.println("Item Sales History List :: " + itemPurchase);
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
        List<ItemPurchase> list = itemPurchaseService.getItemPurchaseHistoryList(search);
        System.out.println("Item Purchase History List :: " + list);
        System.out.println("===================================\n");
    }

    //@Test
    public void testGetItemPurchaseHistory() throws Exception {  //다시 확인
        System.out.println("\n===================================");
        Search search = new Search();
        search.setSearchCondition("itemName");
        search.setSearchKeyword("item1");
        List<ItemPurchase> list = itemPurchaseService.getItemPurchaseHistoryList(search);
        System.out.println("Item Purchase History :: " + list);
        System.out.println("===================================\n");
    }

    //@Test //다시 확인
    public void testUpdatePurchase() throws Exception {
        System.out.println("\n===================================");
        ItemPurchase itemPurchase = ItemPurchase.builder()
                .itemPurchaseNo(1)
                .refundFlag("Y")
                .currentPoint(90)
                .refundAskdate(Date.valueOf("2024-04-02"))
                .refundCompdate(Date.valueOf("2024-04-02"))
                .build();

        itemPurchaseService.updatePurchase(itemPurchase);
        List<ItemPurchase> purchaseHistoryList = itemPurchaseService.getItemPurchaseHistoryList(new Search());
        ItemPurchase updatedItemPurchase = null;
        for (ItemPurchase purchase : purchaseHistoryList) {
            if (purchase.getItemPurchaseNo() == itemPurchase.getItemPurchaseNo()) {
                updatedItemPurchase = purchase;
                break;
            }
        }
        
        System.out.println("ItemPurchase Update :: " + updatedItemPurchase);
        System.out.println("===================================\n");
    }
}


