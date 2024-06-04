/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 */
package life.wewu.web.service.group;

import life.wewu.web.domain.group.Group;

public interface GroupService {
	///필드
	
	///생성자
	
	///메소드
	public void addGroup(Group group) throws Exception;
	
	public Group getGroup(int GroupNo) throws Exception;
	
	public void deleteGroup(int GroupNo) throws Exception;
	
	public Group updateGroup(Group group) throws Exception;
	
	public Group updateGroupRslt(Group group) throws Exception;
	
	public String getGroupRanking(int GroupNo) throws Exception;
}
