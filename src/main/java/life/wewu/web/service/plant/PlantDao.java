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
public interface PlantDao {

	//add start
	public void addPlant(Plant plant) throws Exception;

	public void addPlantName(Plant plant) throws Exception;

	public void addPlantLevl(PlantLevl plantLevl) throws Exception;
	//add end

	//delete start
	public void deletePlant(PlantRequest plantRequest) throws Exception;
	
	public void deletePlantName(int plantNo) throws Exception;
	
	public void deletePlantLevl(int plantNo) throws Exception;	
	//delete end
	
	//update start
	public void updatePlant(PlantRequest plantRequest) throws Exception;
	
	public void updatePlantName(Plant plant) throws Exception;

	public void updatePlantLevl(PlantLevl plantLevl) throws Exception;
	//update end

	public Plant getPlant(int PlantNo) throws Exception;

	public List<Plant> getPlantList(Search search) throws Exception;

	public PlantLevl getPlantLevl(int plantLevlNo) throws Exception;

	public Plant selectRandomPlant() throws Exception;
}
