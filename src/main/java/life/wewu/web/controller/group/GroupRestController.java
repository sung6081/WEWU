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
	public ModelAndView updateGroup(int groupNo) throws Exception 
	{
		System.out.println(":: /group/updateGroup ::");
		
		// Business logic 수행
		Group group = groupService.getGroup(groupNo);
		ModelAndView model = new ModelAndView("forward:/group/updateGroup.jsp");
		model.addObject("group", group);
		
		return model;
	}
}