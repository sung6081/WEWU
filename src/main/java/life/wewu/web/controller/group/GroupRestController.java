/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 */
package life.wewu.web.controller.group;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.aspectj.apache.bcel.classfile.Module.Require;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JacksonInject;
import com.fasterxml.jackson.annotation.JsonProperty;

import life.wewu.web.common.Search;
import life.wewu.web.domain.group.Group;
import life.wewu.web.domain.group.GroupMember;
import life.wewu.web.service.group.GroupService;

@RestController
@RequestMapping("/app/group/*")
public class GroupRestController {

	///필드
	@Autowired
	@Qualifier("groupService")
	private GroupService groupService;
	
	public GroupRestController()
	{
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="getGroupList",method = RequestMethod.POST)
	public List<Group> getGroupList(@RequestBody Search search) throws Exception 
	{
		System.out.println(":: /app/group/getGroupList ::");
		System.out.println(search);
		System.out.println("return Data :: " + groupService.getGroupList(search));
		// Business logic 수행
		return groupService.getGroupList(search);
	}
	
	@RequestMapping(value="getGroupRankingList",method = RequestMethod.POST)
	public List<Group> getGroupRankingList(@RequestBody Search search) throws Exception 
	{
		System.out.println(":: /app/group/getGroupRankingList ::");
		System.out.println(search);
		System.out.println("return Data :: " + groupService.getGroupRankingList(search));
		// Business logic 수행
		return groupService.getGroupRankingList(search);
	}
	
	@RequestMapping(value="getApplJoinList",method = RequestMethod.POST)
	public List<GroupMember> getApplJoinList(@RequestBody Search search) throws Exception 
	{
		System.out.println(":: /app/group/getApplJoinList ::");
		System.out.println(search);
		// Business logic 수행
		return groupService.getApplJoinList(search);
	}
	
	@RequestMapping(value="updateGroupRslt",method = RequestMethod.POST)
	public Group updateGroupRslt(@RequestBody Group group) throws Exception 
	{
		System.out.println(":: /app/group/updateGroupRslt ::");
		
		// Business logic 수행
		return groupService.updateGroupRslt(group);
	}
	
	@RequestMapping(value="getMemberGroupList",method = RequestMethod.POST)
	public List<GroupMember> getMemberGroupList(@RequestBody Map<String, Object> requestData) throws Exception 
	{
		System.out.println(":: /app/group/getMemberGroupList ::");
		
		String searchCondition = (String) requestData.get("searchCondition");
	    String searchKeyword = (String) requestData.get("searchKeyword");
	    
		Search search = new Search();
		search.setSearchKeyword(searchCondition);
		search.setSearchKeyword(searchKeyword);
		
		// Business logic 수행
		return groupService.getMemberGroupList(search);
	}
	
	@RequestMapping(value="getScrab",method = RequestMethod.POST)
	public String getScrab(@RequestBody Map<String, Object> requestData) throws Exception 
	{
		System.out.println(":: /app/group/getScrab ::");
		
		int memberNo = (int)requestData.get("memberNo");;
		
		// Business logic 수행
		return groupService.getScrab(memberNo);
	}
	
	@RequestMapping(value="updateScrab",method = RequestMethod.POST)
	public GroupMember updateScrab(@RequestBody GroupMember groupMember) throws Exception 
	{
		System.out.println(":: /app/group/updateScrab ::");
		
		// Business logic 수행
		return groupService.updateScrab(groupMember);
	}
	
	@RequestMapping(value="updateGroup",method = RequestMethod.POST)
	public Group updateGroup(Group group) throws Exception 
	{
		System.out.println(":: /app/group/updateGroup ::");
		
		// Business logic 수행
		group = groupService.updateGroup(group);
		
		return group;
	}
	
}
