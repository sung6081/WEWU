package life.wewu.web.domain.board;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Donation {
	private String userName;
	private String email;
	private String phoneNum;
	private String userBirth;
	private int boardNo;
	private int boardType;
	private Date regDate;
	private int payOption;
	private int payAmount;

}