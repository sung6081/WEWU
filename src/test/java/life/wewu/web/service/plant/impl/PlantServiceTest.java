package life.wewu.web.service.plant.impl;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.service.plant.PlantService;


@SpringBootTest
public class PlantServiceTest {

	@Autowired
	@Qualifier("plantServiceImpl")
	private PlantService plantService;
	
	//@Test
	public void testAddPlantName() throws Exception{
		System.out.println("============");
		
		Plant plant = Plant.builder()
				.plantNo(1)
				.plantName("빨간열매나무")
				.build();
		
		System.out.println(plant);
		
		System.out.println("=============");
		
	}
	
	//@Test
	public void testAddPlantLevl() throws Exception{
		System.out.println("============");
		
		Plant plant = Plant.builder()
				.plantNo(1)
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
		
		System.out.println(plant);
		
		System.out.println("=============");
	}
	
	//@Test
	public void deletePlant() throws Exception{
		Plant plant = plantService.getPlant(1);

        // 식물 객체가 존재하는지 확인합니다.
        assertNotNull(plant, "The plant should exist before deletion");

        // 식물 객체를 삭제합니다.
        plantService.deletePlant(1);

        // 삭제된 식물 객체가 더 이상 존재하지 않는지 확인합니다.
        Plant deletedPlant = plantService.getPlant(1);
        
        System.out.println(deletedPlant);
        assertNull(deletedPlant, "The plant should be deleted");
	}
	
	@Test
	public void updatePlant() throws Exception{
		
		System.out.println("===============");
		Plant plant = plantService.getPlant(1);
		plant.setPlantName("노란열매나무");	
		
		plantService.updatePlant(plant);
	    
		System.out.println(plant);
	    System.out.println("===============");
		
		
	}
}
	
	
	