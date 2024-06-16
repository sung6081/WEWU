package life.wewu.web.service.active.impl;

import java.io.File;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import life.wewu.web.common.Search;
import life.wewu.web.domain.active.Active;
import life.wewu.web.service.active.ActiveService;

@SpringBootTest
public class ActiveServiceTest {

	//필드
	@Autowired
	@Qualifier("activeServiceImpl")
	private ActiveService activeService;
	
	//메소드
	
	//등록 테스트
	//@Test
//	public void testAddActive() {
//		
//		System.out.println("addActive");
//		
//		Date date = new Date(new java.util.Date().getDate());
//		
//		Active active = Active.builder()
//				.groupNo(1)
//				.activeName("도봉산 쓰레기 줍기")
//				.activeStartDate(date)
//				.activeEndDate(date)
//				.activeX("37.5679981")
//				.activeY("126.9812957")
//				.activeStartTime("13:00:00")
//				.activeEndTime("15:00:00")
//				.activeInfo("쓰레기 봉투는 각자 가져오기!")
//				.activeLocal("도봉")
//				.stateFlag("N")
//				.activeUrl("https://kr.object.ncloudstorage.com/wewu-project-test/hun_balnom.jpg")
//				.activeShortUrl("https://me2.do/Fu6RPnkN")
//				.build();
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("active", active);
//		map.put("hash", "도봉산,플로깅,쓰레기 줍기");
//		
//		activeService.addActive(map);
//		
//	}
	
	//등록 테스트 (+파일 업로드 + short url)
	//@Test
	public void testAddActive() {
		
		System.out.println("addActive");
		
		Date date = new Date(new java.util.Date().getDate());
		
		// 프로젝트의 루트 디렉터리 경로를 얻음
        String projectRoot = System.getProperty("user.dir");
        
        // static/images 디렉터리 아래의 파일 경로 생성
        String relativePath = "/src/main/resources/static/images/wingGundam1.png";
        String absolutePath = projectRoot + relativePath;
		
        // File 객체 생성
        File file = new File(absolutePath);
		
		Active active = Active.builder()
				.groupNo(1)
				.activeName("도봉산 쓰레기 줍기")
				.activeStartDate(date)
				.activeEndDate(date)
				.activeX("37.5679981")
				.activeY("126.9812957")
				.activeStartTime("13:00:00")
				.activeEndTime("15:00:00")
				.activeInfo("쓰레기 봉투는 각자 가져오기!")
				.activeLocal("도봉")
				.stateFlag("N")
				.build();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("active", active);
		map.put("hash", "도봉산,플로깅,쓰레기 줍기");
		map.put("uploadFile", file);
		
		activeService.addActive(map);
		
	}
	
	//조회 테스트
	//@Test
	public void testGetActive() {
		
		System.out.println("getActive");
		
		Active active = activeService.getActive(3);
		
		System.out.println("getActive Done");
		
		System.out.println(active);
		
	}
	
	//업데이트 테스트
	//@Test
	public void testUpdateActive() {
		
		System.out.println("updateActive");
		
		System.out.println("업데이트 전");
		
		Active active = activeService.getActive(3);
		
		System.out.println(active);
		
		active.setActiveName("도봉산 플로깅");
		active.setActiveStartTime("10:00:00");
		active.setActiveEndTime("12:00:00");
		active.setActiveInfo("플로깅 합시다");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("active", active);
		//map.put("hash", "도봉산,플로깅,쓰레기 줍기");
		map.put("hash", "도봉산, 플로깅");
		
		activeService.updateActive(map);
		
		System.out.println();
		System.out.println("update 완료");
		active = activeService.getActive(3);
		System.out.println(active);
		
	}
	
	//삭제 테스트
	//@Test
	public void testDeleteActive() {
		
		System.out.println("deleteActive");
		
		System.out.println("delete 전");
		
		Active active = activeService.getActive(36);
		
		System.out.println();
		
		activeService.deleteActive(36);
		
		System.out.println("delete 후");
		
		active = activeService.getActive(36);
		
		System.out.println(active);
		
	}
	
	//목록 조회 테스트
	//@Test
	public void testGetActiveList() {
		
		System.out.println("getActiveList");
		
		Search search = new Search();
		
		search.setCurrentPage(1);
		//search.setCurrentPage(2);
		
		//search.setSearchKeyword("도봉");
		
		List<Active> list = activeService.getActiveList(search);
		
		for(Active record : list) {
			
			System.out.println("record : "+record);
			
		}
		
	}
	
	//모임 활동 목록 조회 테스트
	//@Test
	public void testGetGroupActiveList() {
		
		System.out.println("getActiveList");
		
		Search search = new Search();
		
		//search.setCurrentPage(1);
		search.setCurrentPage(2);
		
		//search.setSearchKeyword("도봉");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("groupNo", new Integer(1));
		
		List<Active> list = activeService.getGroupActiveList(map);
		
		System.out.println("length : " + list.size());
		
		for(Active record : list) {
			
			System.out.println("record : "+record);
			
		}
		
	}
	
}