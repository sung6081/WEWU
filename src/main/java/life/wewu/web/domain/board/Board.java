package life.wewu.web.domain.board;

import java.sql.Date;

public class Board {
	
	private String title;
	private String file;
	private String contents;
	private int boardType;
	private int boardNo;
	private int memberNo;//
	private String nickName;
	private Date regDate;
	private String thumnail;
	private int bookmarkCnt;
	private boolean bookmarkFlag;
	private int views;
	private int commentCnt;
	private String comment;
	
	public Board() {
		
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
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

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
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

	public String getThumnail() {
		return thumnail;
	}

	public void setThumnail(String thumnail) {
		this.thumnail = thumnail;
	}

	public int getBookmarkCnt() {
		return bookmarkCnt;
	}

	public void setBookmarkCnt(int bookmarkCnt) {
		this.bookmarkCnt = bookmarkCnt;
	}

	public boolean isBookmarkFlag() {
		return bookmarkFlag;
	}

	public void setBookmarkFlag(boolean bookmarkFlag) {
		this.bookmarkFlag = bookmarkFlag;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public int getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	@Override
	public String toString() {
		return "Board [title=" + title + ", file=" + file + ", contents=" + contents + ", boardType=" + boardType
				+ ", boardNo=" + boardNo + ", memberNo=" + memberNo + ", nickName=" + nickName + ", regDate=" + regDate
				+ ", thumnail=" + thumnail + ", bookmarkCnt=" + bookmarkCnt + ", bookmarkFlag=" + bookmarkFlag
				+ ", views=" + views + ", commentCnt=" + commentCnt + ", comment=" + comment + "]";
	}

}
