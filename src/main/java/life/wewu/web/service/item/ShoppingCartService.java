package life.wewu.web.service.item;

import life.wewu.web.domain.item.ShoppingCart;

public interface ShoppingCartService {
	
    public void addShoppingCart(ShoppingCart shoppingCart) throws Exception;

    public ShoppingCart getShoppingCartList(int itemNo) throws Exception;

    public void deleteShoppingCartList(int shoppingCartNo) throws Exception;
    
}


