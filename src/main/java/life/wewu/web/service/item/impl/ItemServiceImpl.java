/*
 24.06.06 ItemServiceImpl.java 최윤정 작성
 */

package life.wewu.web.service.item.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import life.wewu.web.common.Search;
import life.wewu.web.domain.item.Item;
import life.wewu.web.service.item.ItemDao;
import life.wewu.web.service.item.ItemService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


//==> 아이템 서비스 구현
@Service("itemServiceImpl")
public class ItemServiceImpl implements ItemService{
	
	///Field
	@Autowired
	@Qualifier("itemDao")
	private ItemDao itemDao;
	
	public void setItemDao(ItemDao itemDao) {
		this.itemDao = itemDao;
	}
	
	///Constructor
	public ItemServiceImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addItem(Item item) throws Exception {
		itemDao.addItem(item);
	}

	public Item getItem(int itemNo) throws Exception{
	return itemDao.getItem(itemNo);
	}

	public Item getItemList(int itemNo) throws Exception{
		return itemDao.getItemList(itemNo);
	}

	public void updateItem(Item item) throws Exception{
		itemDao.updateItem(item);
	}
	
	public int deleteItem(int itemNo) throws Exception{
		return itemDao.deleteItem(itemNo);
	}
	
	public Map<String , Object > getItemSearch(Search search) throws Exception {
	List<Item> list= itemDao.getItemSearch(search);
	int totalCount = itemDao.getTotalCount(search);
	
	Map<String, Object> map = new HashMap<String, Object>();
	map.put("list", list );
	map.put("totalCount", new Integer(totalCount));
	
	return map;
}
	
}
