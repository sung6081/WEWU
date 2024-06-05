package life.wewu.web.domain.plant;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Quest {
	
	//field
	
	private int questNo;			//퀘스트식별번호
	private String questContents;	//퀘스트내용
	private String questState;		//퀘스트상태(Y,N,I)
	private Date questRegDate;		//퀘스트등록일
	private String questTarget;		//퀘스트목표
	private int questTargetCnt;		//퀘스트목표치
	private int questReward;		//퀘스트보상

}