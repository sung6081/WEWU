package life.wewu.web.service.item;

import java.util.List;

import life.wewu.web.common.Search;
import life.wewu.web.domain.item.Item;

public interface ItemDao {
	
	// INSERT 판매 아이템 등록
    public int addItem(Item item) throws Exception;

    // SELECT 아이템 상세정보조회
    public Item getItem(int itemNo) throws Exception;

    // SELECT 아이템 목록조회
    public List<Item> getItemList(Search search) throws Exception;

    // UPDATE 판매 아이템 수정
    public int updateItem(Item item) throws Exception;

    // DELETE 판매 아이템 삭제
    public int deleteItem(int itemNo) throws Exception;
    
	//Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;
       
}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


