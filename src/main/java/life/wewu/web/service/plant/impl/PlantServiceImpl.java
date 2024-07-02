package life.wewu.web.service.plant.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import life.wewu.web.common.Search;
import life.wewu.web.domain.group.GroupAcle;
import life.wewu.web.domain.plant.Inventory;
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.domain.plant.PlantLevl;
import life.wewu.web.domain.plant.PlantRequest;
import life.wewu.web.domain.plant.Quest;
import life.wewu.web.domain.plant.QuestState;
import life.wewu.web.domain.user.User;
import life.wewu.web.service.group.GroupAcleDao;
import life.wewu.web.service.group.GroupDao;
import life.wewu.web.service.plant.InventoryDao;
import life.wewu.web.service.plant.PlantDao;
import life.wewu.web.service.plant.PlantService;
import life.wewu.web.service.plant.QuestDao;
import life.wewu.web.service.plant.QuestStateDao;
import life.wewu.web.service.plant.MyPlantDao;

@Service("plantServiceImpl")
public class PlantServiceImpl implements PlantService {

	public PlantServiceImpl() {
		System.out.println(this.getClass());
	}

	@Autowired
	private SqlSession sqlSession;

	@Autowired
	@Qualifier("plantDao")
	private PlantDao plantDao;

	@Autowired
	@Qualifier("questDao")
	private QuestDao questDao;
	
	@Autowired
	@Qualifier("questStateDao")
	private QuestStateDao questStateDao;

	@Autowired
	@Qualifier("myPlantDao")
	private MyPlantDao myPlantDao;

	@Autowired
	@Qualifier("inventoryDao")
	private InventoryDao inventoryDao;
	
	@Autowired
	@Qualifier("groupAcleDao")
	private GroupAcleDao groupAcleDao;
	
	
	@Autowired
    private HttpSession session;

	public void setPlantDao(PlantDao plantDao) {
		this.plantDao = plantDao;
	}

	// ---------------------------------------------------------------------------------------//
	@Override
	public void addQuest(Quest quest) throws Exception {
		questDao.addQuest(quest);
        int questNo = quest.getQuestNo();
        if (questNo == 0) {
            throw new Exception("Generated questNo is null or 0");
        }
        System.out.println("Generated questNo: " + questNo);

        Map<String, Object> questStateMap = new HashMap<>();
        questStateMap.put("quest_no", questNo);
        User user = (User) session.getAttribute("user");
        questStateMap.put("nickname", user.getNickname());
        questStateMap.put("questState", "Y");
        questStateDao.insertQuestState(questStateMap);
	}

	@Override
	public void deleteQuest(int questNo) throws Exception {
		questDao.deleteQuest(questNo);
	}

	@Override
	public void updateQuest(Quest quest) throws Exception {
		questDao.updateQuest(quest);
	}

	@Override
	public Quest getQuest(int questNo) throws Exception {
		return questDao.getQuest(questNo);
	}
	

	@Override
	public List<Quest> getQuestList(Map<String,Object> map) throws Exception {

		List<Quest> quests = questDao.getQuestList(map);
		System.out.println(quests);
		
		
		for(Quest quest : quests) {
			
			map.put("questNo", quest.getQuestNo());
			quest.setQuestState(questStateDao.getQuestState(map));
		}
		
	
		return quests;
	}
	

	@Override
	public void checkQuestCompletion(String nickname) throws Exception {
		List<Quest> activeQuest = questDao.getActiveQuestsByUser(nickname);
		
		for(Quest quest : activeQuest) {
			if(checkAcleCount(quest,nickname)) {
				completeAndupdateReward(quest.getQuestState().getQuestStateNo());
			}
		}
		
	}

