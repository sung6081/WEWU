package life.wewu.web.controller.plant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import life.wewu.web.domain.plant.Plant;
import life.wewu.web.domain.plant.Quest;
import life.wewu.web.service.plant.PlantService;

@Controller
@RequestMapping("/plant/")
public class PlantController {
	
	@Autowired
	@Qualifier("plantServiceImpl")
	private PlantService plantService;
	
	public PlantController() {
		System.out.println(this.getClass());
	}
	
	//----------------Quest
	
	
	@RequestMapping(value ="addQuest" , method = RequestMethod.POST)
	public String addQuest(@ModelAttribute("quest") Quest quest, Model model ) throws Exception{
		
		System.out.println(" /plant/addQuest : POST ");
		
		plantService.addQuest(quest);
		
		model.addAttribute("quest", quest);
		
		return "foward:/plant/addQuest.jsp";
		
	}
	
	@RequestMapping(value ="")
	public void deleteQuest() throws Exception{
		
	}
	@RequestMapping(value ="")
	public String updateQuest(@RequestParam("questNo") int questNo , Model model) throws Exception{
		
		System.out.println(" /plant/updateQuest : POST ");
		
		Quest quest = plantService.getQuest(questNo);
		
		model.addAttribute("quest", quest);
		
		return "foward:/plant/updatequest.jsp";
		
	}
	@RequestMapping(value ="")
	public void getQuest() throws Exception{
		
	}
	@RequestMapping(value ="")
	public void getQuestList() throws Exception{
		
	}
	
	@RequestMapping(value ="")
	public void completeQuest() throws Exception{
		
	}
	
	//----------------Plant

}
