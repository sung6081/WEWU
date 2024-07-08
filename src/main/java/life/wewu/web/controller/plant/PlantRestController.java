package life.wewu.web.controller.plant;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import life.wewu.web.common.Search;
import life.wewu.web.domain.plant.Inventory;
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.domain.plant.PlantLevl;
import life.wewu.web.domain.plant.PlantRequest;
import life.wewu.web.domain.plant.Quest;
import life.wewu.web.domain.plant.QuestState;
import life.wewu.web.domain.user.User;
import life.wewu.web.repository.S3Repository;
import life.wewu.web.service.group.GroupService;
import life.wewu.web.service.plant.PlantDao;
import life.wewu.web.service.plant.PlantService;




@RestController
@RequestMapping("/app/plant/")
public class PlantRestController {

	@Autowired
	@Qualifier("plantServiceImpl")
	private PlantService plantService;
	
	@Autowired
	@Qualifier("groupService")
	private GroupService groupService;

	@Value("${weather.api.key}")
	private String apiKey;

	@Autowired
	private RestTemplate restTemplate;

	@Autowired
	@Qualifier("s3RepositoryImpl")
	private S3Repository s3Repository;
	
	@Value("${pageUnit}") 
	int pageUnit;

	@Value("${pageSize}") 
	int pageSize;

	public PlantRestController() {
		System.out.println(this.getClass());
	}

	@RequestMapping(value = "addPlantName", method = RequestMethod.POST)
	public Map<String, Object> addPlant(@RequestPart("plant") Plant plant, Model model) throws Exception {
		System.out.println("::plant::REST::addPlantName : POST");
		plantService.addPlantName(plant);
		model.addAttribute("plant", plant);
		System.out.println("plant:" + plant);

		Map<String, Object> map = new HashMap<>();
		map.put("plantNo", plant.getPlantNo());

		return map;
	}

	@RequestMapping(value = "addPlantLevl", method = RequestMethod.POST)
	public PlantLevl addPlantLevel(@RequestPart("plantLevl") PlantLevl plantLevl,
			@RequestPart(required = false) MultipartFile file) throws Exception {

		System.out.println("::plant::REST::addPlantLevl : POST");

		Map<String, Object> map = new HashMap<>();

		System.out.println("PlantLevl: " + plantLevl.toString());

		if (file != null) {
			System.out.println("File: " + file.getOriginalFilename());
		} else {
			System.out.println("File is null");
		}

		if (file != null && !file.isEmpty()) {
			Map<String, Object> fileMap = new HashMap<>();
			fileMap.put("file", file);
			fileMap.put("folderName", "plant");

			try {
				String url = s3Repository.uplodaFile(fileMap);
				plantLevl.setLevlImg(s3Repository.getShortUrl(url));
			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception("File upload failed", e);
			}
		}

		plantService.addPlantLevl(plantLevl);
		map.put("plantLevl", plantLevl);

		return plantLevl;
	}
	
	@RequestMapping(value = "deletePlant")
	public Plant deleteplant(@RequestBody Plant plant, Model model) throws Exception {
		System.out.println("::plant::REST::deleteQuest : POST");
		plantService.deletePlant(plant.getPlantNo());
		model.addAttribute("plant", plant);

		return plant;
	}

	@RequestMapping(value = "updatePlant", method = RequestMethod.POST)
	public Map<String, Object> updatePlant(@RequestPart("plantRequest") PlantRequest plantRequest, Model model,
			@RequestPart(required = false) MultipartFile file) throws Exception {
		System.out.println("::plant::REST::updatePlant : POST");

		Plant plant = plantRequest.getPlant();
		PlantLevl plantLevl = plantRequest.getPlantLevl();

		if (file != null) {
			System.out.println("File: " + file.getOriginalFilename());
		} else {
			System.out.println("File is null");
		}

		if (file != null && !file.isEmpty()) {
			Map<String, Object> fileMap = new HashMap<>();
			fileMap.put("file", file);
			fileMap.put("folderName", "plant");

			try {
				String url = s3Repository.uplodaFile(fileMap);
				plantLevl.setLevlImg(s3Repository.getShortUrl(url));
			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception("File upload failed", e);
			}
		}

		Map<String, Object> map = new HashMap<>();
		plantService.updatePlant(plantRequest);

		System.out.println(plant);
		System.out.println(plantRequest);

		map.put("plant", plant);
		map.put("plantLevl", plantLevl);

		return map;
	}

