//24.06.03 작성

package life.wewu.web.service.user.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import life.wewu.web.domain.user.User;
import life.wewu.web.service.user.UserDao;
import life.wewu.web.service.user.UserService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

//==> 회원관리 서비스 구현
@Service("userServiceImpl")
public class UserServiceImpl implements UserService {

	//Field
    @Autowired
    @Qualifier("userDao")
    private UserDao userDao;
    
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	///Constructor
	public UserServiceImpl() {
		System.out.println(this.getClass());
	}
	
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

    public List<User> getUserList() throws Exception{
        return userDao.getUserList();
    }

    public User getUser(String userId) throws Exception{
        return userDao.getUser(userId);
    }

    // 로그인 로직 추가
    public User login(User user) throws Exception {
        User dbUser = userDao.getUser(user.getUserId());
        if (dbUser != null) {
            // Check if the user's role is 4
            if (dbUser.getRole() == ("4")) {
                throw new Exception("삭제처리 되었습니다.");
            }

            // Check if the password matches
            if (user.getUserPwd().equals(dbUser.getUserPwd())) {
                return dbUser;
            }
        }
        return null;
    }


    public void updateAdmin(User user) throws Exception{
        userDao.updateAdmin(user);
    }

	public User findUserId(String userName, String phoneNum) throws Exception{
		   Map<String, Object> params = new HashMap<>();
	        params.put("name", userName);
	        params.put("phone", phoneNum);
	        return userDao.findUserId(params);
	    }

    public User findUserPwd(String userId, String phone) throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put("username", userId);
        params.put("phone", phone);
        return userDao.findUserPwd(params);
    }

    public void updatePassword(String userId, String newPassword) throws Exception {
    	userDao.updatePassword(userId, newPassword);
    }

    //사용자 아이디 중복체크
    public boolean checkUserId(String userId) throws Exception {
        return !userDao.checkUserId(userId);
    }
    
  //사용자 닉네임 중복체크
    public boolean checkNickName(String nickName) throws Exception {
    	return !userDao.checkNickName(nickName);
    }
    
    public ResponseEntity<String> sendSms(String to) {
        try {
            boolean result = smsService.sendSms(to);
            if (!result) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("메시지 전송 중 예외가 발생했습니다.");
            }
            return ResponseEntity.ok("메시지 전송에 성공했습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("메시지 전송 중 예외가 발생했습니다.");
        }
    }
    
}

