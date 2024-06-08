package life.wewu.web.service.item;

import java.util.List;

import life.wewu.web.common.Search;
import life.wewu.web.domain.item.ItemPurchase;

public interface ItemPurchaseService {
	
	public void addPurchase(ItemPurchase itemPurchase) throws Exception;

    public ItemPurchase getRefundPointList(int itemNo) throws Exception; //다시확인

    public ItemPurchase getRefundPoint(int itemNo) throws Exception; //다시확인
    
    public ItemPurchase getItemSalesHistoryList(int itemPurchaseNo) throws Exception; //다시확인
    
    public ItemPurchase getItemSalesHistory(int itemPurchaseNo) throws Exception;
    
    public List<ItemPurchase> getItemPurchaseHistoryList(Search search) throws Exception;
	
	public List<ItemPurchase> getItemSalesHistory(Search search) throws Exception;

    public void updatePurchase(ItemPurchase itemPurchase) throws Exception;
    
}