	@RequestMapping(value = "getQuest", method = RequestMethod.POST)
	public Quest getQuest(@RequestParam("questNo") int questNo, HttpSession session , Model model) throws Exception {
		System.out.println("::plant::REST::getQuest : POST");

		// 세션에 퀘스트 정보 추가
		Quest quest = (Quest) session.getAttribute("quest");
		User user = (User) session.getAttribute("user");

		// 퀘스트 정보를 서비스에서 가져옴
//		Map<String,Object> map = new HashMap<>();
//		QuestState questState = plantService.getQuestState(map);
//		System.out.println("session questStage: "+quest);
//		// 세션에 퀘스트 정보 업데이트
		//session.setAttribute("questState", questState);
		
		model.addAttribute("quest", quest);
		model.addAttribute("user", user);

		return quest;
	}

	@RequestMapping(value = "getQuestList", method = RequestMethod.POST)
	public List<QuestState> getQuestList( Model model, HttpSession session)
			throws Exception {
	    System.out.println("::plant::REST::getQuestList : POST");

	    User user = (User) session.getAttribute("user");
	    Map<String, Object> map = new HashMap<>();

	    map.put("nickname", user.getNickname());
	    List<QuestState> list = plantService.getQuestListByUser(map);

	    model.addAttribute("list", list);
	    session.setAttribute("questStateList", list); // 세션에 questStateList 추가
	    System.out.println("getQuestListByUserRest : " + list);
	    
	    

	    return list;
	}
	

	@RequestMapping(value = "getQuestListByUser", method = RequestMethod.POST)
	public ResponseEntity<?> getQuestListByUser(HttpSession session) {
	    try {
	        System.out.println("::plant::REST::getQuestListByUser : POST");

	        User user = (User) session.getAttribute("user");
	        System.out.println("User: " + user);

	        if (user == null) {
	            throw new Exception("User not found in session");
	        }

	        Map<String, Object> map = new HashMap<>();
	        map.put("nickname", user.getNickname());
	      
	        List<QuestState> list = plantService.getQuestListByUser(map);
	        System.out.println("Quest List By User: " + list);
	        if (list.isEmpty()) {
	            System.out.println("No quest states found for the given user.");
	        }
	        
	        for (QuestState questState : list) {
	            map.put("questRegDate", questState.getQuest().getRegDate());
	            int acleCount = plantService.countBoardAfterQuestRegDate(user.getNickname(), questState.getQuest().getRegDate()); // acleCount 계산
	            System.out.println("countMap : "+map);
	            questState.setAcleCount(acleCount); // currentCnt 설정
	            System.out.println("현재작성한게시물수 : "+acleCount);
	        }

	        System.out.println("getQuestListByUserRest : " + list);

	        // 세션에 사이드바 데이터 저장
	        session.setAttribute("sidebarQuestList", list);

	        return ResponseEntity.ok(list); // JSON 형식으로 반환됩니다.
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
	    }
	}
	@RequestMapping(value = "completeQuest", method = RequestMethod.POST)
    public ResponseEntity<String> completeQuest(@RequestParam("questStateNo") int questStateNo) {
        System.out.println("::plant::REST::completeQuest : POST");
        System.out.println("questStateNo : " + questStateNo);

        try {
            plantService.completeAndupdateReward(questStateNo);
            return ResponseEntity.ok("Quest completion and reward update successful.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Quest completion failed.");
        }
    }
	@RequestMapping(value = "updateQuest", method = RequestMethod.POST)
	public Map<String, Object> updateQuest(@RequestBody Quest quest) throws Exception {
		System.out.println("::plant::REST::updateQuest : POST");

		Map<String, Object> map = new HashMap<>();
		plantService.updateQuest(quest);

		System.out.println(quest);

		map.put("quest", quest);

		return map;
	}

