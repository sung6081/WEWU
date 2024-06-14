package life.wewu.web.service.plant.impl;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.security.SecurityProperties.User;
import org.springframework.boot.test.context.SpringBootTest;

import life.wewu.web.common.Search;
import life.wewu.web.domain.plant.Inventory;
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.domain.plant.PlantLevl;
import life.wewu.web.domain.plant.Quest;
import life.wewu.web.service.plant.PlantService;


@SpringBootTest
public class PlantServiceTest {

	@Autowired
	@Qualifier("plantServiceImpl")
	private PlantService plantService;

   

	//@Test
	//check
	public void testAddPlantName() throws Exception{
        System.out.println("===============================");
		Plant plant = Plant.builder()
							.plantName("빨간열매나무")
							.build();
		plantService.addPlantName(plant);
		System.out.println(plant);
        System.out.println("===============================");
	}
	
	
	//@Test
	//check
	 public void testAddPlantLevl() throws Exception{
		System.out.println("============");
		Plant plant = plantService.getPlant(1);
		PlantLevl plantLevl = PlantLevl.builder()
				.plantNo(plant.getPlantNo())
				.plantMinExp(0)
				.plantMaxExp(9)
				.plantLevl("새싹")
				.plantFinalLevl("열매나무")
				.levlImg("빨간열매나무1단계.jpg")
				.build();	
		plantService.addPlantLevl(plantLevl);
		System.out.println(plantLevl);
		
		System.out.println("=============");
		
		}
	
	
	//@Test
	//check
	public void testGetPlant() throws Exception{
        System.out.println("===============================");
		Plant plant = plantService.getPlant(1);		
		System.out.println(plant);		
        System.out.println("===============================");
	}
	
	//@Test
	//check
	public void deletePlant() throws Exception{
        System.out.println("===============================");
		Plant plant = plantService.getPlant(1);
        plantService.deletePlant(1);
        Plant deletedPlant = plantService.getPlant(1);       
        System.out.println(deletedPlant);
        System.out.println("===============================");
	}
	
	//@Test
	//check
	public void updatePlant() throws Exception{
        System.out.println("===============================");
		Plant plant = plantService.getPlant(2);
		plant.setPlantName("노란열매나무");			
		plantService.updatePlant(plant);
		System.out.println(plant);
        System.out.println("===============================");	
	}
	//@Test
	//check
    public void testSelectRandomPlant() throws Exception {
        System.out.println("===============================");
        Plant plant = plantService.selectRandomPlant();
        System.out.println(plant);
        System.out.println("===============================");
    }	
	//@Test
	//check
    public void testAddRandomPlant() throws Exception {
    	
        System.out.println("===============================");	
    	Plant plant = plantService.selectRandomPlant();
    	System.out.println(plant);
    	
    	/* ============== 키운다면 ? ================ */
    	
    	MyPlant myPlant = new MyPlant();
    	myPlant.setMyPlantName("내 식물");
    	myPlant.setPlant(plant);
    	myPlant.setNickname("nick1");
    	
        plantService.addRandomPlant(myPlant);
      
        System.out.println(myPlant);
        
        System.out.println("===============================");	
    }
    
    
	//@Test
    //check
	public void testUpdateMyPlant() throws Exception{
        System.out.println("===============================");	
		MyPlant myPlant = plantService.getMyPlant(1);
		myPlant.setMyPlantName("야호1");		
		plantService.updateMyPlant(myPlant);		
		System.out.println(myPlant);		
        System.out.println("===============================");	
	}
	
	//@Test
	//check
	public void testGetMyPlant() throws Exception{		
        System.out.println("===============================");	
		MyPlant myPlant = plantService.getMyPlant(1);	
		myPlant = plantService.getMyPlant(myPlant.getMyPlantNo());
		myPlant.setPlant(plantService.getPlant(myPlant.getPlant().getPlantNo())); 
		myPlant.setPlantLevl(plantService.getPlantLevl(myPlant.getPlantLevl().getPlantLevlNo()));		
		System.out.println(myPlant);		
        System.out.println("===============================");	
	}
	
