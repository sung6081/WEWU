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
public interface MyPlantDao {

	
	

	public void addRandomPlant(MyPlant myPlant) throws Exception;

	public void updateMyPlant(MyPlant myPlant) throws Exception;

	public MyPlant getMyPlant(String nickname) throws Exception;
	
	public MyPlant getMyPlantLevl(String nickname) throws Exception;

	public List<MyPlant> getMyPlantList(Map<String, Object> map) throws Exception;

	public MyPlant deleteMyPlant(int myPlantNo) throws Exception;
	
	public String getWeather(String location);



}
