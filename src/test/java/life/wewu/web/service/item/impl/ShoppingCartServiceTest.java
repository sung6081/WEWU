/*
 24.06.06 ShoppingCartServiceTest.java 최윤정 작성
 */

package life.wewu.web.service.item.impl;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import life.wewu.web.domain.item.ShoppingCart;
import life.wewu.web.service.item.ShoppingCartService;

@SpringBootTest
public class ShoppingCartServiceTest{

	///필드
	@Autowired
	@Qualifier("shoppingCartServiceImpl")
	private ShoppingCartService shoppingCartService;

	///생성자

    /// 메소드
    //@Test
    public void testAddShoppingCart() throws Exception {
        System.out.println("\n===================================");
        ShoppingCart shoppingCart = ShoppingCart.builder()
                .nickname("nick1")
                .itemNo(1)
                .itemCnt(1)
                .build();
        shoppingCartService.addShoppingCart(shoppingCart);
        System.out.println("ShoppingCart AddShoppingCart :: " + shoppingCart);
        System.out.println("===================================\n");
    }

    @Test
    public void testGetShoppingCartList() throws Exception {
        System.out.println("\n===================================");
        List<ShoppingCart> shoppingCart = shoppingCartService.getShoppingCartList("nick1");
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
