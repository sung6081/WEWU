package life.wewu.web.service.item;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.domain.item.Item;
import life.wewu.web.domain.item.ItemPurchase;

@Mapper
public interface ItemPurchaseDao {
	
	public void addPurchase(ItemPurchase itemPurchase) throws Exception;

    public ItemPurchase getRefundPointList(int itemNo) throws Exception; //다시확인

    public ItemPurchase getRefundPoint(int itemNo) throws Exception; //다시확인
    
    public ItemPurchase getItemSalesHistoryList(int itemPurchaseNo) throws Exception; //다시확인
    
    public ItemPurchase getItemSalesHistory(int itemPurchaseNo) throws Exception;
    
    public ItemPurchase getItemPurchaseHistoryList(String buyerNickname) throws Exception;
    
    public ItemPurchase getItemPurchaseHistory(String buyerNickname) throws Exception;

    public int deletePurchase(ItemPurchase itemPurchase) throws Exception;
    
    public ItemPurchase getPointChargeList(int payNo) throws Exception;
    
    public ItemPurchase getPointCharge(int payNo) throws Exception;
    
    public void updatePointCharge(int payNo) throws Exception;
    
    public void addPointCharge(ItemPurchase itemPurchase) throws Exception;
       
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


