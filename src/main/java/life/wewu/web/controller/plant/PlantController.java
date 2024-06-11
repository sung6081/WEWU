package life.wewu.web.controller.plant;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import life.wewu.web.common.Search;
import life.wewu.web.domain.plant.Inventory;
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.domain.plant.PlantLevl;
import life.wewu.web.domain.plant.Quest;
import life.wewu.web.domain.user.User;
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
	@RequestMapping(value ="addQuest" )
	public String addQuest(@ModelAttribute("quest") Quest quest, Model model ,HttpSession session) throws Exception{	
		System.out.println(" /plant/addQuest : POST ");	
		
		User user = (User) session.getAttribute("user");
		quest.setNickName(user.getNickname());
		plantService.addQuest(quest);		
		model.addAttribute("quest", quest);
		model.addAttribute("user", user);
		
		return "forward:/plant/addQuest.jsp";	
	}
	
	@RequestMapping(value ="deleteQuest")
	public String deleteQuest(@ModelAttribute("quest") Quest quest, Model model ) throws Exception{
		System.out.println(" /plant/deleteQuest : POST ");		
		plantService.addQuest(quest);		
		model.addAttribute("quest", quest);
		
		return "redirect:/plant/listQuest.jsp";
	}
	
	//출력완료
	@RequestMapping(value ="updateQuest" , method = RequestMethod.POST)
	public String updateQuest(@ModelAttribute("quest") Quest quest, Model model) throws Exception{
		System.out.println(" /plant/updateQuest : POST ");	
		int questNo = quest.getQuestNo();
		plantService.updateQuest(quest);		
		model.addAttribute("quest", quest);	
		
		return "plant/getQuest?questNo="+questNo;
	}
	
	@RequestMapping(value ="getQuest" , method = RequestMethod.POST)
	public String getQuest(@RequestParam("questNo") int questNo , Model model) throws Exception{
		System.out.println(" /plant/getQuest : POST ");		
		Quest quest = plantService.getQuest(questNo);		
		model.addAttribute("quest", quest);	
		
		return "plant/getQuest.jsp";
		
	}
	@RequestMapping(value ="getQuestList" , method = RequestMethod.POST)
	public void getQuestList() throws Exception{
		Search search = new Search();
		Map<String,Object> questList = plantService.getQuestList(search);
		
	}
	
	@RequestMapping(value ="completeQuest" , method = RequestMethod.POST)
	public String completeQuest(@RequestParam("questNo")int questNo , Model model) throws Exception{
		System.out.println("/plant/completeQuuest : ");
		plantService.completeQuest(questNo);
		
		model.addAttribute("model", model);
		
		return "";
	}
	
	//----------------Plant

	@RequestMapping(value ="addPlant" )
	public String addPlant(@ModelAttribute("plant") Plant plant, @ModelAttribute("plantLevl") PlantLevl plantLevl ,Model model) throws Exception{
		System.out.println(" /plant/addPlant : POST ");		
		plantService.addPlant(plant, plantLevl);
		
		return "forward:/plant/addPlant.jsp";	
	}

	@RequestMapping(value ="getPlant" , method = RequestMethod.GET)
	public String getPlant(@RequestParam("plantNo") int plantNo , Model model) throws Exception{
		System.out.println(" /plant/getPlant : POST ");		
		Plant plant = plantService.getPlant(plantNo);
		model.addAttribute("plant", plant);
		
		return "plant/getPlant.jsp";
	}
	
	@RequestMapping(value ="listPlant" , method = RequestMethod.GET)
	public String getPlantList(@RequestParam("plantNo") int plantNo , Model model,@ModelAttribute("search") Search search) throws Exception{
		System.out.println(" /plant/listPlant : GET ");		
		Map<String,Object> map = plantService.getPlantList(search);
		
		model.addAttribute("map", map);
		model.addAttribute("search", search);
		
		return "forward:/plant/listPlant";
	}
	@RequestMapping(value ="deletePlant" , method = RequestMethod.POST)
	public String deletePlant(@RequestParam("plantNo") int plantNo , Model model) throws Exception{
		System.out.println(" /plant/deletePlant : POST ");		
		plantService.deletePlant(plantNo);
		
		return "redirect:/plant/getPlantList.jsp"; //<< 고민중
	
	}
	@RequestMapping(value ="updatePlant" , method = RequestMethod.POST)
	public String updatePlant(@ModelAttribute("plant") Plant plant) throws Exception{
		System.out.println(" /plant/updatePlant : POST ");		
		plantService.updatePlant(plant);
	
		return "plant/updatePlant.jsp";
	}
	
	//----------------MyPlant
	
	@RequestMapping(value ="selectRandomPlant" , method = RequestMethod.POST)
	public String selectRandomPlant(@RequestParam("plantNo") int plantNo) throws Exception{
		System.out.println(" /plant/selectRandomPlant : POST ");
		plantService.selectRandomPlant();
		//-> get으로 plantNo만 보내서 뽑아와야하나?
		return "plant/selectRandomPlant.jsp";
	}
	
	@RequestMapping(value ="addRandomPlant" , method = RequestMethod.POST)
	public String addRandomPlant(HttpServletRequest request, HttpSession session) throws Exception{
		System.out.println(" /plant/addRandomPlant : POST ");
		User user = (User) session.getAttribute("user");
		Plant plant = plantService.selectRandomPlant();
		MyPlant myPlant = new MyPlant();
		myPlant.setPlant(plant);
		myPlant.setNickname(request.getParameter("user"));
		myPlant.setMyPlantName(request.getParameter("myPlantName"));
		plantService.addRandomPlant(myPlant);
		
		return "plant/addRandomPlant.jsp";
	}
	
	@RequestMapping(value ="getMyPlant" , method = RequestMethod.GET)
	public String getMyPlant(@RequestParam("myPlantNo") int myPlantNo,Model model) throws Exception{
		System.out.println(" /plant/getMyPlant : GET ");
		MyPlant myPlant = plantService.getMyPlant(myPlantNo);
		
		model.addAttribute("myPlant", myPlant);
		
		return "forward:/plant/getMyPlant.jsp";
	}
	
	@RequestMapping(value ="getMyPlantList" , method = RequestMethod.POST)
	public List getMyPlantList() throws Exception{
		System.out.println("/plant/getMyPlantList");
		User user = new User();
		user.setNickname(null);
		
		Map<String,Object> map = new HashMap<String,Object>();
		Search search = new Search();
		search.setSearchKeyword("current");
		map.put("search",search);
		map.put("nickname",user.getNickname());
		
		List<MyPlant> list = plantService.getMyPlantList(map);
		List<MyPlant> allList= new ArrayList<MyPlant>();
		
		for(MyPlant m : list)
		{
			m.setPlant(plantService.getPlant(m.getPlant().getPlantNo()));
			m.setPlantLevl(plantService.getPlantLevl(m.getPlantLevl().getPlantLevlNo()));
			
			allList.add(m);
		}
		
		return null;
	}
	
