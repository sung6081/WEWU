/*
 24.06.06 ItemPurchaseServiceImpl.java 최윤정 작성
 */

package life.wewu.web.service.item.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import life.wewu.web.common.Search;
import life.wewu.web.domain.item.ItemPurchase;
import life.wewu.web.service.item.ItemPurchaseDao;
import life.wewu.web.service.item.ItemPurchaseService;

import java.util.List;

//==> 아이템 서비스 구현
@Service("itemPurchaseServiceImpl")
public class ItemPurchaseServiceImpl implements ItemPurchaseService{
	
	///Field
	@Autowired
	@Qualifier("itemPurchaseDao")
	private ItemPurchaseDao itemPurchaseDao;
	
	public void setItemPurchaseDao(ItemPurchaseDao itemPurchaseDao) {
		this.itemPurchaseDao = itemPurchaseDao;
	}
	
	///Constructor
	public ItemPurchaseServiceImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addPurchase(ItemPurchase itemPurchase) throws Exception {
		itemPurchaseDao.addPurchase(itemPurchase);
	}

	public ItemPurchase getRefundPointList(int itemNo) throws Exception{
		return itemPurchaseDao.getRefundPointList(itemNo);
	}

    public ItemPurchase getRefundPoint(int itemNo) throws Exception{
    	return itemPurchaseDao.getRefundPoint(itemNo);
    }
    
    public ItemPurchase getItemSalesHistoryList(int itemPurchaseNo) throws Exception{
    	return itemPurchaseDao.getItemSalesHistoryList(itemPurchaseNo);
    }
    
    public ItemPurchase getItemSalesHistory(int itemPurchaseNo) throws Exception{
    	return itemPurchaseDao.getItemSalesHistory(itemPurchaseNo);
    }
    
    public List<ItemPurchase> getItemPurchaseHistoryList(Search search) throws Exception{
    	return itemPurchaseDao.getItemPurchaseHistoryList(search); 
    }
	
	public List<ItemPurchase> getItemSalesHistory(Search search) throws Exception{
		return itemPurchaseDao.getItemSalesHistory(search); 
	}

    public void updatePurchase(ItemPurchase itemPurchase) throws Exception {
    	itemPurchaseDao.updatePurchase(itemPurchase); 
    }
	
}
