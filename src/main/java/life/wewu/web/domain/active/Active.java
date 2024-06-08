package life.wewu.web.domain.active;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Active {
	
	//필드
	private int activeNo;//active의 번호
	private int groupNo;//어느 그룹의 활동인지 group 번호
	private String activeName;//활동 이름
	private Date activeStartDate;//활동 시작일
	private Date activeEndDate;//활동 종료일
	private String activeX;//위도
	private String activeY;//경도
	private String activeStartTime;//활동 시작 시간
	private String activeEndTime;//활동 종료 시간
	private String activeInfo;//활동 코멘트
	private String activeLocal;//활동 지역
	private Date activeRegDate;//활동이 등록된 날짜
	private String stateFlag;//활동 상태 -> Y:정상 D:삭제됨 => 활동중과 활동종료는 현재날짜와 활동 종료 날짜 비교
	private String activeUrl;//마커 사진을 저장한 url
	private String activeShortUrl;//url의 short 버전
	private String leaderNick;//그룹장의 닉네임
	private List<ActiveHash> hashList; //해쉬 태그 저장 공간
	
	
}
