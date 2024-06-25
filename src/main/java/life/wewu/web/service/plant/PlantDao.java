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

	
	public void addPlant(Plant plant) throws Exception;

	public void addPlantName(Plant plant) throws Exception;

	public void addPlantLevl(PlantLevl plantLevl) throws Exception;

	public PlantLevl getPlantLevl(int plantLevlNo) throws Exception;

	public void deletePlant(int plantNo) throws Exception;

	public void updatePlant(Plant plant) throws Exception;

	public void updatePlantLevl(Plant plant) throws Exception;

	public Plant getPlant(int PlantNo) throws Exception;

	public List<Plant> getPlantList(Search search) throws Exception;



}
