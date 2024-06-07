package life.wewu.web.service.plant.impl;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import life.wewu.web.common.Search;
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.service.plant.PlantService;


@SpringBootTest
public class MyPlantServiceTest {

	@Autowired
	@Qualifier("plantServiceImpl")
	private PlantService plantService;
	
    //@Test
    public void testSelectRandomPlant() throws Exception {
        System.out.println("============");

        MyPlant myPlant = plantService.selectRandomPlant("야호");
        
        // 식물 객체의 정보를 출력합니다.
        System.out.println("Selected Random Plant: " + myPlant);

        System.out.println("=============");
    }
	
    @Test
    public void testAddRandomPlant() {
    	
    	System.out.println("======");
        MyPlant myPlant = plantService.addRandomPlant("새로운 식물 이름");
        System.out.println(myPlant);
        System.out.println("======");
    }
    
    
	//@Test
	public void testUpdateMyPlant() throws Exception{
		System.out.println("=============");
		
		MyPlant myPlant = plantService.getMyPlant(1);
		myPlant.setMyPlantName("야호");
		
		plantService.updateMyPlant(myPlant);
		
		System.out.println(myPlant);
		
		System.out.println("=============");
	}
	
	//@Test
	public void testGetMyPlant() throws Exception{
		
		System.out.println("=============");
		
		MyPlant myPlant = plantService.getMyPlant(1);
		
		System.out.println("=============");
	}
	
    //@Test
    public void testGetMyPlantList() throws Exception {
        System.out.println("=========");

        Search search = new Search();
        search.setCurrentPage(1);

        Map<String, Object> map = plantService.getMyPlantList(search);
        assertNotNull(map, "The plant list should not be null");

        System.out.println("MyPlant List: " + map);
        System.out.println("=========");
    }

    //@Test
    public void testDeleteMyPlant() throws Exception {
        System.out.println("=========");

        plantService.deleteMyPlant(1);

        MyPlant myPlant = plantService.getMyPlant(1);
        assertNull(myPlant, "The myPlant object should be null after deletion");

        System.out.println("=========");
    }

   // @Test
    public void testUseItemAndExpIncrease() throws Exception {
        System.out.println("=========");

        plantService.useItemAndExpIncrease(1);

        MyPlant myPlant = plantService.getMyPlant(1);
        // 적절한 검증 로직 추가

        System.out.println("=========");
    }

    //@Test
    public void testFileUpload() throws Exception {
        System.out.println("=========");

        plantService.fileUpload("/path/to/file");

        // 적절한 검증 로직 추가

        System.out.println("=========");
    }

    //@Test
    public void testDonatePlant() throws Exception {
        System.out.println("=========");

        plantService.donatePlant(1, "donor_nickname");

        MyPlant myPlant = plantService.getMyPlant(1);
        // 적절한 검증 로직 추가

        System.out.println("=========");
    }
	
}
