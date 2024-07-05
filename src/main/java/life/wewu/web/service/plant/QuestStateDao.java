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
import life.wewu.web.domain.plant.QuestState;

@Mapper
public interface QuestStateDao {

	public List<QuestState> getQuestListByUser(Map<String,Object> map) throws Exception;
	
	public QuestState getQuestState(Map<String,Object> map) throws Exception;
	
	public void updateQuestState(Map<String,Object> map) throws Exception;
	
	public void insertQuestState(Map<String,Object> map) throws Exception;
	
	public void addQuestState(QuestState questState) throws Exception;

}
