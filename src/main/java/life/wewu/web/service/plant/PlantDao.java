package life.wewu.web.service.plant;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.common.Search;
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.domain.plant.Quest;

@Mapper
public interface PlantDao {
	
	public void addQuest(Quest quest) throws Exception;
	
	public void deleteQuest(int questNo) throws Exception;
	
	public void updateQuest(Quest quest) throws Exception;
	
	public Quest getQuest(int questNo) throws Exception;
	
	public List<Quest> getQuestList(Search search) throws Exception;
	
	public void completeQuest(int questNo) throws Exception; 
	
	
	public void addPlantName(Plant plant) throws Exception;
	
	public void addPlantLevl(Plant plant) throws Exception;
	
	public void deletePlant(int plantNo) throws Exception;
	
	public void updatePlant(Plant plant) throws Exception;
	
	public Plant getPlant(int PlantNo) throws Exception;
	
	public List<Plant> getPlantList(Search search) throws Exception;
	
	
	public MyPlant selectRandomPlant(String myPlantName) throws Exception;
	
	public void updateMyPlant(MyPlant myPlant) throws Exception;
	
	public MyPlant getMyPlant(int myPlantNo) throws Exception;
	
	public List<MyPlant> getMyPlantList(Search search) throws Exception;
	
	public MyPlant deleteMyPlant(int myPlantNo) throws Exception;
	
	public void donatePlant(int plantNo ,String nickname) throws Exception;
	
	public void useItemAndExpIncrease(int itemNo) throws Exception;
	     
	public void fileUpload(String filePath) throws Exception;

	public String getWeather(String location);
	
	 
	
	
	

}
