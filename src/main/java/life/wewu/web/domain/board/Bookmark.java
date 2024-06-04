package life.wewu.web.domain.board;

public class Bookmark {
	private int bookmark;
	private int boardType;
	private int boardNo;
	private String nickName;
	private boolean bookmarkflag;
	
	public void Bookmark() {
		
	}

	public int getBookmark() {
		return bookmark;
	}

	public void setBookmark(int bookmark) {
		this.bookmark = bookmark;
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

	public boolean isBookmarkflag() {
		return bookmarkflag;
	}

	public void setBookmarkflag(boolean bookmarkflag) {
		this.bookmarkflag = bookmarkflag;
	}

	@Override
	public String toString() {
		return "Bookmark [bookmark=" + bookmark + ", boardType=" + boardType + ", boardNo=" + boardNo + ", nickName="
				+ nickName + ", bookmarkflag=" + bookmarkflag + "]";
	}

}
