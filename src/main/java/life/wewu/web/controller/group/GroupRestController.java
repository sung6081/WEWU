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
import org.springframework.web.bind.annotation.RequestAttribute;
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
import life.wewu.web.domain.group.GroupAcle;
import life.wewu.web.domain.group.GroupBoard;
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
	public Group updateGroup(@RequestBody Group group) throws Exception 
	{
		System.out.println(":: /app/group/updateGroup ::");
		// Business logic 수행
		group = groupService.updateGroup(group);
		
		return group;
	}
	
	@RequestMapping(value="deleteGroup",method = RequestMethod.POST)
	public String deleteGroup(@RequestBody Map<String, Object> rslt) throws Exception 
	{
		System.out.println(":: /app/group/deleteGroup ::");
		// Business logic 수행
		String flag = "";
		int groupNo = Integer.parseInt((String)rslt.get("groupNo"));
		
		try {
			groupService.deleteGroup(groupNo);
			flag = "Y";
		}catch(Exception e)
		{
			System.out.println(e);
			flag = "N";
		}
		
		// JSON 형식의 응답 반환
        return "{\"flag\": \"" + flag + "\"}";
	}
	
	@RequestMapping(value="addApplGroup",method = RequestMethod.POST)
	public Group addApplGroup(@RequestBody Group group) throws Exception 
	{
		System.out.println(":: /app/group/addApplGroup ::");
		// Business logic 수행
		groupService.addGroup(group);
		System.out.println(group);
        return group;
	}
	
	@RequestMapping(value="updateApplGroup",method = RequestMethod.POST)
	public Group updateApplGroup(@RequestBody Group group) throws Exception 
	{
		System.out.println(":: /app/group/updateApplGroup ::");
		// Business logic 수행
		group = groupService.updateGroup(group);
        return group;
	}
	
	@RequestMapping(value="deleteApplGroup",method = RequestMethod.POST)
	public String deleteApplGroup(@RequestBody Map<String, Object> rslt) throws Exception 
	{
		System.out.println(":: /app/group/deleteApplGroup ::");
		// Business logic 수행
		String flag = "";
		int groupNo = Integer.parseInt((String)rslt.get("groupNo"));
		System.out.println(groupNo);
		
		try {
			groupService.deleteGroup(groupNo);
			flag = "Y";
		}catch(Exception e)
		{
			Throwable cause = e.getCause();

			if (cause.getMessage().contains("board_type")) {
			    System.out.println("모임에 생성된 게시판 있음");
			    flag = "board";
			} else if(cause.getMessage().contains("user")){
			    System.out.println("모임에 남은 모임원이 있음");
			    flag = "user";
			} else
			{
				flag = "N";
			}
			
		}
		
		// JSON 형식의 응답 반환
        return "{\"flag\": \"" + flag + "\"}";
	}
	
	@RequestMapping(value="addApplJoin",method = RequestMethod.POST)
	public GroupMember addApplJoin(@RequestBody GroupMember groupMember) throws Exception 
	{
		
		System.out.println(":: /group/addApplJoin ::");
		
		// Business logic 수행
		
		try {
			groupService.addMemberGroup(groupMember);
		}catch(Exception e)
		{
			Throwable cause = e.getCause();
			System.out.println(cause.getMessage());
			
		}
		// JSON 형식의 응답 반환
        return groupMember;
	}
	
	@RequestMapping(value="deleteApplJoin",method = RequestMethod.POST)
	public String deleteApplJoin(@RequestBody Map<String, Object> rslt) throws Exception 
	{
		System.out.println(":: /app/group/deleteApplJoin ::");
		// Business logic 수행
		String flag = "";
		int memberNo = Integer.parseInt((String)rslt.get("memberNo"));
		System.out.println(memberNo);
		
		try {
			groupService.deleteMemberGroup(memberNo);
			flag = "Y";
		}catch(Exception e)
		{
			Throwable cause = e.getCause();

		    System.out.println(cause);
			flag = "N";
		}
		
		// JSON 형식의 응답 반환
        return "{\"flag\": \"" + flag + "\"}";
	}
	
	@RequestMapping(value="updateApplJoin",method = RequestMethod.POST)
	public GroupMember updateApplJoin(@RequestBody GroupMember groupMember) throws Exception 
	{
		System.out.println(":: /app/group/updateApplJoin ::");
		// Business logic 수행
		groupMember = groupService.updateApplJoin(groupMember);
        return groupMember; 
	}
	
	@RequestMapping(value="updateApplJoinForm",method = RequestMethod.POST)
	public Group updateApplJoinForm(@RequestBody Group group) throws Exception 
	{
		System.out.println(":: /app/group/updateApplJoinForm ::");
		// Business logic 수행
		System.out.println(group.getGroupNo());
		System.out.println(group.getFrstQuest());
		group = groupService.updateGroup(group);
		
		return group;
	}
	
	@RequestMapping(value="addGroupBoard",method = RequestMethod.POST)
	public GroupBoard addGroupBoard(@RequestBody GroupBoard groupBoard) throws Exception 
	{
		System.out.println(":: /app/group/addGroupBoard ::");
		// Business logic 수행
		groupService.addGroupBoard(groupBoard);
		
		return groupBoard;
	}
	
	@RequestMapping(value="getGroupBoardList",method = RequestMethod.POST)
	public List<GroupBoard> getGroupBoardList(@RequestBody Map<String, Object> rslt) throws Exception 
	{
		System.out.println(":: /app/group/getGroupBoardList ::");
		
		int groupNo = Integer.parseInt((String)rslt.get("groupNo"));
		
		// Business logic 수행
		
		return groupService.getGroupBoardList(groupNo);
	}
	
	@RequestMapping(value="updateGroupBoard",method = RequestMethod.POST)
	public GroupBoard updateGroupBoard(@RequestBody GroupBoard groupBoard) throws Exception 
	{
		System.out.println(":: /app/group/updateGroupBoard ::");
		// Business logic 수행
		groupBoard = groupService.updateGroupBoard(groupBoard);
		
		return groupBoard;
	}
	
	@RequestMapping(value="deleteGroupBoard",method = RequestMethod.POST)
	public String deleteGroupBoard(@RequestBody Map<String, Object> rslt) throws Exception 
	{
		System.out.println(":: /app/group/deleteGroupBoard ::");
		// Business logic 수행
		String flag = "";
		int typeNo = Integer.parseInt((String)rslt.get("typeNo"));
		
		try {
			groupService.deleteGroupBoard(typeNo);
			flag = "Y";
		}catch(Exception e)
		{
			Throwable cause = e.getCause();

		    System.out.println(cause);
			flag = "N";
		}
		
		// JSON 형식의 응답 반환
        return "{\"flag\": \"" + flag + "\"}";
	}
	
	@RequestMapping(value="deleteMemberGroup",method = RequestMethod.POST)
	public String deleteMemberGroup(@RequestBody Map<String, Object> rslt) throws Exception 
	{
		System.out.println(":: /app/group/deleteGroupMember ::");
		// Business logic 수행
		String flag = "";
		int memberNo = Integer.parseInt((String)rslt.get("memberNo"));
		
		try {
			groupService.deleteMemberGroup(memberNo);
			flag = "Y";
		}catch(Exception e)
		{
			Throwable cause = e.getCause();

		    System.out.println(cause);
			flag = "N";
		}
		
		// JSON 형식의 응답 반환
        return "{\"flag\": \"" + flag + "\"}";
	}
	
	@RequestMapping(value="updateMemberGroup",method = RequestMethod.POST)
	public GroupMember updateMemberGroup(@RequestBody GroupMember groupMember) throws Exception 
	{
		System.out.println(":: /app/group/updateMemberGroup ::");
		System.out.println(groupMember);
		
		// Business logic 수행
		groupMember = groupService.updateMemberGroup(groupMember);
		
		return groupMember;
	}
	
	@RequestMapping(value="addGroupAcle",method = RequestMethod.POST)
	public GroupAcle addGroupAcle(@RequestBody GroupAcle groupAcle) throws Exception 
	{
		System.out.println(":: /app/group/addGroupAcle ::");
		System.out.println(groupAcle);
		// Business logic 수행
		groupAcle = groupService.addGroupAcle(groupAcle);
		
		return groupAcle;
	}
	
	@RequestMapping(value="deleteGroupAcle",method = RequestMethod.POST)
	public String deleteGroupAcle(@RequestBody Map<String, Object> rslt) throws Exception 
	{
		System.out.println(":: /app/group/deleteGroupAcle ::");
		// Business logic 수행
		String flag = "";
		int boardNo = Integer.parseInt((String)rslt.get("boardNo"));
		
		try {
			groupService.deleteGroupAcle(boardNo);
			flag = "Y";
		}catch(Exception e)
		{
			Throwable cause = e.getCause();

		    System.out.println(cause);
			flag = "N";
		}
		
		// JSON 형식의 응답 반환
        return "{\"flag\": \"" + flag + "\"}";
	}
	
	@RequestMapping(value="updateGroupAcle",method = RequestMethod.POST)
	public GroupAcle updateGroupAcle(@RequestBody GroupAcle groupAcle) throws Exception 
	{
		System.out.println(":: /app/group/updateGroupAcle ::");
		
		// Business logic 수행
		groupAcle = groupService.updateGroupAcle(groupAcle);
		
		return groupAcle;
	}
	//오리날다............덕슨날다.....
}
