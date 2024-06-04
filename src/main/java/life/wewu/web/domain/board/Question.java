package life.wewu.web.domain.board;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Question {
	private String title;
	private String contents;
	private int questionType;
	private int boardType;
	private int boardNo;
	private String nickName;
	private Date regDate;
	private String reply;
	private String email;
	private String phoneNum;
	private int replyState;

}
