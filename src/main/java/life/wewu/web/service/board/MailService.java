package life.wewu.web.service.board;

import java.util.Properties;

import javax.mail.Session;

public interface MailService {
	public Session setting(Properties props, String user_name, String password);
	
	public void goMail(Session session, String title, String content, String to);

}
