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
public class QuestState {
	
	//field
	
	private int questStateNo;		//퀘스트상태식별번호
	private int questNo;			//퀘스트식별번호
	private String nickname;		//유저닉네임
	private String questState;		//퀘스트 상태 ('N','Y')
	private Quest quest;
	private int currentCnt;
}
