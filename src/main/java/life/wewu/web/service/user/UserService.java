//24.06.03 작성

package life.wewu.web.service.user;

import java.util.List;

import life.wewu.web.domain.user.User;


public interface UserService {
	
	//회원가입
	public void addUser(User user);
    
	//내정보수정
	public void updateUser(User user);
    
	//관리자 사용자 삭제
	public  void deleteUser(String userId);
    
	//관리자가 유저 목록 확인
	public List<User> getUserList();
    
	//관리자가 유저 상세보기
	public User getUser(String userId);
    
	//sms인증
	public User authUser(String userId, String password);
    
	//로그인
	public User login(User user);
    
	//관리자가 사용자 상세보기시 수정
	public void updateAdmin(User user);
    
	//사용자 아이디 찾기
	public String findUserId(String email);
    
	//사용자 비밀번호 찾기
	public String findUserPwd(String userId);
    
	//사용자 탈퇴하기
	public void quitUser(String userId);
    
	//회원가입시 사용자 아이디 중복체크
	public boolean checkUserId(String userId);
    
	//회원가입시 사용자 닉네임 중복체크
	public boolean checkNickName(String nickname);
    
	//회원가입시 사용자 아이디 형식에 맞는지 체크
	public boolean checkErrorUserId(String userId);
    
	//회원가입시 사용자 닉네임 형식에 맞는지 체크
	public boolean checkErrorNickName(String nickname);
    
	//회원가입시 사용자 비밀번호에 영문,숫자, 특수기호가 포함되어있는지 체크
	public boolean checkSecUserPwd(String userId, String securityPwd);
    
	//회원가입시 사용자가 비밀번호칸 2개에 똑같이 적었는지 체크
	public boolean checkSameUserPwd(String userId, String password);

}
