/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 */
package life.wewu.web.service.group.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import life.wewu.web.common.Search;
import life.wewu.web.domain.group.Group;
import life.wewu.web.service.group.GroupDao;
import life.wewu.web.service.group.GroupService;

@Service("groupService")
public class GroupServiceImpl implements GroupService{

	///필드
	@Autowired
	@Qualifier("groupDao")
	private GroupDao groupDao;
	
	///생성자
	
	///메소드
	public void addGroup(Group group) throws Exception{
		
		groupDao.addGroup(group);
	}
	
	public Group getGroup(int groupNo) throws Exception {
		
		return groupDao.getGroup(groupNo);
	}
	
	public void deleteGroup(int groupNo) throws Exception{
		
		groupDao.deleteGroup(groupNo);
	}
	
	public Group updateGroup(Group group) throws Exception {
		
		groupDao.updateGroup(group);
		return groupDao.getGroup(group.getGroupNo());
	}
	
	public Group updateGroupRslt(Group group) throws Exception {
		
		groupDao.updateGroup(group);
		return groupDao.getGroup(group.getGroupNo());
	}
	
	public String getGroupRanking(int GroupNo) throws Exception {
	
		return groupDao.getGroupRanking(GroupNo);
	}
	
	public List<Group> getGroupList(Search search) throws Exception {
		
		return groupDao.getGroupList(search);
	}
	
	public List<Group> getGroupRankingList(Search search) throws Exception {
		
		return groupDao.getGroupList(search);
	}
	
	public Group getApplJoin(int GroupNo) throws Exception {
		
		return groupDao.getGroup(GroupNo);
	}
	
	public List<Group> getApplJoinList(Search search) throws Exception {
		
		return groupDao.getGroupList(search);
	}
	
	public Group updateApplJoinForm(Group group) throws Exception {
		
		groupDao.updateGroup(group);
		return groupDao.getGroup(group.getGroupNo());
	}
}
