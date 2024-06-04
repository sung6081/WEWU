/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 */
package life.wewu.web.service.group.impl;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import life.wewu.web.domain.group.Group;
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

}