	@RequestMapping(value = "deleteQuest")
	public Quest deleteQuest(@RequestBody Quest quest, Model model) throws Exception {
		System.out.println("::plant::REST::deleteQuest : POST");
		plantService.addQuest(quest);
		model.addAttribute("quest", quest);

		return quest;
	}


	@RequestMapping(value = "getMyPlant", method = RequestMethod.POST)
	public MyPlant getMyPlant(HttpSession session, Model model) throws Exception {

		System.out.println("::plant::REST::getMyPlant : POST");

		User user = (User) session.getAttribute("user");

		MyPlant myPlant = plantService.getMyPlant(user.getNickname());
		PlantLevl plantLevl = plantService.getPlantLevl(myPlant.getPlantLevl().getPlantLevlNo());
		myPlant.setPlantLevl(plantLevl);

		System.out.println(myPlant);
		System.out.println(plantLevl);
		session.setAttribute("myPlant", myPlant);

		model.addAttribute("user", user);
		model.addAttribute("myPlant", myPlant);

		return myPlant;

	}

	@RequestMapping(value = "myPlantListbyPlantNo")
	public List<MyPlant> myPlantListbyPlantNo(HttpSession session
	                                           ,@RequestBody MyPlant myPlant) throws Exception {

	    System.out.println("::plant::REST::myPlantListbyPlantNo : POST");

	    User user = (User) session.getAttribute("user");
		plantService.getMyPlant(user.getNickname());
		int myPlantNo = myPlant.getMyPlantNo();
	    
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("myPlantNo", myPlantNo);
	    map.put("nickname", user.getNickname()); 

	    System.out.println("map = "+map);

	    List<MyPlant> list = plantService.myPlantListbyLevlNo(map);

	    System.out.println("List = " + list);

	    return list;
	}
	
	
	// history.jsp
	@RequestMapping(value = "history", method = RequestMethod.GET)
	public List<MyPlant> getMyPlantList(
			@RequestParam(value = "searchCondition", required = false) String searchCondition,
			@RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model,
			HttpSession session) throws Exception {
		System.out.println("::plant::REST::history : POST");

		User user = (User) session.getAttribute("user");

		Map<String, Object> map = new HashMap<String, Object>();
		Search search = new Search();
		search.setSearchCondition(searchCondition);
		search.setSearchKeyword(searchKeyword);
		map.put("search", search);
		map.put("nickname", user.getNickname());

		System.out.println("map = " + map);

		List<MyPlant> list = plantService.getMyPlantList(map);

		System.out.println("List = " + list);

		model.addAttribute("list", list);
		model.addAttribute("search", search);

		return list;
	}

