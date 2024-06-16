/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 */
package life.wewu.web.controller.group;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import life.wewu.web.common.Search;
import life.wewu.web.domain.group.Group;
import life.wewu.web.domain.group.GroupAcle;
import life.wewu.web.domain.group.GroupBoard;
import life.wewu.web.domain.group.GroupMember;
import life.wewu.web.domain.user.User;
import life.wewu.web.service.group.GroupService;

@Controller
@RequestMapping("/group/*")
public class GroupController {

	///필드
	@Autowired
	@Qualifier("groupService")
	private GroupService groupService;

	public GroupController()
	{
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="getGroup",method = RequestMethod.POST)
	public ModelAndView getGroup(@RequestParam("groupNo") int groupNo) throws Exception 
	{
		System.out.println(":: /group/getGroup ::");
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/getGroup.jsp");
		model.addObject("group", groupService.getGroup(groupNo));
		return model;
	}
	
	@RequestMapping(value="getAddAppl",method = RequestMethod.POST)
	public ModelAndView getAddAppl(@RequestParam("groupNo") int groupNo) throws Exception 
	{

		System.out.println(":: /group/getAddAppl ::");
		
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/getAddAppl.jsp");
		model.addObject("group", groupService.getGroup(groupNo));
		return model;
	}
	
	@RequestMapping(value="getApplJoin",method = RequestMethod.POST)
	public ModelAndView getApplJoin(@RequestParam("memberNo") int memberNo) throws Exception 
	{

		System.out.println(":: /group/getApplJoin ::");
		
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/getApplJoin.jsp");
		model.addObject("groupMember", groupService.getApplJoin(memberNo));
		return model;
	}
	
	@RequestMapping(value="getApplJoinList",method = RequestMethod.POST)
	public ModelAndView getApplJoinList(@ModelAttribute Search search) throws Exception 
	{
		System.out.println(":: /group/getApplJoinList ::");
		
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/getApplJoinList.jsp");
		model.addObject("groupMember", groupService.getApplJoinList(search));
		return model;
	}
	
	@RequestMapping(value="getMemberGroup",method = RequestMethod.POST)
	public ModelAndView getMemberGroup(@RequestParam("memberNo") int memberNo) throws Exception 
	{
		System.out.println(":: /group/getMemberGroup ::");
		
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/getMemberGroup.jsp");
		model.addObject("groupMember", groupService.getMemberGroup(memberNo));
		return model;
	}
	
	@RequestMapping(value="getGroupAcle",method = RequestMethod.POST)
	public ModelAndView getGroupAcle(@RequestParam("boardNo") int boardNo) throws Exception 
	{
		System.out.println(":: /group/getGroupAcle ::");
		
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/getGroupAcle.jsp");
		model.addObject("groupAcle", groupService.getGroupAcle(boardNo));
		return model;
	}
	
	@RequestMapping(value="mainGroup")
	public ModelAndView mainGroup() throws Exception 
	{
		System.out.println(":: /group/mainGroup ::");
		
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/mainGroup.jsp");
		return model;
	}
	
	@RequestMapping(value="updateGroup",method = RequestMethod.POST)
	public ModelAndView updateGroup(@RequestParam int groupNo) throws Exception 
	{
		System.out.println(":: /group/updateGroup ::");
		
		// Business logic 수행
		Group group = groupService.getGroup(groupNo);
		ModelAndView model = new ModelAndView("forward:/group/updateGroup.jsp");
		model.addObject("group", group);
		
		return model;
	}
	
	@RequestMapping(value="addApplGroup",method = RequestMethod.POST)
	public ModelAndView addApplGroup() throws Exception 
	{
		System.out.println(":: /group/addApplGroup ::");
		
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/addApplGroup.jsp");
		
		return model;
	}
	
	@RequestMapping(value="updateAddAppl",method = RequestMethod.POST)
	public ModelAndView updateAddAppl(@ModelAttribute("group") Group group) throws Exception 
	{
		
		System.out.println(":: /group/updateAddAppl ::");
		
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/updateAddAppl.jsp");
		model.addObject("group", group);
		
		return model;
	}
	