	@Override
	public boolean checkAcleCount(Quest quest, String nickname) throws Exception {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("nickname", nickname);
		map.put("questRegDate", quest.getRegDate());
		
		int acleCount = groupAcleDao.getGroupAcleListCnt(map);
		return acleCount >= quest.getQuestTargetCnt();
	}

	
	@Override
	public void completeAndupdateReward(int questStateNo) throws Exception {
		
		Map<String, Object> updateMap = new HashMap<>();
		
        updateMap.put("quest_state_no", questStateNo);
        updateMap.put("quest_state", "N");
        questStateDao.updateQuestState(updateMap);
        
        // 디버깅을 위해 업데이트 매개변수를 로그로 출력
        System.out.println("1.questStateNo : " +questStateNo);
        System.out.println("2.Updating quest state: " + updateMap);
        
        // 현재 식물 경험치 가져오기
        User user = (User) session.getAttribute("user");
        MyPlant myPlant = myPlantDao.getMyPlant(user.getNickname());
        // myPlant가 null인지 체크
        if (myPlant == null) {
            throw new Exception("해당 사용자의 식물 정보가 존재하지 않습니다.");
        }
        System.out.println("3.myPlant :"+myPlant);
        
        int currentExp = myPlant.getMyPlantExp();
        System.out.println("4.currentExp :"+currentExp);
        
        // 퀘스트 정보 가져오기 (퀘스트 보상 포함) 
        Quest quest = questDao.getQuestByUser(user.getNickname());
        int questReward = quest.getQuestReward();
        System.out.println("5.questReward :"+questReward);

        // 새로운 경험치 계산
        int newExp = currentExp + questReward;
        System.out.println("6.newExp :"+newExp);

        // 식물 경험치 업데이트
        Map<String, Object> expMap = new HashMap<>();
        expMap.put("nickname", user.getNickname());
        expMap.put("myPlantExp", newExp);
        myPlantDao.updateMyPlantExp(expMap);
        System.out.println("7.expMap : "+expMap);
		
		
	}
	

	// ---------------------------------------------------------------------------------------//
	
	@Override
	public List<QuestState> getQuestListByUser(Map<String,Object> map) throws Exception {
		
		User user = (User) session.getAttribute("user");
		System.out.println(user);
	
		List<Quest> quests = questDao.getQuestList(map);
		System.out.println(quests);
		
		
		for(Quest quest : quests) {
			
			map.put("questNo", quest.getQuestNo());
			quest.setQuestState(questStateDao.getQuestState(map));
		}
		
		map.put("quest", quests);
		map.put("user", user);
		
		
		List<QuestState> list = questStateDao.getQuestListByUser(map);
		System.out.println("getQuestListByUser : "+map);
		return list;
	}
        

	@Override
	public Quest getQuestByUser(String nickname) throws Exception {
		
		return questDao.getQuestByUser(nickname);
	}
	
	@Override
	public void updateQuestState(Map<String, Object> map) throws Exception {
		questStateDao.updateQuestState(map);
		
	}

	@Override
	public void insertQuestState(Map<String, Object> map) throws Exception {
		questStateDao.insertQuestState(map);
		
	}
	
	@Override
	public QuestState getQuestState(Map<String, Object> map) throws Exception {
		
		return questStateDao.getQuestState(map);
	}




	// ---------------------------------------------------------------------------------------//

	@Transactional
	public void addPlant(PlantRequest plantRequest) throws Exception {
		System.out.println("PlantRequest: " + plantRequest);
		System.out.println("Plant: " + plantRequest.getPlant());
		System.out.println("PlantLevl: " + plantRequest.getPlantLevl());

		// Plant 삽입
		plantDao.addPlant(plantRequest.getPlant());

		// 삽입된 Plant의 plantNo를 가져와서 PlantLevl에 설정
		int plantNo = plantRequest.getPlant().getPlantNo();
		plantRequest.getPlantLevl().setPlantNo(plantNo);

		// PlantLevl 삽입
		plantDao.addPlantLevl(plantRequest.getPlantLevl());

	}

	@Override
	public void addPlantName(Plant plant) throws Exception {
		plantDao.addPlantName(plant);
	}

	public void addPlantLevl(PlantLevl plantlevl) throws Exception {
		plantDao.addPlantLevl(plantlevl);
	}

	@Override
	public void updatePlant(PlantRequest plantRequest) throws Exception {
		plantDao.updatePlantName(plantRequest.getPlant());
		plantDao.updatePlantLevl(plantRequest.getPlantLevl());
	}

	public void updatePlantName(Plant plant) throws Exception {
		plantDao.updatePlantName(plant);
	}

	public void updatePlantLevl(PlantLevl plantLevl) throws Exception {
		plantDao.updatePlantLevl(plantLevl);
	}

