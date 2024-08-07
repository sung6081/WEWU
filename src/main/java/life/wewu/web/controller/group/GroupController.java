/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 */
package life.wewu.web.controller.group;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
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
	
	@RequestMapping(value="getGroup")
	public ModelAndView getGroup(@RequestParam("groupNo") int groupNo, HttpSession session) throws Exception 
	{
		System.out.println(":: /group/getGroup ::");
		User user = (User)session.getAttribute("user");
		// Business logic 수행
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("groupNo", groupNo);
		map.put("memberNickName",user.getNickname());
		
		ModelAndView model = new ModelAndView("forward:/group/getGroup.jsp");
		
		int cnt = groupService.groupMemberCnt(groupNo);
		Group group = groupService.getGroup(groupNo);
		
		group.setGroupPers(cnt);
		
		if (cnt >= 100) {
			group.setGroupLevel("S");
		} else if (cnt >= 50) {
			group.setGroupLevel("A");
		} else if (cnt >= 30) {
			group.setGroupLevel("B");
		} else if (cnt >= 10){
			group.setGroupLevel("C");
		}else {
			group.setGroupLevel("D");
		}
		
		model.addObject("group", group);
		model.addObject("groupMember", groupService.getMemberGroupForNick(map));
		model.addObject("groupCnt", cnt);
		model.addObject("acleCnt", groupService.groupAcleCnt(groupNo));
		return model;
	}
	
	@RequestMapping(value="getAddAppl",method = RequestMethod.POST)
	public ModelAndView getAddAppl(@RequestParam("groupNo") int groupNo) throws Exception 
	{

		System.out.println(":: /group/getAddAppl ::");
		
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/getAddAppl.jsp");
		
		int cnt = groupService.groupMemberCnt(groupNo);
		Group group = groupService.getGroup(groupNo);
		
		group.setGroupPers(cnt);
		
		if (cnt >= 100) {
			group.setGroupLevel("S");
		} else if (cnt >= 50) {
			group.setGroupLevel("A");
		} else if (cnt >= 30) {
			group.setGroupLevel("B");
		} else if (cnt >= 10){
			group.setGroupLevel("C");
		}else {
			group.setGroupLevel("D");
		}
		
		model.addObject("group", group);
		
		return model;
	}
	
	@RequestMapping(value="getApplJoin",method = RequestMethod.POST)
	public ModelAndView getApplJoin(@RequestParam("memberNo") int memberNo) throws Exception 
	{

		System.out.println(":: /group/getApplJoin ::");
		GroupMember groupMember = groupService.getApplJoin(memberNo);
		Group group = groupService.getGroup(groupMember.getGroupNo());
		int cnt = groupService.groupMemberCnt(groupMember.getGroupNo());
		
		group.setGroupPers(cnt);
		
		if (cnt >= 100) {
			group.setGroupLevel("S");
		} else if (cnt >= 50) {
			group.setGroupLevel("A");
		} else if (cnt >= 30) {
			group.setGroupLevel("B");
		} else if (cnt >= 10){
			group.setGroupLevel("C");
		}else {
			group.setGroupLevel("D");
		}
		
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/getApplJoin.jsp");
		model.addObject("groupMember", groupMember);
		model.addObject("group", group);
		return model;
	}
	
	@RequestMapping(value="getApplJoinList",method = RequestMethod.POST)
	public ModelAndView getApplJoinList(@ModelAttribute Search search, @RequestParam String joinFlag) throws Exception 
	{
		System.out.println(":: /group/getApplJoinList ::");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("search", search);
		map.put("joinFlag", joinFlag);
		// Business logic 수행
		System.out.println(search);
		System.out.println(joinFlag);
		ModelAndView model = new ModelAndView("forward:/group/getApplJoinList.jsp");
		model.addObject("groupMember", groupService.getApplJoinList(map));
		return model;
	}
	
	@RequestMapping(value="getMemberGroup",method = RequestMethod.POST)
	public ModelAndView getMemberGroup(@RequestParam("memberNo") int memberNo,@RequestParam("groupNo") int groupNo) throws Exception 
	{
		System.out.println(":: /group/getMemberGroup ::");
		
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/getMemberGroup.jsp");
		
		
		
		Group group = groupService.getGroup(groupNo);
		int cnt = groupService.groupMemberCnt(groupNo);
		
		GroupMember groupMember = groupService.getMemberGroup(memberNo);
		System.out.println(groupMember);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("groupNo", groupNo);
		map.put("memberNickName",groupMember.getMemberNickName());
		map.put("nickname",groupMember.getMemberNickName());
		
		group.setGroupPers(cnt);
		
		if (cnt >= 100) {
			group.setGroupLevel("S");
		} else if (cnt >= 50) {
			group.setGroupLevel("A");
		} else if (cnt >= 30) {
			group.setGroupLevel("B");
		} else if (cnt >= 10){
			group.setGroupLevel("C");
		}else {
			group.setGroupLevel("D");
		}
		
		model.addObject("group", group);
		model.addObject("groupMember", groupMember);
		model.addObject("acleCount", groupService.memberAcleListCnt(map));
		model.addObject("commentCount", groupService.memberCommentListCnt(map));
		return model;
	}
	
	@RequestMapping(value="getMemberGroupForNick",method = RequestMethod.POST)
	public ModelAndView getMemberGroupForNick(@RequestParam("groupNo") int groupNo, @RequestParam("memberNickName") String nickname) throws Exception 
	{
		System.out.println(":: /group/getMemberGroupForNick ::");
		// Business logic 수행
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("groupNo", groupNo);
		map.put("memberNickName",nickname);
		map.put("nickname",nickname);
		ModelAndView model = new ModelAndView("forward:/group/getMemberGroup.jsp");
		
		Group group = groupService.getGroup(groupNo);
		int cnt = groupService.groupMemberCnt(groupNo);
		
		group.setGroupPers(cnt);
		
		if (cnt >= 100) {
			group.setGroupLevel("S");
		} else if (cnt >= 50) {
			group.setGroupLevel("A");
		} else if (cnt >= 30) {
			group.setGroupLevel("B");
		} else if (cnt >= 10){
			group.setGroupLevel("C");
		}else {
			group.setGroupLevel("D");
		}
		
		model.addObject("group", group);
		model.addObject("groupMember", groupService.getMemberGroupForNick(map));
		
		model.addObject("acleCount", groupService.memberAcleListCnt(map));
		model.addObject("commentCount", groupService.memberCommentListCnt(map));
		
		return model;
	}
	
	@RequestMapping(value="getGroupAcle",method = RequestMethod.POST)
	public ModelAndView getGroupAcle(@RequestParam("boardNo") int boardNo, @RequestParam("groupNo") int groupNo, HttpSession session) throws Exception 
	{
		System.out.println(":: /group/getGroupAcle ::");
		
		// Business logic 수행
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("groupNo", groupNo);
		map.put("memberNickName",((User)session.getAttribute("user")).getNickname());
		
		Group group = groupService.getGroup(groupNo);
		int cnt = groupService.groupMemberCnt(groupNo);
		
		group.setGroupPers(cnt);
		
		if (cnt >= 100) {
			group.setGroupLevel("S");
		} else if (cnt >= 50) {
			group.setGroupLevel("A");
		} else if (cnt >= 30) {
			group.setGroupLevel("B");
		} else if (cnt >= 10){
			group.setGroupLevel("C");
		}else {
			group.setGroupLevel("D");
		}
		
		ModelAndView model = new ModelAndView("forward:/group/getGroupAcle.jsp");
		GroupAcle groupAcle = groupService.getGroupAcle(boardNo);
		model.addObject("groupAcle", groupService.getGroupAcle(boardNo));
		model.addObject("groupBoard", groupService.getGroupBoard(groupAcle.getTypeNo()));
		model.addObject("group", group);
		model.addObject("groupMember", groupService.getMemberGroupForNick(map));
		
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
	public ModelAndView updateGroup(@RequestParam int groupNo, HttpSession session) throws Exception 
	{
		System.out.println(":: /group/updateGroup ::");
		
		// Business logic 수행
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("groupNo", groupNo);
		map.put("memberNickName",((User)session.getAttribute("user")).getNickname());
		
		ModelAndView model = new ModelAndView("forward:/group/updateGroup.jsp");
		
		model.addObject("group", groupService.getGroup(groupNo));
		model.addObject("groupMember", groupService.getMemberGroupForNick(map));
		
		
		
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
		group = groupService.getGroup(group.getGroupNo());
		model.addObject("group", group);
		System.out.println(group);
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
		Group group = groupService.getGroup(groupMember.getGroupNo());
		ModelAndView model = new ModelAndView("forward:/group/updateApplJoin.jsp");
		model.addObject("groupMember", groupMember);
		model.addObject("group", group);
		
		return model;
	}
	
	@RequestMapping(value="updateApplJoinForm",method = RequestMethod.POST)
	public ModelAndView updateApplJoinForm(@RequestParam int groupNo, HttpSession session) throws Exception 
	{
		
		System.out.println(":: /group/updateApplJoinForm ::");
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("groupNo", groupNo);
		map.put("memberNickName", ((User)session.getAttribute("user")).getNickname());
		
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/updateApplJoinForm.jsp");
		model.addObject("group", groupService.getGroup(groupNo));
		model.addObject("groupMember", groupService.getMemberGroupForNick(map));
		
		return model;
	}
	
	@RequestMapping(value="addGroupBoard",method = RequestMethod.POST)
	public ModelAndView addGroupBoard(@RequestParam int groupNo, HttpSession session) throws Exception 
	{
		
		System.out.println(":: /group/addGroupBoard ::");
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("groupNo", groupNo);
		map.put("memberNickName", ((User)session.getAttribute("user")).getNickname());
		
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/addGroupBoard.jsp");
		model.addObject("group", groupService.getGroup(groupNo));
		model.addObject("groupMember", groupService.getMemberGroupForNick(map));
		
		return model;
	}
	
	@RequestMapping(value="getGroupBoard",method = RequestMethod.POST)
	public ModelAndView getGroupBoard(@RequestParam("typeNo") int typeNo, @RequestParam("groupNo") int groupNo, HttpSession session) throws Exception 
	{
		System.out.println(":: /group/getGroupBoard ::");
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("groupNo", groupNo);
		map.put("memberNickName", ((User)session.getAttribute("user")).getNickname());
		
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/getGroupBoard.jsp");
		
		model.addObject("groupBoard", groupService.getGroupBoard(typeNo));
		model.addObject("group", groupService.getGroup(groupNo));
		model.addObject("groupMember", groupService.getMemberGroupForNick(map));
		
		return model;
	}
	
	@RequestMapping(value="updateGroupBoard",method = RequestMethod.POST)
	public ModelAndView updateGroupBoard(@RequestParam("typeNo") int typeNo,HttpSession session) throws Exception 
	{
		System.out.println(":: /group/updateGroupBoard ::");
		
		// Business logic 수행
		GroupBoard groupBoard = groupService.getGroupBoard(typeNo);
		Group group = groupService.getGroup(groupBoard.getGroupNo());
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("groupNo", group.getGroupNo());
		map.put("memberNickName", ((User)session.getAttribute("user")).getNickname());
		
		ModelAndView model = new ModelAndView("forward:/group/updateGroupBoard.jsp");
		model.addObject("group", group);
		model.addObject("groupBoard", groupBoard);
		model.addObject("groupMember", groupService.getMemberGroupForNick(map));
		
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
	public ModelAndView addGroupAcle(@RequestParam("typeNo") int typeNo,@RequestParam("groupNo") int groupNo, HttpSession session) throws Exception 
	{
		
		System.out.println(":: /group/addGroupAcle ::");
		// Business logic 수행
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("groupNo", groupNo);
		map.put("memberNickName", ((User)session.getAttribute("user")).getNickname());
		
		GroupMember groupMember = groupService.getMemberGroupForNick(map);
		
		ModelAndView model = new ModelAndView("forward:/group/addGroupAcle.jsp");
		
		model.addObject("group", groupService.getGroup(groupNo));
		model.addObject("typeNo", typeNo);
		model.addObject("groupMember", groupMember);
		model.addObject("groupBoard", groupService.getGroupBoard(typeNo));
		
		return model;
	}
	
	@RequestMapping(value="getMemberGroupList",method = RequestMethod.POST)
	public ModelAndView getMemberGroupList(@RequestParam("groupNo") int groupNo, HttpSession session) throws Exception 
	{
		System.out.println(":: /group/getMemberGroupList ::");
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/getMemberGroupList.jsp");
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("groupNo", groupNo);
		map.put("memberNickName", ((User)session.getAttribute("user")).getNickname());
		
		model.addObject("group", groupService.getGroup(groupNo));
		model.addObject("groupMember", groupService.getMemberGroupForNick(map));
		
		return model;
	} 
	
	@RequestMapping(value="updateGroupAcle",method = RequestMethod.POST)
	public ModelAndView updateGroupAcle(@RequestParam("boardNo") int boardNo,@RequestParam("typeNo") int typeNo, HttpSession session) throws Exception 
	{
		
		System.out.println(":: /group/updateGroupAcle ::");
		
		GroupBoard groupBoard = groupService.getGroupBoard(typeNo);
		Group group = groupService.getGroup(groupBoard.getGroupNo());
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("groupNo", group.getGroupNo());
		map.put("memberNickName", ((User)session.getAttribute("user")).getNickname());
		
		GroupMember groupMember = groupService.getMemberGroupForNick(map);
		// Business logic 수행
		ModelAndView model = new ModelAndView("forward:/group/updateGroupAcle.jsp");
		model.addObject("groupAcle", groupService.getGroupAcle(boardNo));
		model.addObject("groupBoard", groupBoard);
		model.addObject("groupMember", groupMember);
		model.addObject("group", group);
		
		return model;
	}
	
	@RequestMapping(value="uploadFile", method = RequestMethod.POST)
    public void smarteditorImageUpload2(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException {
		//String fileDir = "C:\\Users\\chu54\\OneDrive\\바탕 화면\\demo\\src\\main\\resources\\static\\group\\upload\\";
		String fileDir = "/usr/local/tomcat/webapps/ROOT/WEB-INF/classes/static/group/upload/";
		try{
            if(file.isEmpty()) {
                System.out.println("이미지 미등록");
            } else {
                File saveDir = new File(fileDir);
                if(!saveDir.exists()){
                    saveDir.mkdir();
                }
                String rfileName = file.getOriginalFilename();
                String extension = StringUtils.getFilenameExtension(rfileName);
                String pFileName = UUID.randomUUID().toString() + "." + extension;
                File saveFile = new File(saveDir, pFileName);
                try {
                    file.transferTo(saveFile);
                }catch(Exception e) {
                    e.printStackTrace();
                }
                String sFileInfo = "";
                sFileInfo += "&bNewLine=true";
                // img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
                sFileInfo += "&sFileName=" + pFileName;
                sFileInfo += "&sFileURL=../group/upload/" + pFileName;
                PrintWriter print = response.getWriter();
                print.print(sFileInfo);
                System.out.println(sFileInfo);
                print.flush();
                print.close();

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	@RequestMapping(value="groupImg", method = RequestMethod.POST)
    public void groupImg(MultipartFile file, @ModelAttribute Group group,HttpServletRequest request, HttpServletResponse response) throws IOException {
		//String fileDir = "C:\\Users\\chu54\\OneDrive\\바탕 화면\\demo\\src\\main\\resources\\static\\group\\upload\\";
		String fileDir = "/usr/local/tomcat/webapps/ROOT/WEB-INF/classes/static/group/upload/";
		try{
            if(file.isEmpty()) {
                System.out.println("이미지 미등록");
            } else {
                File saveDir = new File(fileDir);
                if(!saveDir.exists()){
                    saveDir.mkdir();
                }
                String rfileName = file.getOriginalFilename();
                String extension = StringUtils.getFilenameExtension(rfileName);
                String pFileName = UUID.randomUUID().toString() + "." + extension;
                File saveFile = new File(saveDir, pFileName);
                try {
                    file.transferTo(saveFile);
                }catch(Exception e) {
                    e.printStackTrace();
                }
                System.out.println(group);
                group.setGroupImg(pFileName);
                groupService.updateGroup(group);
                
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
