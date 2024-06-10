//24.06.03 작성

package life.wewu.web.service.user.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;


import life.wewu.web.common.Search;
import life.wewu.web.domain.user.User;
import life.wewu.web.service.user.SmsService;
import life.wewu.web.service.user.UserDao;
import life.wewu.web.service.user.UserService;
import lombok.RequiredArgsConstructor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

//==> 회원관리 서비스 구현
@Service("userServiceImpl")
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

	//Field
	
    @Qualifier("userDao")
	private final UserDao userDao;
	
	@Qualifier("smsService")
	private final SmsService smsService;
    
	private Map<String, String> verificationCodes = new HashMap<>();
	
	///Method
    public void addUser(User user) throws Exception{
        userDao.addUser(user);
    }

    public void updateUser(User user) throws Exception{
        userDao.updateUser(user);
    }

    public void deleteUser(String userId) throws Exception{
        userDao.deleteUser(userId);
    }

    public List<User> getUserList(Search search) throws Exception {
        return userDao.getUserList(search);
    }

    public User getUser(String userId) throws Exception{
        return userDao.getUser(userId);
    }

    // 로그인 로직 추가
    public User login(User user) throws Exception {
        if (user == null || user.getUserId() == null) {
            throw new IllegalArgumentException("유효하지 않은 사용자 정보입니다.");
        }
        System.out.println("로그인 시도 사용자 ID: " + user.getUserId());
        User dbUser = userDao.getUser(user.getUserId());
        if (dbUser != null) {
            // Check if the user's role is 4
        	System.out.println("DB 사용자 ID: " + dbUser.getUserId());
            System.out.println("DB 사용자 Role: " + dbUser.getRole());
            if ("4".equals(dbUser.getRole())) {
                throw new Exception("삭제처리 되었습니다.");
            }

            // Check if the password matches
            if (user.getUserPwd() != null && user.getUserPwd().equals(dbUser.getUserPwd())) {
            	System.out.println("비밀번호 일치");
            	return dbUser;
            }else {
                System.out.println("비밀번호 불일치");
            }
        }else {
            System.out.println("사용자를 찾을 수 없음");
        }
        return null;
    }

    public void updateAdmin(User user) throws Exception{
        userDao.updateAdmin(user);
    }

    //사용자 아이디 중복체크
	public boolean checkUserId(String userId) throws Exception {
	    return userDao.checkUserId(userId);
	}
    
  //사용자 닉네임 중복체크
    public boolean checkNickName(String nickName) throws Exception {
    	return userDao.checkNickName(nickName);
    }
    
    //사용자 아이디 찾기
    public User findUserId(String phoneNum, String userName) throws Exception {
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	map.put("phoneNum", phoneNum);
    	map.put("userName", userName);
    	
        User user = userDao.findUserId(map);
        if (user != null) {
            System.out.println("User found:" + user.getUserId());
        } else {
            System.out.println("User not found with phoneNum:" + phoneNum + ", userName:" + userName);
        }
        return user;
    }
    
    //인증번호 전화번호 맵핑
    public String sendVerificationCode(String phoneNum) {
        String verificationCode = smsService.sendVerificationCode(phoneNum);
        verificationCodes.put(phoneNum, verificationCode);
        return verificationCode;
    }
    
    //인증번호, 전화번호 + 알맞은 인증번호로 매핑
    public boolean verifyCode(String phoneNum, String code) {
        String correctCode = verificationCodes.get(phoneNum);
        System.out.println("verifyCode - phoneNum:" + phoneNum + ", inputCode:" + code + ", correctCode:" + correctCode);
        return correctCode != null && correctCode.equals(code);
    }
    
    //문자 송신시 코드 생성되는데 verificationCodes로 인증번호 저장한거 가져오는 메소드
    public Map<String, String> getVerificationCodes() {
        return verificationCodes;
    }
    
    //인증번호 testCode화
    public String sendTestVerificationCode(String phoneNum) {
        String verificationCode = smsService.generateTestVerificationCode();
        verificationCodes.put(phoneNum, verificationCode);
        return verificationCode;
    }
    
    //사용자 비밀번호 찾기
	public User findUserPwd(String phoneNum, String userId) throws Exception {
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	map.put("phoneNum", phoneNum);
    	map.put("userId", userId);
    	
        User user = userDao.findUserPwd(map);
        if (user != null) {
            System.out.println("User found:" + user.getUserId());
        } else {
            System.out.println("User not found with phoneNum:" + phoneNum + ", userId:" + userId);
        }
        return user;
    }
	
	//사용자 비밀번호 변경
	public void updatePwd(User user) throws Exception {
        userDao.updatePwd(user);
	}
}

