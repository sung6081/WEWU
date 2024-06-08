package life;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.PropertySource;

@SpringBootApplication
@PropertySource(value="classpath:static/common/common.properties")
public class WewuApplication {

	public static void main(String[] args) {
		SpringApplication.run(WewuApplication.class, args);
	}

}