	@RequestMapping(value="addApplJoin",method = RequestMethod.POST)
	public ModelAndView addApplJoin(@RequestParam int groupNo) throws Exception 
	{
		
		System.out.println(":: /group/addApplJoin ::");
		
		// Business logic 수행
		Group group = groupService.getGroup(groupNo);
		ModelAndView model = new ModelAndView("forward:/group/addApplJoin.jsp");
		model.addObject("group", group);
		
		return model;
	}
	
	@RequestMapping(value="updateApplJoin",method = RequestMethod.POST)
	public ModelAndView updateApplJoin(@RequestParam int memberNo) throws Exception 
	{
		
		System.out.println(":: /group/updateApplJoin ::");
		
		// Business logic 수행
		GroupMember groupMember = groupService.getMemberGroup(memberNo);
		ModelAndView model = new ModelAndView("forward:/group/updateApplJoin.jsp");
		model.addObject("groupMember", groupMember);
		
		return model;
	}
	
	@RequestMapping(value="updateApplJoinForm",method = RequestMethod.POST)
	public ModelAndView updateApplJoinForm(@RequestParam int groupNo) throws Exception 
	{
		
		System.out.println(":: /group/updateApplJoinForm ::");
		
		// Business logic 수행
		Group group = groupService.getGroup(groupNo);
		ModelAndView model = new ModelAndView("forward:/group/updateApplJoinForm.jsp");
		model.addObject("group", group);
		
		return model;
	}
	
	@RequestMapping(value="addGroupBoard",method = RequestMethod.POST)
	public ModelAndView addGroupBoard(@RequestParam int groupNo) throws Exception 
	{
		
		System.out.println(":: /group/addGroupBoard ::");
		
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/addGroupBoard.jsp");
		model.addObject("groupNo", groupNo);
		
		return model;
	}
	
	@RequestMapping(value="getGroupBoard",method = RequestMethod.POST)
	public ModelAndView getGroupBoard(@RequestParam int typeNo) throws Exception 
	{
		
		System.out.println(":: /group/getGroupBoard ::");
		GroupBoard groupBoard = groupService.getGroupBoard(typeNo);
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/getGroupBoard.jsp");
		model.addObject("groupBoard", groupBoard);
		
		return model;
	}
	
	@RequestMapping(value="updateGroupBoard",method = RequestMethod.POST)
	public ModelAndView updateGroupBoard(@RequestParam int typeNo) throws Exception 
	{
		
		System.out.println(":: /group/updateGroupBoard ::");
		GroupBoard groupBoard = groupService.getGroupBoard(typeNo);
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/updateGroupBoard.jsp");
		model.addObject("groupBoard", groupBoard);
		
		return model;
	}
	
	@RequestMapping(value="updateMemberGroup",method = RequestMethod.POST)
	public ModelAndView updateMemberGroup(@RequestParam int memberNo) throws Exception 
	{
		
		System.out.println(":: /group/updateMemberGroup ::");
		GroupMember groupMember = groupService.getMemberGroup(memberNo);
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/updateMemberGroup.jsp");
		model.addObject("groupMember", groupMember);
		
		return model;
	}
	
	@RequestMapping(value="addGroupAcle",method = RequestMethod.POST)
	public ModelAndView addGroupAcle(@RequestParam("typeNo") int typeNo, @RequestParam("groupNo") int groupNo) throws Exception 
	{
		
		System.out.println(":: /group/addGroupAcle ::");
		// Business logic 수행
		User user = User.builder()
				.nickname("nick3")
				.build();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("groupNo", groupNo);
		map.put("memberNickNmae", user.getNickname());
		
		GroupMember groupMember = groupService.getMemberGroupForNick(map);
		
		ModelAndView model = new ModelAndView("forward:/group/addGroupAcle.jsp");
		model.addObject("typeNo", typeNo);
		model.addObject("groupMember", groupMember);
		
		return model;
	}
	
	@RequestMapping(value="updateGroupAcle",method = RequestMethod.POST)
	public ModelAndView updateGroupAcle(@RequestParam int boardNo) throws Exception 
	{
		
		System.out.println(":: /group/updateGroupAcle ::");
		GroupAcle groupAcle = groupService.getGroupAcle(boardNo);
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/updateGroupAcle.jsp");
		model.addObject("groupAcle", groupAcle);
		
		return model;
	}
}
