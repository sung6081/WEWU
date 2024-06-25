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

import org.apache.ibatis.session.SqlSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import life.wewu.web.common.Search;
import life.wewu.web.domain.plant.Inventory;
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.domain.plant.PlantLevl;
import life.wewu.web.domain.plant.PlantRequest;
import life.wewu.web.domain.plant.Quest;
import life.wewu.web.service.plant.PlantDao;
import life.wewu.web.service.plant.PlantService;

@Service("plantServiceImpl")
public class PlantServiceImpl implements PlantService{

	@Autowired
	private SqlSession sqlSession;
	
	public PlantServiceImpl() {
		System.out.println(this.getClass());
	}
	
	@Autowired
	@Qualifier("plantDao")
	private PlantDao plantDao;
	
	public void setPlantDao(PlantDao plantDao) {
		this.plantDao = plantDao;
	}

	//------------- 퀘스트
	@Override
	public void addQuest(Quest quest) throws Exception {
		plantDao.addQuest(quest);	
	}

	@Override
	public void deleteQuest(int questNo) throws Exception {
		plantDao.deleteQuest(questNo);
	}

	@Override
	public void updateQuest(Quest quest) throws Exception {
		plantDao.updateQuest(quest);		
	}
	

	@Override
	public Quest getQuest(int questNo) throws Exception {
		return plantDao.getQuest(questNo);
	}

	@Override
	public Map<String, Object> getQuestList(Search search) throws Exception {
		
		int questNo = 1;
		Quest quest = plantDao.getQuest(questNo);
		search.setSearchKeyword(String.valueOf(quest.getQuestNo()));
		List<Quest> list = plantDao.getQuestList(search);
		Map<String,Object> map = new HashMap<>();
		map.put("list",list);
		
		return map;
	}

	@Override
	public void completeQuest(Quest quest) throws Exception {
		plantDao.completeQuest(quest);
	}
	
	

	//------------- 식물정보
	
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

	@Override
	public PlantLevl getPlantLevl(int plantLevlNo) throws Exception {
		return plantDao.getPlantLevl(plantLevlNo);
	}
	
	public void addPlantLevl(PlantLevl plantlevl) throws Exception {
		plantDao.addPlantLevl(plantlevl);	
	}

	public void updatePlantLevl(Plant plant) throws Exception{
		plantDao.updatePlantLevl(plant);
	}

	@Override
	public void deletePlant(int plantNo) throws Exception {
		plantDao.deletePlant(plantNo);
	}

	@Override
	public void updatePlant(Plant plant) throws Exception {
		plantDao.updatePlant(plant);
		
	}

	@Override
	public Plant getPlant(int PlantNo) throws Exception {
		return plantDao.getPlant(PlantNo);
	}
	
	
	@Override
	public Map<String, Object> getPlantList(Search search) throws Exception {
		List<Plant> list = plantDao.getPlantList(search);
		for(Plant plant : list)
		{
			PlantLevl plantLevl = plant.getPlantLevl();
			plant.setPlantLevl(plantLevl);
			
		}
		
		Map<String,Object> map = new HashMap<>();
		map.put("list",list);
		
		return map;
	}
	

	
	//------------- 나의식물	
	
	@Override
	public Plant selectRandomPlant() throws Exception {	
		return plantDao.selectRandomPlant();	
	}

	@Override
	public void updateMyPlant(MyPlant myPlant) throws Exception {
		plantDao.updateMyPlant(myPlant);	
	}

	@Override
	public MyPlant getMyPlant(int myPlantNo) throws Exception {	
		return plantDao.getMyPlant(myPlantNo);
	}

	@Override
	public List<MyPlant> getMyPlantList(Map<String,Object> map) throws Exception {	
		return plantDao.getMyPlantList(map);
	}

	@Override
	public MyPlant deleteMyPlant(int myPlantNo) throws Exception {	
		MyPlant myPlant = plantDao.getMyPlant(myPlantNo);
		String myPlantLevl = myPlant.getMyPlantLevl();
		
		PlantLevl plantLevl = plantDao.getPlantLevl(myPlantNo);
		String finalLevl = plantLevl.getPlantFinalLevl();
		
		if(myPlantLevl == finalLevl) {
			//포인트 10%반환
		}else {
			return plantDao.deleteMyPlant(myPlantNo);
		}
	
//		나의 식물 단계랑 마지막 단곌르 비교해서 똑같으면 기부하고 플래그를 n으로 바꿈
//		아니면 그냥 플래그를 n으롭 바꿈
		return plantDao.deleteMyPlant(myPlantNo);
	}


	@Override
	public String getWeather(String location) throws Exception {
		return plantDao.getWeather(location);
	}

	@Override
    public void addRandomPlant(MyPlant myPlant) throws Exception { 
		plantDao.addRandomPlant(myPlant);		
	}


	//------------- 인벤토리
	@Override
	public List<Inventory> getInventory(String nickname) throws Exception {
		return plantDao.getInventory(nickname);
	}
	
	@Override
	public Map<String, Object> getUseItem(Map<String, Object> map) throws Exception {
	    int myPlantNo = (int) map.get("myPlantNo");
	    String nickname = (String) map.get("nickname");
	    int useItemNum = (int) map.get("useItemNum");

	    MyPlant myPlant = plantDao.getMyPlant(myPlantNo);
	    List<Inventory> inventory = plantDao.getInventory(nickname);

	    int itemExp = Integer.parseInt(((Inventory) inventory).getItemExp());
	    int myPlantExp = myPlant.getMyPlantExp();
	    int newExp = myPlantExp + (itemExp * useItemNum );

	    myPlant.setMyPlantExp(newExp);
	    plantDao.updateMyPlant(myPlant);

	    int itemNum = ((Inventory) inventory).getItemNum();
	    int newStock = itemNum - useItemNum;

	    ((Inventory) inventory).setItemNum(newStock);
	    plantDao.updateInventory(inventory);

	    Map<String, Object> list = new HashMap<>();
	    list.put("myPlant", myPlant);
	    list.put("inventory", plantDao.getInventory(nickname));
	    return list;
	}



}



	


