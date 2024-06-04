//24.06.03 ¿€º∫

package life.wewu.web.service.user;

import java.util.List;

import life.wewu.web.domain.user.User;


public interface UserDao {
	
	public void addUser(User user) throws Exception;
	
	public void updateUser(User user) throws Exception;
	
	public void deleteUser(String userId) throws Exception;
	
	public  List<User> getUserList() throws Exception;
	
	public User getUser(String userId) throws Exception;
	
	public void updateAdmin(User user) throws Exception;
	
	public String findUserId(String phoneNum) throws Exception;
	
    public String findUserPwd(String userId) throws Exception;
    
    public boolean checkUserId(String userId) throws Exception;
    
    public boolean checkNickName(String nickname) throws Exception;
    
    public User authUser(String userId, String password) throws Exception;

}


