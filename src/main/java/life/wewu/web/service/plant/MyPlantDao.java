package life.wewu.web.service.plant;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.domain.plant.MyPlant;

@Mapper
public interface MyPlantDao {

	
	

	public void addMyPlant(MyPlant myPlant) throws Exception;

	public void updateMyPlant(MyPlant myPlant) throws Exception;

	public MyPlant getMyPlant(String nickname) throws Exception;
	
	public MyPlant getMyPlantLevl(String nickname) throws Exception;

	public List<MyPlant> getMyPlantList(Map<String, Object> map) throws Exception;

	public void deleteMyPlant(Map<String, Object> map) throws Exception;
	
	public List<MyPlant> myPlantListbyPlantNo(Map<String, Object> map) throws Exception;

	public void updateMyPlantExp(Map<String,Object> map) throws Exception;

}
