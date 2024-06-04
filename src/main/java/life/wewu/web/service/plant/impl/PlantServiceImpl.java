package life.wewu.web.service.plant.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.domain.plant.Quest;
import life.wewu.web.service.plant.PlantDao;
import life.wewu.web.service.plant.PlantService;

@Service("PlantServiceImpl")
public class PlantServiceImpl implements PlantService{
	

	public PlantServiceImpl() {
		System.out.println(this.getClass());
	}
	
	@Autowired
	private PlantDao plantDao;
	
	
	public void setPlantDao(PlantDao plantDao) {
		this.plantDao = plantDao;
	}

	@Override
	public void addQuest(Quest quest) throws Exception {
		plantDao.addQuest(quest);
		
	}

	@Override
	public void deleteQuest(int questNo) throws Exception {
		
		
	}

	@Override
	public void updateQuest(Quest quest) throws Exception {
		plantDao.updateQuest(quest);		
	}

	@Override
	public Map<String, Object> getQuest(Quest quest) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void completeQuest(int questNo) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addPlant(Plant plant) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deletePlant(int plantNo) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updatePlant(Plant plant) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Plant getPlant(int PlantNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getPlantList(Plant plant) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MyPlant selectRandomPlant(MyPlant myPlant) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateMyPlant(MyPlant myPlant) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MyPlant getMyPlant(MyPlant myPlant) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getMyPlantList(MyPlant myPlant) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MyPlant deleteMyPlant(int myPlantNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void useItem(int itemNo) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void fileUpload(String filePath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void donatePlant(int plantNo, String nickname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getWeather(String location) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	

	

}
