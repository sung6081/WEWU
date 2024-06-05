package life.wewu.web.service.item;

import java.util.List;
import java.util.Map;

import life.wewu.web.common.Search;
import life.wewu.web.domain.item.Item;

public interface ItemService {
	
    public void addItem(Item item) throws Exception;

    public Item getItem(int itemNo) throws Exception;

    public Item getItemList(int itemNo) throws Exception;

    public int updateItem(Item item) throws Exception;

    public int deleteItem(Item item) throws Exception;
    
    public Map<String , Object> getItemSearch(Search search) throws Exception;
    

}


