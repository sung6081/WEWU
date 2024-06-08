//24.06.03 ¿€º∫

package life.wewu.web.service.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.domain.user.User;

@Mapper
public interface UserDao {
	
	public void addUser(User user) throws Exception;
	
	public void updateUser(User user) throws Exception;
	
	public void deleteUser(String userId) throws Exception;
	
	public  List<User> getUserList() throws Exception;
	
	public User getUser(String userId) throws Exception;
	
	public void updateAdmin(User user) throws Exception;
	
	public User findUserId(Map<String, Object> params) throws Exception;
	
    public String findUserPwd(String userId) throws Exception;
    
    public User findUserPwd(Map<String, Object> params) throws Exception;
    
    public void updatePassword(String userId, String newPassword) throws Exception;
    
    public boolean checkUserId(String userId) throws Exception;
    
    public boolean checkNickName(String nickname) throws Exception;
    

}


