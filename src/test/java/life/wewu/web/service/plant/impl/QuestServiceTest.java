package life.wewu.web.service.plant.impl;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import java.sql.Date;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import life.wewu.web.common.Search;

import life.wewu.web.domain.plant.Quest;
import life.wewu.web.service.plant.PlantService;


@SpringBootTest
public class QuestServiceTest {

	@Autowired
	@Qualifier("plantServiceImpl")
	private PlantService plantService;
	
    //@Test
    public void testAddQuest() throws Exception {
		System.out.println("addQuest");
		
		Date date = new Date(new java.util.Date().getDate());
		
		Quest quest = Quest.builder()
				.questContents("tt퀘스트내용")
				.questTarget("퀘스트목표")
				.questReward(1)
				.questTargetCnt(2)
				.questRegDate(date)
				.questState("N")
				.build();
		
		plantService.addQuest(quest);
    }

    //@Test
    public void testDeleteQuest() throws Exception {
        System.out.println("============");
        
        Quest quest = plantService.getQuest(1);
        
        System.out.println("==============");
    }

    @Test
    public void testUpdateQuest() throws Exception {
        System.out.println("=============");
        
        Quest quest = plantService.getQuest(1);
        
        quest.setQuestContents("야호오");

        plantService.updateQuest(quest);
        
        System.out.println("quest :"+quest);

        System.out.println("=============");
    }

   // @Test
    public void testGetQuestList() throws Exception {
        System.out.println("=============");

        Search search = new Search();
        search.setCurrentPage(1);

        Map<String, Object> questList = plantService.getQuestList(search);
        assertNotNull(questList, "The quest list should not be null");

        System.out.println("Quest List: " + questList);
        System.out.println("=============");
    }

    //@Test
    public void testCompleteQuest() throws Exception {
        System.out.println("=============");

        int questNo = 1; // Assuming this questNo exists
        plantService.completeQuest(questNo);

        Quest completedQuest = (Quest) plantService.getQuestList(new Search()).get(0); // Assuming getQuestList returns a List

        System.out.println("Quest completed: " + completedQuest);
        System.out.println("=============");
    }

    asdfasdfasdfadf
		
	
}
	
	
	