package life.wewu.web.service.active.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import life.wewu.web.domain.active.Active;
import life.wewu.web.domain.active.ActiveHash;
import life.wewu.web.service.active.ActiveDao;
import life.wewu.web.service.active.ActiveService;

public class ActiveServiceImpl implements ActiveService {
	
	//필드
	@Autowired
	@Qualifier("activeDao")
	ActiveDao activeDao; //activeDao injection

	//활동과 해쉬태그 모두 등록
	@Override
	public void addActive(Map<String, Object> map) {
		// TODO Auto-generated method stub
		Active active = (Active)map.get("active");
		
		activeDao.addActive(active);
		
		String[] hashList = map.get("hash").toString().split(",");
		
		for(int i = 0; i < hashList.length; i++) {
			ActiveHash activeHash = ActiveHash.builder()
					.activeNo(active.getActiveNo())
					.hashName(hashList[i])
					.build();
			
			activeDao.addActiveHash(activeHash);
		}
		
	}

	//활동과 해쉬태그 가져오기
	@Override
	public Active getActive(int activeNo) {
		// TODO Auto-generated method stub
		
		Active active = activeDao.getActive(activeNo);
		
		active.setHashList(activeDao.getActiveHashList(activeNo));
		
		return active;
	}

	@Override
	public void updateActive(Map<String, Object> map) {
		// TODO Auto-generated method stub
		
		Active active = (Active)map.get("active");
		
		activeDao.updateActive(active);
		
		activeDao.deleteActiveHash(active.getActiveNo());
		
		String[] hashList = map.get("hash").toString().split(",");
		
		for(int i = 0; i < hashList.length; i++) {
			ActiveHash activeHash = ActiveHash.builder()
					.activeNo(active.getActiveNo())
					.hashName(hashList[i])
					.build();
			
			activeDao.addActiveHash(activeHash);
		}
		
	}

	@Override
	public void deleteActive(Active active) {
		// TODO Auto-generated method stub
		active.setStateFlag("D");
		
		activeDao.updateActive(active);
		
	}

	@Override
	public List<Active> getActiveList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		
		
		return null;
	}

	
	
}
