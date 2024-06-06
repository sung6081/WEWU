package life.wewu.web.controller.active;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.util.HashMap;
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
	@Qualifier("groupServiceImpl")
	GroupService groupService;
	
	//메소드
	//활동 등록 페이지 네비 GET
	@GetMapping(value = "addActive")
	public String addActive() {
		
		System.out.println("addActive NAVI");
		
		//모임장이 아니라면 모임신청으로 redirect
		
		return "/active/addActive.jsp";
		
	}
	
	//활동 등록 비즈니스 로직
	@PostMapping(value = "addActive")
	public String addActive(@ModelAttribute Active active, @RequestParam String hash, @RequestPart(required = false) MultipartFile file) throws Exception {
		
		System.out.println("addActive B/L");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("active", active);
		map.put("hash", hash);
		map.put("file", file);
		
		//활동 구역을 등록하고 이미지가 있다면 이미지까지 스토리지에 업로드 후 short url까지 받는다.
		activeService.addActive(map);
		
		return "foward:/active/listActive.jsp";
		
	}
	
	@GetMapping(value = "getActive/{activeNo}")
	public String getActive(@PathVariable int activeNo, Model model) throws Exception {
		
		System.out.println("getActive");
		
		//activeNo로 active받아서 model에 담고 foward
		model.addAttribute("active", activeService.getActive(activeNo));
		
		return "foward:/active/getActive.jsp";
	}
	
	@GetMapping(value = "updateActive")
	public String updateActive() {
		
		System.out.println("updateActive Navi");
		
		return "foward:/active/updateActive.jsp";
		
	}
	
	@PostMapping(value = "updateActive")
	public String updateActive(@ModelAttribute Active active, @RequestParam String hash, @RequestPart MultipartFile file) throws Exception {
		
		System.out.println("updateActive B/L");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("active", active);
		map.put("hash", hash);
		map.put("file", file);
		
		activeService.updateActive(map);
		
		return "foward:/active/getActive/"+active.getActiveNo();
	}
	
	@GetMapping(value = "listActive")
	public String getActiveList(Model model, @RequestParam int groupNo) throws Exception {
	
		System.out.println("listActive");
		
		Search search = new Search();
		
		search.setCurrentPage(1);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("groupNo", new Integer(groupNo));
		
		model.addAttribute("list", activeService.getGroupActiveList(map));
		
		return "foward:/active/listActive.jsp";
		
	}
	
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
		
		return "foward:/active/listActive.jsp";
		
	}
	
	@GetMapping(value = "activeMap")
	public String activeMap(Model model) throws Exception {
		
		System.out.println("activeMap");
		
		//그룹 리스트(T) => 개설완료건만
		Search search = new Search();
		search.setSearchCondition("T");
		search.setCurrentPage(1);
		
		model.addAttribute("groupList", groupService.getGroupList(search));
		
		//활동 리스트
		model.addAttribute("activeList", activeService.getActiveList(search));
		
		return "";
		
	}

}














