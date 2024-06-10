package life.wewu.web.service.active;

import java.util.List;
import java.util.Map;

import life.wewu.web.common.Search;
import life.wewu.web.domain.active.Active;
import life.wewu.web.domain.active.ActiveHash;

public interface ActiveService {

	public void addActive(Map<String, Object> map); //활동 등록
	
	public Active getActive(int activeNo); //활동 상세 조회
	
	public void updateActive(Map<String, Object> map); //활동 수정
	
	public void deleteActive(int activeNo); //활동 삭제
	
	public List<Active> getActiveList(Search search); //활동 목록
	
	public List<Active> getGroupActiveList(Map<String, Object> map); //모임 활동 목록
	
}
