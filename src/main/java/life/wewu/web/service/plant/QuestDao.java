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
public interface QuestDao {

	public void addQuest(Quest quest) throws Exception;

	public void deleteQuest(int questNo) throws Exception;

	public void updateQuest(Quest quest) throws Exception;

	public Quest getQuest(int questNo) throws Exception;

	public List<Quest> getQuestList(Search search) throws Exception;

	public void completeQuest(Quest quest) throws Exception;


}
