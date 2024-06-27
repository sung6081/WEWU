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
import life.wewu.web.service.plant.InventoryDao;
import life.wewu.web.service.plant.PlantDao;
import life.wewu.web.service.plant.PlantService;
import life.wewu.web.service.plant.QuestDao;
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
	@Qualifier("myPlantDao")
	private MyPlantDao myPlantDao;

	@Autowired
	@Qualifier("inventoryDao")
	private InventoryDao inventoryDao;

	public void setPlantDao(PlantDao plantDao) {
		this.plantDao = plantDao;
	}

	// ---------------------------------------------------------------------------------------//
	@Override
	public void addQuest(Quest quest) throws Exception {
		questDao.addQuest(quest);
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
	public Map<String, Object> getQuestList(Search search) throws Exception {

		int questNo = 1;
		Quest quest = questDao.getQuest(questNo);
		search.setSearchKeyword(String.valueOf(quest.getQuestNo()));
		List<Quest> list = questDao.getQuestList(search);
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);

		return map;
	}

	@Override
	public void completeQuest(Quest quest) throws Exception {
		questDao.completeQuest(quest);
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
	public MyPlant deleteMyPlant(String nickname) throws Exception {
		MyPlant myPlant = myPlantDao.getMyPlant(nickname);
		String myPlantLevl = myPlant.getMyPlantLevl();

		PlantLevl plantLevl = plantDao.getPlantLevl(myPlant.getMyPlantNo());
		String finalLevl = plantLevl.getPlantFinalLevl();

		if (myPlantLevl == finalLevl) {
			// 포인트 10%반환
		} else {
			return myPlantDao.deleteMyPlant(myPlant.getMyPlantNo());
		}

		return myPlantDao.deleteMyPlant(myPlant.getMyPlantNo());
	}

	@Override
	public String getWeather(String location) throws Exception {
		return myPlantDao.getWeather(location);
	}

	@Override
	public void addRandomPlant(MyPlant myPlant) throws Exception {
		myPlantDao.addRandomPlant(myPlant);
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
	public Map<String, Object> UseItem(Inventory inventory) throws Exception {

		return null;

	}

}
