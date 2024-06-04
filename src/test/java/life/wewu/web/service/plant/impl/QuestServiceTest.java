package life.wewu.web.service.plant.impl;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import life.wewu.web.domain.plant.Plant;
import life.wewu.web.service.plant.PlantService;

@Transactional
@SpringBootTest
public class QuestServiceTest {

	@Autowired
	@Qualifier("plantService")
	private PlantService plantService;
	
	//@Test
	public void testAddPlant() throws Exception{
		System.out.println("============");
		
		Plant plant = Plant.builder()
				.plantNo(1)
				.plantName("빨간열매나무")
				.plantMinExp(0)
				.plantMaxExp(10)
				.plantLevl("새싹")
				.plantImg("빨간열매나무1단계.jpg")
				.build();
		
		System.out.println(plant);
		
		System.out.println("=============");
		
	}
	
	//@Test
	public void testGetPlant() throws Exception{
		System.out.println("=============");
		
		Plant plant = plantService.getPlant(1);
		
		System.out.println("=============");
	}
	
	//@Test
	public void deletePlant() throws Exception{
		
	}
	
	//@Test
	public void updatePlant() throws Exception{
		
		Plant plant = 
		plant.setPlantName("")
			
	}
	
	
	
	
}
