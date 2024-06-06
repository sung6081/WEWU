package life.wewu.web.controller.active;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import life.wewu.web.common.Search;
import life.wewu.web.domain.active.Active;
import life.wewu.web.domain.group.Group;
import life.wewu.web.service.active.ActiveService;
import life.wewu.web.service.group.GroupService;

@RestController
@RequestMapping(value = "/app/active/*")
public class ActiveRestController {

	//필드
	@Autowired
	@Qualifier(value = "activeServiceImpl")
	ActiveService activeService;
	
	@Autowired
	@Qualifier(value = "groupServiceImpl")
	GroupService groupService;
	
	//메소드
	//rest active 검색
	@PostMapping(value = "getActiveList")
	public List<Active> getActiveList(@ModelAttribute Search search) throws Exception {
		
		System.out.println("getActiveList");
		
		return activeService.getActiveList(search);
		
	}
	
	//rest group 더보기, 검색
	@PostMapping(value = "getGroupList")
	public List<Group> getGroupList(@ModelAttribute Search search) throws Exception {
		
		System.out.println("getGroupList");
		
		search.setSearchCondition("T");
		
		return groupService.getGroupList(search);
		
	}
	
}
