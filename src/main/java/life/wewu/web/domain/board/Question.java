package life.wewu.web.domain.board;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Question {
	private int questionNo;
	private String title;
	private String contents;
	private String questionType;		//질문 종류 - 문의(1:1) , 자주(자주 하는 질문)
	private String questionCategory;	//문의 카테고리 - 배송문의, 개인정보 문의...
	private String nickName;
	private Date regDate;
	private String reply;
	private Date replyDate;
	private String email;
	private String phoneNum;
	private int replyState; 	//답변 상태 : 1- 문의 완료, 3-답변완료 

}
