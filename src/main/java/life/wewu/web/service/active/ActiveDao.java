package life.wewu.web.service.active;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import io.micrometer.core.instrument.search.Search;
import life.wewu.web.domain.active.Active;
import life.wewu.web.domain.active.ActiveHash;

@Mapper
public interface ActiveDao {

	//메소드
	public void addActive(Active active); //활동 등록
	
	public Active getActive(int activeNo); //활동 상세 조회
	
	public void updateActive(Active active); //활동 수정
	
	public List<Active> getActiveList(Search search); //활동 목록
	
	public void addActiveHash(ActiveHash activeHash); //해쉬 태그 등록
	
	public int getActiveHashCount(int activeNo); //해쉬 태그의 개수
	
	public List<ActiveHash> getActiveHashList(int activeNo); //활동의 해쉬 태그 조회

	public void deleteActiveHash(int activeNo); //활동의 해쉬 태그 삭제
	
}