	@RequestMapping(value = "deleteMyPlant", method = RequestMethod.POST)
	public MyPlant deleteMyPlant(@RequestBody PlantRequest plantRequest, Model model, HttpSession session)
	        throws Exception {
	    System.out.println("::plant::REST::deleteMyPlant : POST");

	    int plantNo = plantRequest.getPlantNo();
	    int myPlantNo = plantRequest.getMyPlantNo(); // myPlantNo 받아오기
	    MyPlant myPlant = new MyPlant();
	    myPlant.setPlantNo(plantNo);
	    myPlant.setMyPlantNo(myPlantNo); // myPlantNo 설정하기

	    User user = (User) session.getAttribute("user");
	    System.out.println("User: " + user);
	    plantService.getMyPlant(user.getNickname());
	    System.out.println(myPlant);

	    // myPlantNo를 사용하여 식물 삭제
	    Map<String, Object> params = new HashMap<>();
	    params.put("nickname", user.getNickname());
	    params.put("myPlantNo", myPlantNo);
	    plantService.deleteMyPlant(params);
	    
	    session.setAttribute("myPlant", myPlant);

	    model.addAttribute("myPlant", myPlant);
	    model.addAttribute("user", user.getNickname());
	    return myPlant;
	}
	@RequestMapping(value = "useItem", method = RequestMethod.POST)
	public Map<String, Object> useItem(@RequestBody Inventory inventory, HttpSession session, Model model) throws Exception {
	    System.out.println("::plant::REST::useItem : POST");
	    System.out.println("inventory : " + inventory);

	    plantService.updateInventory(inventory);
	    User user = (User) session.getAttribute("user");

	    // 현재 키우고 있는 식물을 가져오기
	    MyPlant myPlant = plantService.getMyPlant(user.getNickname());

	    // 현재 키우고 있는 식물이 있는 경우에만 설정
	    if (myPlant != null && "Y".equals(myPlant.getMyPlantState())) {
	        inventory.setMyPlant(myPlant);
	        System.out.println(":inventory myplant: " + inventory.getMyPlant());

	        plantService.UseItem(inventory);
	    } else {
	        System.out.println("현재 키우고 있는 식물이 없습니다.");
	    }

	    model.addAttribute("inventory", inventory);

	    Map<String, Object> map = new HashMap<>();
	    map.put("inventory", inventory);
	    map.put("user", user);

	    return map;
	}

	@RequestMapping(value = "saveMyPlant", method = RequestMethod.POST)
	public MyPlant addRandomPlant(HttpSession session, @RequestBody MyPlant myPlant,
								 Model model) throws Exception {
		System.out.println("::plant::REST::saveMyPlant : POST");

	    // 세션에서 사용자 정보를 가져옴
	    User user = (User) session.getAttribute("user");
	    
	    // 랜덤 식물 선택
	    Plant randomPlant = plantService.selectRandomPlant();
	    PlantLevl plantLevl = randomPlant.getPlantLevl();

	    System.out.println("User: " + user);
	    System.out.println("RandomPlant: " + randomPlant);

	    // 사용자 정보와 랜덤으로 선택된 식물 정보를 myPlant 객체에 설정
	    myPlant.setNickname(user.getNickname());
	    myPlant.setPlant(randomPlant);
	    myPlant.setPlantLevl(plantLevl);

	    // myPlant 객체를 데이터베이스에 저장
	    plantService.addMyPlant(myPlant);

	    System.out.println("myPlant : " + myPlant);

	    // myPlant 객체를 모델에 저장
	    session.setAttribute("myPlant", myPlant);
	    model.addAttribute("myPlant", myPlant);
	    model.addAttribute("user", user);

		return myPlant;
	}

	@RequestMapping(value = "updateMyPlant", method = RequestMethod.GET)
	public MyPlant updateMyPlant(@RequestParam("plantName") String plantName,
	                             @RequestParam("plantLevlNo") int plantLevlNo,
	                             @RequestParam("myPlantNo") int myPlantNo) throws Exception {

	    System.out.println("::plant::REST::updateMyPlant : GET");
	    
	    MyPlant myPlant = new MyPlant();
	    myPlant.setMyPlantName(plantName);
	    myPlant.setPlantLevlNo(plantLevlNo);
	    myPlant.setMyPlantNo(myPlantNo);
	    
	    plantService.updateMyPlant(myPlant);

	    return myPlant;
	}

	@RequestMapping(value = "selectRandomPlant", method = RequestMethod.POST)
	public Plant selectRandomPlant(HttpSession session, Model model) throws Exception {
		System.out.println("::plant::REST::selectRandomPlant : POST");
	    Plant plant = plantService.selectRandomPlant();
	    System.out.println("RandomPlant selected: " + plant);
	    return plant;
	}


}
