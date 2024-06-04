//24.06.03 ¿€º∫

package life.wewu.web.service.user;

import java.util.List;

import life.wewu.web.domain.user.User;


public interface UserDao {
	
	public void addUser(User user);
	
	public void updateUser(User user);
	
	public void deleteUser(String userId);
	
	public  List<User> getUserList();
	
	public User getUser(String userId);
	
	public User authUser(String userId, String password);
	
	public void updateAdmin(User user);
	
	public String findUserId(String email);
	
    public String findUserPwd(String userId);
    
    public void quitUser(String userId);
    
    public boolean checkUserId(String userId);
    
    public boolean checkNickName(String nickname);
    
    public boolean checkErrorUserId(String userId);
    
    public boolean checkErrorNickName(String nickname);
    
    public boolean checkSecUserPwd(String userId, String securityPwd);
    
    public boolean checkSameUserPwd(String userId, String password);
}


