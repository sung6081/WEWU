//24.06.03 작성

package life.wewu.web.service.user;

import java.util.List;

import life.wewu.web.domain.user.User;


public interface UserService {
	
	//회원가입
	public void addUser(User user) throws Exception;
    
	//내정보수정
	public void updateUser(User user) throws Exception;
    
	//관리자 사용자 삭제
	public  void deleteUser(String userId) throws Exception;
    
	//관리자가 유저 목록 확인
	public List<User> getUserList() throws Exception;
    
	//관리자가 유저 상세보기
	public User getUser(String userId) throws Exception;
    
	//로그인
	public User login(User user) throws Exception;
    
	//관리자가 사용자 상세보기시 수정
	public void updateAdmin(User user) throws Exception;
    
	//사용자 아이디 찾기
	public String findUserId(String phoneNum) throws Exception;
    
	//사용자 비밀번호 찾기
	public String findUserPwd(String userId) throws Exception;
    
	//회원가입시 사용자 아이디 중복체크
	public boolean checkUserId(String userId) throws Exception;
    
	//회원가입시 사용자 닉네임 중복체크
	public boolean checkNickName(String nickname) throws Exception;
    
	//sms인증
	public User authUser(String userId, String password) throws Exception;

}