   // @Test
	//check
    public void testGetMyPlantList() throws Exception {
        System.out.println("===============================");	
        
        User user = new User();
        user.setName("nick1");
        
        Map<String,Object> map = new HashMap<String,Object>();
        Search search = new Search();
        search.setSearchKeyword("current");
        
        map.put("search", search);
        map.put("nickname", user.getName());
        
		List<MyPlant> list = plantService.getMyPlantList(map);
		List<MyPlant> test = new ArrayList<MyPlant>();
	
		for(MyPlant dd : list)
		{
			dd.setPlant(plantService.getPlant(dd.getPlant().getPlantNo())); 
			dd.setPlantLevl(plantService.getPlantLevl(dd.getPlantLevl().getPlantLevlNo()));	
			test.add(dd);
		}
		
		System.out.println(test);		
        
		System.out.println("===============================");
    }

    //@Test
    //check
    public void testDeleteMyPlant() throws Exception {
        System.out.println("===============================");	
        plantService.deleteMyPlant(1);
        MyPlant myPlant = plantService.getMyPlant(1);
        System.out.println(myPlant);
        System.out.println("===============================");	
    }

    //@Test
    public void testFileUpload() throws Exception {
        System.out.println("===============================");	
        plantService.fileUpload("/path/to/file");
        System.out.println("===============================");	
    }

//    //@Test
//    //check
//    public void testDonateMyPlant() throws Exception {
//        System.out.println("===============================");	
//        plantService.donateMyPlant(1, "donor_nickname");
//        MyPlant myPlant = plantService.getMyPlant(1);
//        System.out.println("===============================");	
//    }
//    
    @Test
	//check
    public void testAddQuest() throws Exception {
        System.out.println("===============================");	
		System.out.println("addQuest");	
		Quest quest = Quest.builder()
							.nickName("nick1")
							.questContents("tt퀘스트내용")
							.questTarget("퀘스트목표")
							.questReward(1)
							.questTargetCnt(2)
							.questState("N")
							.build();		
		plantService.addQuest(quest);
        System.out.println("===============================");	
    }

    //@Test
    //check
    public void testDeleteQuest() throws Exception {
        System.out.println("===============================");	 
        plantService.deletePlant(1);        
        System.out.println("===============================");	
    }

    //@Test
    //check
    public void testUpdateQuest() throws Exception {
        System.out.println("===============================");	       
        Quest quest = Quest.builder()
        					.questNo(1)
        					.questContents("메롱")
        					.questReward(3)
        					.questTarget("게시물")
        					.questTargetCnt(3)
        					.build();    
        plantService.updateQuest(quest);        
        System.out.println("quest :"+quest);
        System.out.println("===============================");	
    }
    
    //@Test
    //check
    public void testGetQuest() throws Exception {
    	System.out.println("===============================");
    	Quest quest = plantService.getQuest(1);
    	System.out.println(quest);
    	System.out.println("===============================");
    }
    	
    
    //@Test
    //check
    public void testGetQuestList() throws Exception {
        System.out.println("===============================");	
        Search search = new Search();
        Map<String, Object> questList = plantService.getQuestList(search);
        System.out.println("Quest List: " + questList);
        System.out.println("===============================");	
    }

    //@Test
    //check -> 검증하는 로직 의견 필요
    public void testCompleteQuest() throws Exception {
        System.out.println("===============================");	
        
        System.out.println("===============================");	
    }

    //@Test
    //check
    public void getInventory() throws Exception {
        System.out.println("===============================");	
        Inventory inventory = plantService.getInventory(1);
        System.out.println(inventory);
        System.out.println("===============================");
    }
    
    //@Test
    //check
    public void getUseItem() throws Exception {
        System.out.println("===============================");	
        
        plantService.getUseItem(1);
        MyPlant myPlant = plantService.getMyPlant(1);
        
        System.out.println(myPlant);
        System.out.println("===============================");	

    }
    
	
}
	
	
	