	@Override
	public Plant getPlant(int PlantNo) throws Exception {
		return plantDao.getPlant(PlantNo);
	}

	public PlantLevl getPlantLevl(int plantLevlNo) throws Exception {
		return plantDao.getPlantLevl(plantLevlNo);
	}

	public List<PlantLevl> getPlantLevls(int plantLevlNo) throws Exception {
		return plantDao.getPlantLevls(plantLevlNo);
	}

	@Override
	public List<Plant> getPlantList(Map<String, Object> map) throws Exception {
		List<Plant> list = plantDao.getPlantList(map);
	    System.out.println("Retrieved Plant List: " + list); // 리스트 출력
	    
	    return list;
	}

	@Override
	public Plant selectRandomPlant() throws Exception {
		return plantDao.selectRandomPlant();
	}
	
	@Override
	public void deletePlant(int plantNo) throws Exception {
		plantDao.deleteMyPlant(plantNo);
		plantDao.deletePlantLevl(plantNo);
        plantDao.deletePlant(plantNo);
		
	}
	@Override
	public void deletePlantLevl(int plantNo) throws Exception {
		plantDao.deletePlantLevl(plantNo);
		
	}
	@Override
	public void deleteMyPlant(int plantNo) throws Exception {
		plantDao.deleteMyPlant(plantNo);
		
	}



	// ---------------------------------------------------------------------------------------//
	@Override
	public void updateMyPlant(MyPlant myPlant) throws Exception {
		myPlantDao.updateMyPlant(myPlant);
	}

	@Override
	public MyPlant getMyPlant(String nickname) throws Exception {
		
		return myPlantDao.getMyPlant(nickname);
	}

	public MyPlant getMyPlantLevl(String nickname) throws Exception {
		return myPlantDao.getMyPlantLevl(nickname);
	}

	@Override
	public List<MyPlant> getMyPlantList(Map<String, Object> map) throws Exception {

		return myPlantDao.getMyPlantList(map);
	}
	
	public List<MyPlant> myPlantListbyLevlNo(Map<String, Object> map) throws Exception{
		return myPlantDao.myPlantListbyLevlNo(map);
	}

	@Override
	public void deleteMyPlant(String nickname) throws Exception {
		myPlantDao.deleteMyPlant(nickname);
	}

	@Override
	public String getWeather(String location) throws Exception {
		return myPlantDao.getWeather(location);
	}

	@Override
	public void addMyPlant(MyPlant myPlant) throws Exception {

		myPlantDao.addMyPlant(myPlant);
		
	}

	// ---------------------------------------------------------------------------------------//

	@Override
	public List<Inventory> getInventoryList(String nickname) throws Exception {
		return inventoryDao.getInventoryList(nickname);
	}

	@Override
	public void updateInventory(Inventory inventory) throws Exception {

		inventoryDao.updateInventory(inventory);
	}

	@Override
	public Inventory UseItem(Inventory inventory) throws Exception {
		
		int currentStock = inventory.getItemNum();
		int useItemNum = inventory.getUseItemNum();
		int itemEffect = Integer.parseInt(inventory.getItemExp());
		User user = (User) session.getAttribute("user");
		
		System.out.println("UserItem currentStock : "+currentStock);
		System.out.println("UserItem useItemNum : "+useItemNum);
		System.out.println("UserItem itemEffect : "+itemEffect);
		
		if(currentStock>0) {
			inventory.setItemNum(currentStock - useItemNum);
			System.out.println("::::inventory Before update : "+inventory);
            inventoryDao.updateInventory(inventory);
		}
		System.out.println("UserItem inventory : "+inventory);
		
		 MyPlant myPlant = myPlantDao.getMyPlant(user.getNickname());
         int newExp = myPlant.getMyPlantExp() + itemEffect;
         System.out.println("UserItem newExp : "+newExp);
         myPlant.setMyPlantExp(newExp);
         myPlantDao.updateMyPlant(myPlant);
         
         Map<String,Object> map = new HashMap<String, Object>();
         map.put("myPlantNo", inventory.getMyPlant().getMyPlantNo());
         map.put("myPlantExp", inventory.getItemExp());
		
		myPlantDao.updateMyPlantExp(map);
		
		
		return inventory;
		

	}











}
