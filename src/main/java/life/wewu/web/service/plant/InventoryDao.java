package life.wewu.web.service.plant;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.common.Search;
import life.wewu.web.domain.plant.Inventory;
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.domain.plant.PlantLevl;
import life.wewu.web.domain.plant.PlantRequest;
import life.wewu.web.domain.plant.Quest;

@Mapper
public interface InventoryDao {

	
	public List<Inventory> getInventoryList(Map<String,Object> map) throws Exception;
	
	public void updateInventory(Inventory inventory) throws Exception;

	public Inventory useItem(Inventory inventory) throws Exception;
	
	public Inventory getInventory(int inventoryNo);

	public int getTotalCount(Map<String, Object> map) throws Exception;
}
