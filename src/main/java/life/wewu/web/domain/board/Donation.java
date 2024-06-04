package life.wewu.web.domain.board;

import java.sql.Date;

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
	
	public void Donation() {
		
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
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
	public String getUserBirth() {
		return userBirth;
	}
	public void setUserBirth(String userBirth) {
		this.userBirth = userBirth;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getBoardType() {
		return boardType;
	}
	public void setBoardType(int boardType) {
		this.boardType = boardType;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public int getPayOption() {
		return payOption;
	}
	public void setPayOption(int payOption) {
		this.payOption = payOption;
	}
	public int getPayAmount() {
		return payAmount;
	}
	public void setPayAmount(int payAmount) {
		this.payAmount = payAmount;
	}
	
	@Override
	public String toString() {
		return "Donation [userName=" + userName + ", email=" + email + ", phoneNum=" + phoneNum + ", userBirth="
				+ userBirth + ", boardNo=" + boardNo + ", boardType=" + boardType + ", regDate=" + regDate
				+ ", payOption=" + payOption + ", payAmount=" + payAmount + "]";
	}
	
}
