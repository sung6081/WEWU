/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 */
package life.wewu.web.service.group.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import life.wewu.web.common.Search;
import life.wewu.web.domain.group.Group;
import life.wewu.web.domain.group.GroupAcle;
import life.wewu.web.domain.group.GroupBoard;
import life.wewu.web.domain.group.GroupMember;
import life.wewu.web.service.group.GroupService;

@SpringBootTest
public class GroupServiceTest{

	///필드
	@Autowired
	@Qualifier("groupService")
	private GroupService groupService;
	
	///생성자
	
	///메소드
	//@Test
	public void testAddGroup() throws Exception {
		
		System.out.println("\n===================================");
		Group group = Group.builder()
								.leaderNick("nick1")
								.groupName("귀여운모임")
								.groupIntro("귀여워 죽겠지???")
								.groupHash("1234.jpg")
								.groupAddr("신림역")
								.groupPlan("계획없어")
								.groupPers(1)
								.groupLevel("D")
								.groupFile("131223154.word")
								.groupRslt("E")
								.build();

		groupService.addGroup(group);
		
		System.out.println("===================================\n");
	}

	//@Test
	public void testGetGroup() throws Exception {
		
		System.out.println("\n===================================");

		Group group = groupService.getGroup(6);
		System.out.println("group Domain :: " + group);
		
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testDeleteGroup() throws Exception {
		
		System.out.println("\n===================================");
		
		groupService.deleteGroup(6);
		
		Group group = groupService.getGroup(6);
		System.out.println("group Domain :: " + group);
		
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testUpdateGroup() throws Exception {
		
		System.out.println("\n===================================");
		Group group = Group.builder()
								.groupNo(8)
								.leaderNick("nick1")
								.groupName("안귀여운모임")
								.groupIntro("못생겼지????")
								.groupHash("#못난이")
								.groupAddr("신림역")
								.groupPlan("못생긴 계획")
								.groupPers(1)
								.groupLevel("D")
								.groupFile("활동계획서.word")
								.groupRslt("E")
								.build();
		
		group = groupService.updateGroup(group);
		System.out.println("group Domain :: " + group);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testUpdateGroupRslt() throws Exception {
		
		System.out.println("\n===================================");
		Group group = Group.builder()
								.groupNo(8)
								.groupRslt("A")
								.build();
		
		group = groupService.updateGroupRslt(group);
		System.out.println("group Domain :: " + group);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testGetGroupRanking() throws Exception {
		
		System.out.println("\n===================================");
		
		String ranking = groupService.getGroupRanking(8);
		System.out.println("group Rangking :: " + ranking);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testGetGroupList() throws Exception {
		
		System.out.println("\n===================================");
		Search search = new Search();
		List<Group> list = groupService.getGroupList(search);
		System.out.println("group List :: " + list);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testGetGroupRankingList() throws Exception {
		
		System.out.println("\n===================================");
		Search search = new Search();
		search.setSearchCondition("Ranking");
		List<Group> list = groupService.getGroupList(search);
		System.out.println("group RankingList :: " + list);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testGetApplJoin() throws Exception {
		
		System.out.println("\n===================================");

		GroupMember groupMember = groupService.getApplJoin(6);
		System.out.println("groupMember testGetApplJoin :: " + groupMember);
		
		System.out.println("===================================\n");
	}
	
	//@Test
	/*
	public void testgetApplJoinList() throws Exception {
		
		System.out.println("\n===================================");
		
		Search search = new Search();
		search.setSearchCondition("user");
		search.setSearchKeyword("nick1");
		List<GroupMember> list = groupService.getApplJoinList(search);
		System.out.println("groupMember Rslt = user :: " + list);
		System.out.println("===================================\n");
	}
	*/
	//@Test
	public void testupdateApplJoinForm() throws Exception {
		
		System.out.println("\n===================================");
		Group group = Group.builder()
								.groupNo(8)
								.frstQuest("왜 가입하려고 해요?")
								.scndQuest("두번째 질문")
								.thrdQuest("세번째 질문")
								.build();
		
		group = groupService.updateApplJoinForm(group);
		System.out.println("group UpdateApplForm :: " + group);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testAddMemberGroup() throws Exception {
		
		System.out.println("\n===================================");
		Group group = groupService.getGroup(1);
		
		GroupMember groupMember = GroupMember.builder()
								.groupNo(8)
								.memberNickName("nick2")
								.frstQuest(group.getFrstQuest())
								.scndQuest(group.getScndQuest())
								.thrdQuest(group.getThrdQuest())
								.frstRepl("그냥 관심이 가서요")
								.scndRepl("두번째 답변")
								.thrdRepl("세번째 답변")
								.build();

		groupMember = groupService.addMemberGroup(groupMember);
		System.out.println("groupMember addMemberGroup :: " + groupMember + groupMember.getMemberNo());
		System.out.println("===================================\n");
	}
		
	//@Test
	public void testGetMemberGroup() throws Exception {
		
		System.out.println("\n===================================");
		GroupMember groupMember = groupService.getMemberGroup(2);
		System.out.println("groupMember getMemberGroup :: " + groupMember);
		System.out.println("===================================\n");
	}
	
	//@Test
	/*
	public void testGetMemberGroupList() throws Exception {
		
		System.out.println("\n===================================");
		Search search = new Search();
		search.setSearchCondition("user");
		search.setSearchCondition("nick1");
		List<GroupMember> list = groupService.getMemberGroupList(search);
		System.out.println("groupMember getMemberGroupList :: " + list);
		System.out.println("===================================\n");
	}
	*/
	//@Test
	public void testGetScrab() throws Exception {
		
		System.out.println("\n===================================");
		String scrab = groupService.getScrab(2);
		System.out.println("groupMember getScrab :: " + scrab);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testUpdateScrab() throws Exception {
		
		System.out.println("\n===================================");
		GroupMember groupMember = GroupMember.builder()
				.memberNo(2)
				.scrabFlag("Y")
				.build();
		groupService.updateScrab(groupMember);
		groupMember = groupService.getMemberGroup(groupMember.getMemberNo());
		System.out.println("groupMember updateScrab :: " + groupMember);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testDeleteMemberGroup() throws Exception {
		
		System.out.println("\n===================================");
		groupService.deleteMemberGroup(6);
		System.out.println("groupMember DeleteMemberGroup :: ");
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testAddGroupBoard() throws Exception {
		
		System.out.println("\n===================================");
		GroupBoard groupBoard = GroupBoard.builder()
				.groupNo(8)
				.boardName("공지사항")
				.boardIntro("모임의 공지사항을 게시하는 곳")
				.boardType("L")
				.boardRole("G")
				.build();
		groupBoard = groupService.addGroupBoard(groupBoard);
		System.out.println("groupBoard addGroupBoard :: " + groupBoard);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testGetGroupBoard() throws Exception {
		
		System.out.println("\n===================================");
		GroupBoard groupBoard = groupService.getGroupBoard(1);
		System.out.println("groupBoard tGetGroupBoard :: " + groupBoard);
		System.out.println("===================================\n");
	}
		
	//@Test
	public void testGetGroupBoardList() throws Exception {
		
		System.out.println("\n===================================");
		List<GroupBoard> list = groupService.getGroupBoardList(8);
		System.out.println("groupBoard GetGroupBoardList :: " + list);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testUpdateGroupBoard() throws Exception {
		
		System.out.println("\n===================================");
		GroupBoard groupBoard = GroupBoard.builder()
				.groupNo(8)
				.typeNo(1)
				.boardIntro("공지사항좀 게시하자 제발~~")
				.build();
		groupService.updateGroupBoard(groupBoard);
		groupBoard = groupService.getGroupBoard(groupBoard.getTypeNo());
		System.out.println("groupBoard UpdateGroupBoard :: " + groupBoard);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testDeleteGroupBoard() throws Exception {
		
		System.out.println("\n===================================");
		groupService.deleteGroupBoard(1);
		System.out.println("groupMember DeleteGroupBoard :: ");
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testAddGroupAcle() throws Exception {
		
		System.out.println("\n===================================");
		GroupAcle groupAcle = GroupAcle.builder()
				.typeNo(2)
				.memberNo(8)
				.acleName("공지사항 1번")
				.acleContents("해당 내용은 공지사항입니다~~~")
				.wrteName("nick2")
				.build();
		groupAcle = groupService.addGroupAcle(groupAcle);
		System.out.println("groupMember AddGroupAcle :: " + groupAcle);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testGetGroupAcle() throws Exception {
		
		System.out.println("\n===================================");
		GroupAcle groupAcle = groupService.getGroupAcle(2);
		System.out.println("groupBoard GetGroupAcle :: " + groupAcle);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testGetGroupAcleLsit() throws Exception {
		
		System.out.println("\n===================================");
		Map<String, Object> map = new HashMap<String, Object>();
		Search search = new Search();
		search.setSearchCondition("1");
		map.put("search", search);
		map.put("typeNo", 2);
		List<GroupAcle> list = groupService.getGroupAcleList(map);
		System.out.println("groupBoard GetGroupAcleLsit :: " + list);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testGetGroupAcleCnt() throws Exception {
		
		System.out.println("\n===================================");
		Map<String, Object> map = new HashMap<String, Object>();
		Search search = new Search();
		search.setSearchCondition("8");
		map.put("search", search);
		map.put("typeNo", 2);
		int acleCnt = groupService.getGroupAcleCnt(map);
		System.out.println("groupBoard GetGroupAcleCnt :: " + acleCnt);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testUpdateGroupAcle() throws Exception {
		
		System.out.println("\n===================================");
		GroupAcle groupAcle = GroupAcle.builder()
				.boardNo(2)
				.acleName("공지사항 업데이트")
				.acleContents("공지사항을 수정했습니다~")
				.build();
		
		
		groupService.updateGroupAcle(groupAcle);
		groupAcle = groupService.getGroupAcle(groupAcle.getBoardNo());
		System.out.println("groupBoard UpdateGroupAcle :: " + groupAcle);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testDeleteGroupAcle() throws Exception {
		
		System.out.println("\n===================================");
		groupService.deleteGroupAcle(2);
		System.out.println("groupMember DeleteGroupAcle :: ");
		System.out.println("===================================\n");
	}
	
}
