package life.wewu.web.service.active;

import java.util.List;
import java.util.Map;

import life.wewu.web.domain.active.Active;
import life.wewu.web.domain.active.ActiveHash;

public interface ActiveService {

	public void addActive(Map<String, Object> map); //활동 등록
	
	public Active getActive(int activeNo); //활동 상세 조회
	
	public void updateActive(Active active); //활동 수정
	
	public void deleteActive(String stateFlag); //활동 삭제
	
	public List<Active> getActiveList(); //활동 목록
	
}
