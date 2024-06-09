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
	
	@Qualifier("plantDao")
	@Autowired
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
		List<Quest> list = plantDao.getQuestList(search);
		Map<String,Object> map = new HashMap<>();
		map.put("list",list);
		
		return map;
	}

	@Override
	public void completeQuest(int questNo) throws Exception {
		plantDao.completeQuest(questNo);
	}
	
	

	//------------- 식물정보
	
	@Override
	public void addPlantName(Plant plant) throws Exception {
		plantDao.addPlantName(plant);
		
	}
	
	@Override
	public void addPlantLevl(Plant plant) throws Exception {
		plantDao.addPlantLevl(plant);
		
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
	public List<MyPlant> getMyPlantList(Map map) throws Exception {
		
		return plantDao.getMyPlantList(map);
	}

	@Override
	public void deleteMyPlant(int myPlantNo) throws Exception {
		
		plantDao.deleteMyPlant(myPlantNo);
	}


	//------------- 파일업로드
	@Override
	public void fileUpload(String filePath) throws Exception {
		// 업로드할 파일이 저장될 경로
	    String uploadDir = "uploads/";

	    // 업로드 디렉토리가 존재하지 않는 경우 생성
	    Path uploadPath = Paths.get(uploadDir);
	    if (!Files.exists(uploadPath)) {
	        Files.createDirectories(uploadPath);
	    }

	    // 파일 읽기
	    File file = new File(filePath);
	    if (!file.exists()) {
	        throw new IOException("파일이 존재하지 않습니다: " + filePath);
	    }

	    // 파일 이름 가져오기
	    String fileName = file.getName();

	    // 업로드할 파일의 전체 경로 생성
	    Path filePathToSave = uploadPath.resolve(fileName);

	    // 파일을 업로드 디렉토리로 복사
	    try (FileOutputStream fos = new FileOutputStream(filePathToSave.toFile())) {
	        Files.copy(file.toPath(), fos);
	    } catch (IOException e) {
	        throw new IOException("파일 업로드 중 오류가 발생했습니다.", e);
	    }
	}
		

	@Override
	public void donatePlant(int plantNo, String nickname) throws Exception {	
		plantDao.donatePlant(plantNo, nickname);	
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
	public Inventory getInventory(int itemPurno) throws Exception {
		return plantDao.getInventory(itemPurno);
	}
	
	@Override	
	public Inventory getUseItem(int itemPurNo) throws Exception{
	
		MyPlant myPlant = plantDao.getMyPlant(1);
		System.out.println(myPlant);
		Inventory inventory = plantDao.getInventory(itemPurNo);
		
		int ItemExp = Integer.parseInt(inventory.getItemExp());
		System.out.println("itemExp : "+ ItemExp);
		int myPlantExp = myPlant.getMyPlantExp();
		System.out.println("myPlnatExp : "+ myPlantExp);
		int newExp = myPlantExp + ItemExp;
		System.out.println("newExp : "+ newExp);
		
		myPlant.setMyPlantExp(newExp);	
		plantDao.updateMyPlant(myPlant);
		System.out.println("newExpMyPlant : "+ myPlant);
		
		int itemNum = inventory.getItemNum();
		int newStock = itemNum - 1;
		
		inventory.setItemNum(newStock);
		
		return plantDao.getInventory(itemPurNo);
	}


}



	


