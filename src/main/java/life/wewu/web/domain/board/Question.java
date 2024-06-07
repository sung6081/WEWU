package life.wewu.web.domain.board;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Question {
	private int questionNo;
	private String title;
	private String contents;
	private int questionType;
	private int questionCategory;
	private String nickName;
	private Date regDate;
	private String reply;
	private Date reply_date;
	private String email;
	private String phoneNum;
	private int replyState;

}
