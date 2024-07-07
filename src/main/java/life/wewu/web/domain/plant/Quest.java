package life.wewu.web.domain.plant;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Quest {
	
	//field
	
	private int questNo;			//퀘스트식별번호
	private String questContents;	//퀘스트내용
	private String questTarget;		//퀘스트목표
	private int questTargetCnt;		//퀘스트목표치
	private int questReward;		//퀘스트보상
	private Date regDate;			//등록일
	private String nickname;
	private QuestState questState;
	private int questStateNo;
	
	

}
