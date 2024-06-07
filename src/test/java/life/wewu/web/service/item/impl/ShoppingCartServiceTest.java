/*
 24.06.06 ShoppingCartServiceTest.java 최윤정 작성
 */

package life.wewu.web.service.item.impl;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.stereotype.Service;

import life.wewu.web.common.Search;
import life.wewu.web.domain.item.ShoppingCart;
import life.wewu.web.service.item.ItemService;
import life.wewu.web.service.item.ShoppingCartDao;
import life.wewu.web.service.item.ShoppingCartService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.sql.Date;
import java.util.ArrayList;

@SpringBootTest
public class ShoppingCartServiceTest{
	
	///필드
	@Autowired
	@Qualifier("shoppingCartService")
	private ShoppingCartService shoppingCartService;
	
	///생성자

    /// 메소드
    //@Test
    public void testAddShoppingCart() throws Exception {
        System.out.println("\n===================================");
        ShoppingCart shoppingCart = ShoppingCart.builder()
                .shoppingCartNo(1)
                .nickname("testuser")
                .itemNo(1)
                .itemCnt(2)
                //.itemName("마우스 커서 파란색")
                //.itemImg("test_img1.jpg")
                //.itemPrice(1000)
                .build();
        shoppingCartService.addShoppingCart(shoppingCart);
        System.out.println("ShoppingCart AddShoppingCart :: " + shoppingCart);
        System.out.println("===================================\n");
    }

    //@Test
    public void testGetShoppingCartList() throws Exception {
        System.out.println("\n===================================");
        ShoppingCart shoppingCart = shoppingCartService.getShoppingCartList(1);
        System.out.println("ShoppingCart GetShoppingCart :: " + shoppingCart);
        System.out.println("===================================\n");
    }

    //@Test
    public void testDeleteShoppingCartList() throws Exception {
        System.out.println("\n===================================");
        shoppingCartService.deleteShoppingCartList(1);
        System.out.println("ShoppingCart DeleteShoppingCart :: ");
        System.out.println("===================================\n");
    }

}
	