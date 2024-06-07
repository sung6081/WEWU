package life.wewu.web.service.active.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import life.wewu.web.common.Search;
import life.wewu.web.domain.active.Active;
import life.wewu.web.domain.active.ActiveHash;
import life.wewu.web.repository.S3Repository;
import life.wewu.web.service.active.ActiveDao;
import life.wewu.web.service.active.ActiveService;

@Service("activeServiceImpl")
public class ActiveServiceImpl implements ActiveService {
	
	//필드
	@Autowired
	@Qualifier("activeDao")
	ActiveDao activeDao; //activeDao injection
	
	@Autowired
	@Qualifier("s3RepositoryImpl")
	S3Repository s3;

	//메소드
	//활동과 해쉬태그 모두 등록
	@Override
	@Transactional
	public void addActive(Map<String, Object> map) {
		// TODO Auto-generated method stub
		Active active = (Active)map.get("active");
		
		//파일 업로드
		map.put("folderName", "active");
		
		active.setActiveUrl(s3.uplodaFile(map)); 
		
		//short url
		if(active.getActiveUrl() != null) {
			try {
				active.setActiveShortUrl(s3.getShortUrl(active.getActiveUrl()));
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
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
		
		//System.out.println(activeNo);
		
		Active active = activeDao.getActive(activeNo);
		
		if(active == null) {
			return null;
		}
		
		active.setHashList(activeDao.getActiveHashList(activeNo));
		
		return active;
	}

	//active 업데이트
	@Override
	@Transactional
	public void updateActive(Map<String, Object> map) {
		// TODO Auto-generated method stub
		
		Active active = (Active)map.get("active");
		
		//파일 업로드
		map.put("folderName", "active");
		
		active.setActiveUrl(s3.uplodaFile(map)); 
		
		//short url
		if(active.getActiveUrl() != null) {
			try {
				active.setActiveShortUrl(s3.getShortUrl(active.getActiveUrl()));
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		//업데이트 active
		activeDao.updateActive(active);
		
		//기존 해쉬태그 삭제 후 다시 삽입
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

	//active삭제
	@Override
	@Transactional
	public void deleteActive(Active active) {
		// TODO Auto-generated method stub
		active.setStateFlag("D");
		
		activeDao.updateActive(active);
		
	}

	//전체 활동 목록
	@Override
	public List<Active> getActiveList(Search search) {
		// TODO Auto-generated method stub
		List<Active> activeList = activeDao.getActiveList(search);
		
		return activeList;
	}

	//특정 그룹에서 등록된 활동 목록
	@Override
	public List<Active> getGroupActiveList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<Active> activeList = activeDao.getGroupActiveList(map);
		
		return activeList;
	}
	
}
