package life.wewu.web.service.plant;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import life.wewu.web.common.Search;
import life.wewu.web.domain.plant.Inventory;
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.domain.plant.PlantLevl;
import life.wewu.web.domain.plant.PlantRequest;
import life.wewu.web.domain.plant.Quest;
import life.wewu.web.domain.plant.QuestState;

public interface PlantService {

	public void addQuest(Quest quest) throws Exception;

	public void deleteQuest(int questNo) throws Exception;

	public void updateQuest(Quest quest) throws Exception;

	public Quest getQuest(int questNo) throws Exception;

	public List<Quest> getQuestList(Map<String, Object> map) throws Exception;
	
	public void completeAndupdateReward(int questNo) throws Exception;
	
	public Quest getQuestByUser(String nickname) throws Exception;
	
	public void checkQuestCompletion(String nickname) throws Exception;
	
	public boolean checkAcleCount(Quest quest,String nickname) throws Exception;
	
	public Quest getQuestByStateNo(int questStateNo) throws Exception;
	
	//---------------------------------------------------------------------------------------//
	
	public List<QuestState> getQuestListByUser(Map<String,Object> map) throws Exception;
	
	public void updateQuestState(int questStateNo, String string) throws Exception;
	
	public void insertQuestState(Map<String,Object> map) throws Exception;
	
	public QuestState getQuestState(Map<String,Object> map) throws Exception;
	
	public void addQuestState(QuestState questState) throws Exception;
	
	public void addQuestWithState(Quest quest, QuestState questState) throws Exception;
	
	//---------------------------------------------------------------------------------------//
	
	
	public void addPlant(PlantRequest plantRequest) throws Exception;
	
	public void addPlantName(Plant plant) throws Exception;
	
	public void addPlantLevl(PlantLevl plantlevl) throws Exception;

	public List<PlantLevl> getPlantLevls(int plantLevlNo) throws Exception;

	public void updatePlant(PlantRequest plantRequest) throws Exception;
	
	public void updatePlantName(Plant plant) throws Exception;
	
	public void updatePlantLevl(PlantLevl plantLevl) throws Exception;

	public Plant getPlant(int PlantNo) throws Exception;
	
	public PlantLevl getPlantLevl(int plantLevlNo) throws Exception;

	public List<Plant> getPlantList(Map<String, Object> map) throws Exception;
	
	public void deletePlant(int plantNo) throws Exception;
	
	public void deletePlantLevl(int plantNo) throws Exception;
	
	
	//---------------------------------------------------------------------------------------//

	public Plant selectRandomPlant() throws Exception;

	public void addMyPlant(MyPlant myPlant) throws Exception;

	public void updateMyPlant(MyPlant myPlant) throws Exception;

	public MyPlant getMyPlant(String nickname) throws Exception;
	
	public MyPlant getMyPlantLevl(String nickname) throws Exception;

	public List<MyPlant> getMyPlantList(Map<String, Object> map) throws Exception;
	
	public List<MyPlant> myPlantListbyLevlNo(Map<String, Object> map) throws Exception;

	public void deleteMyPlant(Map<String, Object> map) throws Exception;

	
	//---------------------------------------------------------------------------------------//

	
	public void updateInventory(Inventory inventory) throws Exception;

	public Inventory UseItem(Inventory inventory) throws Exception;

	public List<Inventory> getInventoryList(String nickname) throws Exception;

	public int getTotalCount(Map<String, Object> map) throws Exception;

	
	public int memberAcleListCnt(Map<String,Object> map) throws Exception;

}
