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
public interface QuestDao {

	public void addQuest(Quest quest) throws Exception;

	public void deleteQuest(int questNo) throws Exception;

	public void updateQuest(Quest quest) throws Exception;

	public Quest getQuest(int questNo) throws Exception;

	public List<Quest> getQuestList(Map<String,Object> map) throws Exception;
	
	public void completeAndupdateReward(int questNo) throws Exception;
	//등록일 이후 get으로 가져와야 퀘스트가 유의미
	//퀘스트의 목표에 따라 완료인지 아닌지 확인하는 로직 필요
	//상태가 업데이트 될때마다 세션도 업데이트
	
	public Quest getQuestByUser(String nickname) throws Exception;
	
	public List<Quest> getActiveQuestsByUser(String nickname) throws Exception;
	
	public Quest getQuestByStateNo(int questStateNo) throws Exception;
	
	
	
	public int memberAcleListCnt(Map<String,Object> map) throws Exception;

}
