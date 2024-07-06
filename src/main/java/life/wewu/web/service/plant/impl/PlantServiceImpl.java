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
import life.wewu.web.service.user.UserDao;
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
	@Qualifier("userDao")
	private UserDao userDao;
	
	
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
	    questStateMap.put("quest_state", "Y");
	    System.out.println(questStateMap);
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
		
		int acleCount = groupAcleDao.memberAcleListCnt(map);
		return acleCount >= quest.getQuestTargetCnt();
	}

	
	@Override
	@Transactional
	public void completeAndupdateReward(int questStateNo) throws Exception {
	    updateQuestState(questStateNo, "Q");

	    User user = (User) session.getAttribute("user");
	    MyPlant myPlant = myPlantDao.getMyPlant(user.getNickname());
	    
	    if (myPlant == null) {
	        throw new Exception("해당 사용자의 식물 정보가 존재하지 않습니다.");
	    }

	    int currentExp = myPlant.getMyPlantExp();
	    Quest quest = questDao.getQuestByStateNo(questStateNo); // questStateNo를 이용해 퀘스트 가져오기
	    int questReward = quest.getQuestReward();

	    int newExp = currentExp + questReward;

	    Map<String, Object> expMap = new HashMap<>();
	    expMap.put("nickname", user.getNickname());
	    expMap.put("myPlantExp", newExp);
	    myPlantDao.updateMyPlantExp(expMap);
	}

	// ---------------------------------------------------------------------------------------//
	

	@Override
	public void addQuestState(QuestState questState) throws Exception {
		questStateDao.addQuestState(questState);
		
	}
	
	 @Override
	    @Transactional
	    public void addQuestWithState(Quest quest, QuestState questState) throws Exception {
	        // 퀘스트 추가
	        questDao.addQuest(quest);

	        // 모든 유저 목록 가져오기
	        List<User> allUsers = userDao.getAllUsers();

	        // 각 유저에 대해 상태 추가
	        for (User user : allUsers) {
	            QuestState newQuestState = new QuestState();
	            newQuestState.setQuestNo(quest.getQuestNo());
	            newQuestState.setNickname(user.getNickname());
	            newQuestState.setQuestState("N"); // 초기 상태 설정
	            questStateDao.addQuestState(newQuestState);
	        }
	    }
	
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
	    public void updateQuestState(int questStateNo, String state) throws Exception {
	        Map<String, Object> updateMap = new HashMap<>();
	        updateMap.put("quest_state_no", questStateNo);
	        updateMap.put("quest_state", state);
	        questStateDao.updateQuestState(updateMap);
	    }

	@Override
	public void insertQuestState(Map<String, Object> map) throws Exception {
		questStateDao.insertQuestState(map);
		
	}
	
	@Override
	public QuestState getQuestState(Map<String, Object> map) throws Exception {
		
		return questStateDao.getQuestState(map);
	}


	@Override
	public Quest getQuestByStateNo(int questStateNo) throws Exception {
		return questDao.getQuestByStateNo(questStateNo);
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
	
	
	@Override
	public List<MyPlant> myPlantListbyLevlNo(Map<String, Object> map) throws Exception {
		return myPlantDao.myPlantListbyPlantNo(map);
	}


	@Override
	public void deleteMyPlant(Map<String, Object> map) throws Exception {
		myPlantDao.deleteMyPlant(map);
		
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
	public List<Inventory> getInventoryList(Map<String,Object> map) throws Exception {
		return inventoryDao.getInventoryList(map);
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

	    System.out.println("UserItem currentStock : " + currentStock);
	    System.out.println("UserItem useItemNum : " + useItemNum);
	    System.out.println("UserItem itemEffect : " + itemEffect);

	    if (currentStock > 0) {
	        inventory.setItemNum(currentStock - useItemNum);
	        System.out.println("::::inventory Before update : " + inventory);
	        inventoryDao.updateInventory(inventory);
	       
	    }
	    System.out.println("UserItem inventory : " + inventory);

	    MyPlant myPlant = myPlantDao.getMyPlant(user.getNickname());
	    int newExp = myPlant.getMyPlantExp() + itemEffect;
	    System.out.println("UserItem newExp : " + newExp);
	    myPlant.setMyPlantExp(newExp);
	    myPlantDao.updateMyPlant(myPlant);

	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("myPlantNo", inventory.getMyPlant().getMyPlantNo());
	    map.put("myPlantExp", inventory.getItemExp());

	    myPlantDao.updateMyPlantExp(map);

	    return inventory;
	}
		

	@Override
	public int getTotalCount(Map<String, Object> map) throws Exception {
		return inventoryDao.getTotalCount(map);
	}













}
