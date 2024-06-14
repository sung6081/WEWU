package life.wewu.web.controller.active;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import life.wewu.web.common.Search;
import life.wewu.web.domain.active.Active;
import life.wewu.web.domain.group.Group;
import life.wewu.web.service.active.ActiveService;
import life.wewu.web.service.group.GroupService;

@RestController
@RequestMapping(value = "/app/active/*")
public class ActiveRestController {

	//�ʵ�
	@Autowired
	@Qualifier(value = "activeServiceImpl")
	ActiveService activeService;
	
	@Autowired
	@Qualifier(value = "groupService")
	GroupService groupService;
	
	//�޼ҵ�
	//rest active �˻�
	@PostMapping(value = "listActive")
	public List<Active> getActiveList(@RequestBody Search search) throws Exception {
		
		System.out.println("getActiveList");
		System.out.println("");
		
		return activeService.getActiveList(search);
		
	}
	
	//������ Ȱ�� ��� ������
	@PostMapping(value = "listGroupActive")
	public List<Active> getGroupActiveList(@RequestBody Search search, @RequestParam int groupNo) throws Exception {
		
		System.out.println("getGroupActiveList");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("groupNo", new Integer(groupNo));
		
		return activeService.getGroupActiveList(map);
	}
	
	//rest group ������, �˻�
	@PostMapping(value = "listGroup")
	public List<Group> getGroupList(@RequestBody Search search) throws Exception {
		
		System.out.println("getGroupList");
		
		search.setSearchCondition("T");
		
		return groupService.getGroupList(search);
		
	}
	
	//Ȱ���� ����
	@GetMapping(value = "getActive/{activeNo}")
	public Active getActive(@PathVariable int activeNo) throws Exception {
		
		System.out.println("getActive");
		
		return activeService.getActive(activeNo);
		
	}
	
	//���� ����
	@GetMapping(value = "getGroup/{groupNo}")
	public Group getGroup(@PathVariable int groupNo) throws Exception {
		
		System.out.println("getGroup");
		
		return groupService.getGroup(groupNo);
	}
	
}
