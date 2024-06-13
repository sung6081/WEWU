package life.wewu.web.controller.plant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import life.wewu.web.domain.plant.Inventory;
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Quest;
import life.wewu.web.service.plant.PlantDao;
import life.wewu.web.service.plant.PlantService;


@RestController
@RequestMapping("/plant/")
public class PlantRestController {
	
	@Autowired
	@Qualifier("plantServiceImpl")
	private PlantService plantService;
	
	public PlantRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value ="/json/completeQuest" , method = RequestMethod.POST)
	public Quest completeQuest(@RequestBody Quest quest , Model model) throws Exception{
		System.out.println("/completeQuest");
		
		int questNo = quest.getQuestNo();
		quest.setQuestNo(questNo);
		
		plantService.completeQuest(quest);

		return quest;
	}
	
	@RequestMapping(value ="/json/deleteQuest")
	public Quest deleteQuest(@RequestBody Quest quest , Model model ) throws Exception{
		System.out.println(" /plant/deleteQuest : POST ");		
		plantService.addQuest(quest);		
		model.addAttribute("quest", quest);
		
		return quest;
	}
	
	
	
	@RequestMapping(value ="/json/deletePlant" , method = RequestMethod.POST)
	public String deletePlant(@RequestParam("plantNo") int plantNo , Model model) throws Exception{
		System.out.println(" /plant/deletePlant : POST ");		
		plantService.deletePlant(plantNo);
		
		return "redirect:/plant/getPlantList.jsp"; //<< 고민중
	
	}
	
	//REST로
	@RequestMapping(value ="getUseItem" , method = RequestMethod.POST)
	public String getUseItem(@RequestParam("MyPlantNo") int MyPlantNo,@RequestParam("itemPurNo") int itemPurNo,Model model) throws Exception{
		MyPlant myPlant = plantService.getMyPlant(MyPlantNo);
		Inventory inventory = plantService.getInventory(itemPurNo);
		
		model.addAttribute("myPlant", myPlant);
		model.addAttribute("inventory", inventory);
		return "plant/Inventory.jsp";
		
	}
	
	@RequestMapping(value="updateMyPlant", method = RequestMethod.POST)
	public MyPlant updateMyPlant(@RequestBody MyPlant myPlant) throws Exception{
		
		System.out.println("/plant/updateMyPlant");
		plantService.updateMyPlant(myPlant);
		
		return myPlant;
	}
	
	

}
