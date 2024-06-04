package life.wewu.web.domain.board;

import java.sql.Date;

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
//	private String searchKeyword;
//	private String searchCondition;
	
	public void Question() {
		
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getQuestionType() {
		return questionType;
	}
	public void setQuestionType(int questionType) {
		this.questionType = questionType;
	}
	public int getBoardType() {
		return boardType;
	}
	public void setBoardType(int boardType) {
		this.boardType = boardType;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public int getReplyState() {
		return replyState;
	}
	public void setReplyState(int replyState) {
		this.replyState = replyState;
	}
	
	@Override
	public String toString() {
		return "Question [title=" + title + ", contents=" + contents + ", questionType=" + questionType + ", boardType="
				+ boardType + ", boardNo=" + boardNo + ", nickName=" + nickName + ", regDate=" + regDate + ", reply="
				+ reply + ", email=" + email + ", phoneNum=" + phoneNum + ", replyState=" + replyState + "]";
	}
	
	

}