//	@RequestMapping(value ="donateMyPlant" , method = RequestMethod.POST)
//	public String donateMyPlant(@RequestParam("MyPlantNo") int MyPlantNo,HttpSession session,Model model) throws Exception{
//		
//		System.out.println(" /plant/donateMyPlant : POST ");
//		User user = (User) session.getAttribute("user");
//		MyPlant myPlant = plantService.donateMyPlant(MyPlantNo,user.getNickname());
//		
//		model.addAttribute("myPlant", myPlant);
//		return null;
//	}
	
	@RequestMapping(value ="deleteMyPlant" , method = RequestMethod.POST)
	public String deleteMyPlant(@RequestParam("MyPlantNo") int MyPlantNo) throws Exception{
		System.out.println(" /plant/deleteMyPlant : POST ");
		MyPlant myPlant = plantService.deleteMyPlant(MyPlantNo);
		return null;
	}

	//----------------Inventory
	@RequestMapping(value ="getInventory" , method = RequestMethod.GET)
	public String getInventory(@RequestParam("itemPurNo") int itemPurNo,Model model) throws Exception{
		System.out.println(" /plant/getInventory : POST ");
		Inventory inventory = plantService.getInventory(itemPurNo);
		model.addAttribute("inventory", inventory);
		return "plant/Inventory.jsp";
		
	}
	@RequestMapping(value ="getUseItem" , method = RequestMethod.POST)
	public String getUseItem(@RequestParam("MyPlantNo") int MyPlantNo,@RequestParam("itemPurNo") int itemPurNo,Model model) throws Exception{
		MyPlant myPlant = plantService.getMyPlant(MyPlantNo);
		Inventory inventory = plantService.getInventory(itemPurNo);
		
		model.addAttribute("myPlant", myPlant);
		model.addAttribute("inventory", inventory);
		return "plant/Inventory.jsp";
		
	}
	
	//----------------etc
	

	@RequestMapping(value ="fileUpload" , method = RequestMethod.POST)
	public void fileUpload() throws Exception{
		
	}
	
	
	

}
