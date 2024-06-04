//24.06.03 작성

package life.wewu.web.service.user.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import life.wewu.web.domain.user.User;
import life.wewu.web.service.user.UserDao;
import life.wewu.web.service.user.UserService;

import java.util.List;

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
    public void addUser(User user) {
        userDao.addUser(user);
    }

    public void updateUser(User user) {
        userDao.updateUser(user);
    }

    public void deleteUser(String userId) {
        userDao.deleteUser(userId);
    }

    public List<User> getUserList() {
        return userDao.getUserList();
    }

    public User getUser(String userId) {
        return userDao.getUser(userId);
    }

    public User authUser(String userId, String password) {
        return userDao.authUser(userId, password);
    }


    // 로그인 로직 추가
    public User login(User user){
        User dbUser = userDao.getUser(user.getUserId());
        if (dbUser != null && user.getUserPwd().equals(dbUser.getUserPwd())) {
            return dbUser;
        }
        return null;
    }

    public void updateAdmin(User user) {
        userDao.updateAdmin(user);
    }

    public String findUserId(String email) {
        return userDao.findUserId(email);
    }

    public String findUserPwd(String userId) {
        return userDao.findUserPwd(userId);
    }

    public void quitUser(String userId) {
        userDao.quitUser(userId);
    }

    public boolean checkUserId(String userId) {
        return userDao.checkUserId(userId);
    }

    public boolean checkNickName(String nickname) {
        return userDao.checkNickName(nickname);
    }

    public boolean checkErrorUserId(String userId) {
        return userDao.checkErrorUserId(userId);
    }

    public boolean checkErrorNickName(String nickname) {
        return userDao.checkErrorNickName(nickname);
    }

    public boolean checkSecUserPwd(String userId, String securityPwd) {
        return userDao.checkSecUserPwd(userId, securityPwd);
    }

    public boolean checkSameUserPwd(String userId, String password) {
        return userDao.checkSameUserPwd(userId, password);
    }
}

