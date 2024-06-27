package life.wewu.web.controller.plant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.http.ResponseEntity;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.boot.configurationprocessor.json.JSONException;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;

import life.wewu.web.common.Search;
import life.wewu.web.domain.plant.Inventory;
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.domain.plant.PlantLevl;
import life.wewu.web.domain.plant.Quest;
import life.wewu.web.domain.user.User;
import life.wewu.web.repository.S3Repository;
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
	@RequestMapping(value ="addQuest" , method = RequestMethod.GET)
	public String addQuest() throws Exception{	
		System.out.println(" /plant/addQuest : GET ");	
		return "forward:/plant/addQuest.jsp";	
	}
	
	@RequestMapping(value ="addQuest" , method = RequestMethod.POST)
	public String addQuest(@ModelAttribute("quest") Quest quest, Model model ,HttpSession session) throws Exception{	
		System.out.println(" /plant/addQuest : POST ");	
		User user = (User) session.getAttribute("user");
		quest.setNickName(user.getNickname());
		plantService.addQuest(quest);		
		model.addAttribute("quest", quest);
		model.addAttribute("user", user);	
		
		return "forward:/plant/addQuest.jsp";	
	}
	
	@RequestMapping(value ="updateQuest" , method = RequestMethod.GET)
	public String GETupdateQuest(@RequestParam("questNo") int questNo, Model model) throws Exception{
		System.out.println(" /plant/updateQuest : GET ");
	
		Quest quest = plantService.getQuest(questNo);
		model.addAttribute("quest", quest);
		
		System.out.println(quest);

		return "forward:/plant/updateQuest.jsp";
	}
	

	

	@RequestMapping(value ="listQuest" , method = RequestMethod.GET)
	public String getQuestList(@ModelAttribute("search") Search search, Model model) throws Exception{
		
		Map<String,Object> map = plantService.getQuestList(search);
		
		model.addAttribute("map", map);
		model.addAttribute("search", search);
		
		System.out.println(map);
		
		return "forward:/plant/listQuest.jsp";
	}
	

	//----------------Plant
	
	@RequestMapping(value ="addPlant" , method = RequestMethod.GET)
	public String GetAddPlant() throws Exception{
		System.out.println(" /plant/addPlant : get ");	
		
		
		return "forward:/plant/addPlant.jsp";	
	}


	@RequestMapping(value ="getPlant" , method = RequestMethod.GET)
	public String getPlant(@RequestParam("plantNo") int plantNo , Model model) throws Exception{
		System.out.println(" /plant/getPlant : POST ");		
		Plant plant = plantService.getPlant(plantNo);
		model.addAttribute("plant", plant);
		
		return "forward:/plant/getPlant.jsp";
	}
	
	@RequestMapping(value ="listPlant" , method = RequestMethod.GET)
	public String getPlantList( Model model,@RequestParam Map<String, Object> map ) throws Exception{
		
		System.out.println(" /plant/listPlant : GET ");	 
		
		// plantService를 통해 Plant 리스트를 가져옴
	    List<Plant> list = plantService.getPlantList(map);
	    
	    // 가져온 Plant 리스트를 모델에 추가
	    model.addAttribute("list", list);
	    
	    // 디버깅을 위한 map 출력
	    System.out.println("plantList:"+list);
	    
	    // 모델에 map 추가
	    model.addAttribute("map", map);
	    model.addAttribute("list", list);
		
		return "forward:/plant/listPlant.jsp";
		
	}
	
	@RequestMapping(value ="updatePlant" , method = RequestMethod.GET)
	public String GETupdatePlant(@RequestParam("plantNo") int plantNo,@RequestParam(required = false) int plantLevlNo,
			 Model model) throws Exception{
		
		System.out.println(" /plant/updatePlant : GET ");
		
		Plant plant = plantService.getPlant(plantNo);
		PlantLevl PlantLevl = plantService.getPlantLevl(plantLevlNo);
		
		plant.setPlantLevl(PlantLevl);
		
		System.out.println(plant);
		System.out.println(PlantLevl);
		
		model.addAttribute("plant", plant);
		model.addAttribute("plantLevl", PlantLevl);
		
		return "forward:/plant/updatePlant.jsp";
	}
	
	
	//----------------MyPlant
	
	@RequestMapping(value ="selectRandomPlant" , method = RequestMethod.POST)
	public String selectRandomPlant(Model model) throws Exception{
		System.out.println(" /plant/selectRandomPlant : POST ");
		Plant plant = plantService.selectRandomPlant();
		model.addAttribute("plant", plant);
		
		return "forward:/plant/selectRandomPlant.jsp";
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
		
		return "forward:/plant/addRandomPlant.jsp";
	}
	
	//getMyPlant.jsp
	@RequestMapping(value ="getMyPlant" , method = RequestMethod.GET)
	public String getMyPlant( Model model,HttpSession session) throws Exception{
		System.out.println(" /plant/getMyPlant : GET ");
		
		User user = (User) session.getAttribute("user");
		
		MyPlant myPlant = plantService.getMyPlant(user.getNickname());
		PlantLevl plantLevl = plantService.getPlantLevl(myPlant.getPlantLevl().getPlantLevlNo());
		myPlant.setPlantLevl(plantLevl);
		
		System.out.println(myPlant);
		System.out.println(plantLevl);
		
		model.addAttribute("user", user);
		model.addAttribute("myPlant", myPlant);
	
		
		return "forward:/plant/getMyPlant.jsp";
	}
	
	//history.jsp
	@RequestMapping(value ="history" , method = RequestMethod.GET)
	public String getMyPlantList(@ModelAttribute("search") Search search, Model model, HttpSession session) throws Exception{
		System.out.println("/plant/history : GET");
		
		User user = (User) session.getAttribute("user");
		
		Map<String,Object> map = new HashMap<String,Object>();
		search.setSearchKeyword("past");
	
		map.put("search",search);
		map.put("nickname",user.getNickname());
		
		System.out.println("map = " + map);
		
		List<MyPlant> list = plantService.getMyPlantList(map);
		
		System.out.println("List = " +list);
		List<MyPlant> allList= new ArrayList<MyPlant>();
		
		for(MyPlant myPlant : list)
		{
			myPlant.setPlant(plantService.getPlant(myPlant.getPlant().getPlantNo()));
			myPlant.setPlantLevl(plantService.getPlantLevl(myPlant.getPlantLevl().getPlantLevlNo()));
			
			allList.add(myPlant);
		}
		
		 System.out.println("All List Size: " + allList.size());
		
		model.addAttribute("allList", allList);

		return "forward:/plant/history.jsp";
	}
	
	

	//----------------Inventory
	@RequestMapping(value ="inventory" , method = RequestMethod.GET)
	public String getInventory(
							HttpSession session,
							Model model) throws Exception{
		
		System.out.println(" /plant/getInventory : GET ");
	    User user = (User) session.getAttribute("user");
	    
	    if (user == null) {
	        throw new Exception("User not found in session");
	    }
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("nickname", user.getNickname());
	    
	    List<Inventory> list = plantService.getInventoryList(user.getNickname());
	    
	    MyPlant myPlant = plantService.getMyPlant(user.getNickname());
	    PlantLevl plantLevl = plantService.getPlantLevl(myPlant.getPlantLevl().getPlantLevlNo());
	    System.out.println(myPlant);
	    System.out.println(plantLevl);
	    
	    System.out.println("list: " + list);
	    
	    model.addAttribute("user", user);
	    model.addAttribute("list", list);
	    model.addAttribute("myPlant", myPlant);
	    model.addAttribute("plantLevl", plantLevl);

	    return "forward:/plant/inventory.jsp";

	}
}
	
	
	


