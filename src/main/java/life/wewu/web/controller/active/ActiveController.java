package life.wewu.web.controller.active;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.AmazonS3Exception;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

import life.wewu.web.common.Search;
import life.wewu.web.domain.active.Active;
import life.wewu.web.repository.S3Repository;
import life.wewu.web.service.active.ActiveService;
import life.wewu.web.service.group.GroupService;

import org.springframework.web.bind.annotation.RequestBody;


@Controller
@RequestMapping("/active/*")
public class ActiveController {
	
	//필드
	@Autowired
	@Qualifier("activeServiceImpl")
	ActiveService activeService;
	
	@Autowired
	@Qualifier("groupService")
	GroupService groupService;
	
	//메소드
	//활동 등록 페이지 네비 GET
	@GetMapping(value = "addActive/{groupNo}")
	public String addActive(@PathVariable int groupNo) {
		
		System.out.println("addActive NAVI");
		
		//모임장이 아니라면 모임신청으로 redirect
		
		return "forward:/active/addActive.jsp?groupNo="+groupNo;
		
	}
	
	//활동 등록 비즈니스 로직
	@PostMapping(value = "addActive")
	public String addActive(@ModelAttribute Active active, @RequestParam String hash, @RequestPart(required = false) MultipartFile file) throws Exception {
		
		System.out.println("addActive B/L");
		
//		if(file == null || file.isEmpty()) {
//			System.out.println("file null");
//		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("active", active);
		map.put("hash", hash);
		map.put("file", file);
		
		//활동 구역을 등록하고 이미지가 있다면 이미지까지 스토리지에 업로드 후 short url까지 받는다.
		activeService.addActive(map);
		
		return "forward:/active/listActive";
		
	}
	
	//활동 상세 조회
	@GetMapping(value = "getActive/{activeNo}")
	public String getActive(@PathVariable int activeNo, Model model) throws Exception {
		
		System.out.println("getActive");
		
		//activeNo로 active받아서 model에 담고 foward
		model.addAttribute("active", activeService.getActive(activeNo));
		
		return "forward:/active/getActive.jsp";
	}
	
	//활동 업데이트 Navi
	@GetMapping(value = "updateActive/{activeNo}")
	public String updateActive(Model model, @PathVariable int activeNo) {
		
		System.out.println("updateActive Navi");
		
		model.addAttribute("active", activeService.getActive(activeNo));
		
		return "forward:/active/updateActive.jsp";
		
	}
	
	//활동 업데이트 B/L
	@PostMapping(value = "updateActive")
	public String updateActive(@ModelAttribute Active active, @RequestParam String hash, @RequestPart(required = false) MultipartFile file) throws Exception {
		
		System.out.println("updateActive B/L");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("active", active);
		map.put("hash", hash);
		map.put("file", file);
		
		//업데이트 실행
		activeService.updateActive(map);
		
		System.out.println("updateActive B/L End");
		
		return "redirect:/active/getActive/"+active.getActiveNo();
	}
	
	@GetMapping(value = "deleteActive/{activeNo}")
	public String deleteActive(@PathVariable int activeNo) throws Exception {
		
		System.out.println("deleteActive B/L");
		
		activeService.deleteActive(activeNo);
		
		return "forward:/active/listActive";
		
	}
	
	//모임 활동 조회(첫 방문시)
	@GetMapping(value = "listActive")
	public String getActiveList(Model model, @RequestParam int groupNo) throws Exception {
	
		System.out.println("listActive");
		
		Search search = new Search();
		
		search.setCurrentPage(1);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("groupNo", new Integer(groupNo));
		
		List<Active> list = activeService.getGroupActiveList(map);
		
		model.addAttribute("list", list);
		
		return "forward:/active/listActive.jsp";
		
	}
	
	//모임 활동 목록 조회(다음 페이지 이동, 검색)
	@PostMapping(value = "listActive")
	public String getActiveList(Model model, @ModelAttribute Search search, @RequestParam int groupNo) throws Exception {
		
		System.out.println("listActive");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("groupNo", new Integer(groupNo));
		
		model.addAttribute("list", activeService.getGroupActiveList(map));
		
		return "forward:/active/listActive.jsp";
		
	}
	
	//모임 활동 지도
	@GetMapping(value = "activeMap")
	public String activeMap(Model model) throws Exception {
		
		System.out.println("activeMap");
		
		//그룹 리스트(T) => 개설완료건만
		Search search = new Search();
		search.setSearchCondition("T");
		search.setCurrentPage(1);
		
		model.addAttribute("groupList", groupService.getGroupList(search));
		
		//활동 리스트(전체)
		model.addAttribute("activeList", activeService.getActiveList(search));
		
		return "forward:/active/activeMap.jsp";
		
	}

}