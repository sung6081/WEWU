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
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
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

	
	
	//----------------------------------------------------------------Quest-------
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
	
	

	//----------------------------------------------------------------Plant-------
	
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
		Map<String,Object> map = new HashMap<>();
		map.put("list",list);
		
		return map;
	}

	
	
	//----------------------------------------------------------------MyPlant-------	
	
	@Override
	public MyPlant selectRandomPlant(String myPlantName) throws Exception {
		
		return sqlSession.selectOne("life.wewu.web.domain.plant.MyPlantMapper.selectRandomPlant");
		
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
	public Map<String, Object> getMyPlantList(Search search) throws Exception {
		
		List<MyPlant> list = plantDao.getMyPlantList(search);
		
		Map<String,Object> map = new HashMap<>();
		map.put("list",list);
		return map;
	}

	@Override
	public MyPlant deleteMyPlant(int myPlantNo) throws Exception {
		
		return plantDao.deleteMyPlant(myPlantNo);
	}

	@Override
	public void useItemAndExpIncrease(int itemNo) throws Exception {
		plantDao.useItemAndExpIncrease(itemNo);
	}

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
	@Transactional
	public MyPlant addRandomPlant(String myPlantName) {
		
		 MyPlant randomPlant = sqlSession.selectOne("life.wewu.web.domain.plant.MyPlantMapper.selectRandomPlant");

	        // 선택한 식물을 my_plant 테이블에 삽입
	        randomPlant.setMyPlantName(myPlantName);
	        sqlSession.insert("life.wewu.web.domain.plant.MyPlantMapper.addRandomPlant", randomPlant);
	        
			return randomPlant;
		
	}



	

}
