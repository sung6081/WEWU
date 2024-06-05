package life.wewu.web.controller.active;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
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

import life.wewu.web.domain.active.Active;
import life.wewu.web.repository.S3Repository;
import life.wewu.web.service.active.ActiveService;

@Controller
@RequestMapping("/active/*")
public class ActiveController {
	
	//필드
	@Autowired
	@Qualifier("activeServiceImpl")
	ActiveService activeService;
	
	@Value("${short.clientId}")
	private String clientId;
	
	@Value("$"
			+ "{short.clientSecret}")
	private String clientSecret;
	
	//메소드
	//활동 등록 페이지 네비 GET
	@RequestMapping(value="addActive", method=RequestMethod.GET)
	public ModelAndView addActive() {
		
		System.out.println("addActive NAVI");
		
		//모임장이 아니라면 모임신청으로 redirect
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/active/addActive.jsp");
		
		return modelAndView;
		
	}
	
	//활동 등록 비즈니스 로직
	@RequestMapping(value="addActive", method=RequestMethod.POST)
	public ModelAndView addActive(@ModelAttribute Active active, @RequestParam String hash, @RequestPart(required = false) MultipartFile file) throws Exception {
		
		System.out.println("addActive BL");
		
		ModelAndView modelAndView = new ModelAndView();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("active", active);
		map.put("hash", hash);
		map.put("file", file);
		
		activeService.addActive(map);
		
		return modelAndView;
		
	}

}














