package life.wewu.web.domain.active;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ActiveHash {

	//필드
	private int hashNo;//해쉬태그 번호
	private int activeNo;//어느 활동의 해쉬태그인지 활동 번호
	private String hashName;//해쉬태그 이름
	
}
