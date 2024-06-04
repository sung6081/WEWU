package life.wewu.web.domain.board;

import java.sql.Date;

public class Comment {
	private int commentNo;
	private int boardNo;
	private String commentNickName;
	private String commentContents;
	private Date commentDate;
	
	public void Comment() {
		
	}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getCommentNickName() {
		return commentNickName;
	}

	public void setCommentNickName(String commentNickName) {
		this.commentNickName = commentNickName;
	}

	public String getCommentContents() {
		return commentContents;
	}

	public void setCommentContents(String commentContents) {
		this.commentContents = commentContents;
	}

	public Date getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}

	@Override
	public String toString() {
		return "Comment [commentNo=" + commentNo + ", boardNo=" + boardNo + ", commentNickName=" + commentNickName
				+ ", commentContents=" + commentContents + ", commentDate=" + commentDate + "]";
	}
	
}
