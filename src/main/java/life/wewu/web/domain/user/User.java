//24.06.03 ¿€º∫
package life.wewu.web.domain.user;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {
    private String userId;
    private String email;
    private String phoneNum;
    private String residentNum;
    private String nickname;
    private String userPwd;
    private String addr;
    private String getAddr;
    private String gender;
    private Integer currentPoint;
    private String role;
    private String userName;
}

