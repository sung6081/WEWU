package life.wewu.web.service.item;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.domain.item.Item;
import life.wewu.web.domain.item.ShoppingCart;


@Mapper
public interface ShoppingCartDao {
	
    public void addShoppingCart(ShoppingCart shoppingCart) throws Exception;

    public ShoppingCart getShoppingCartList(int itemNo) throws Exception;

    public void deleteShoppingCartList(int shoppingCartNo) throws Exception;
	
}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


