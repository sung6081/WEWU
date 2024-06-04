/* Shopping Cart의 도메인
*
*
*/

package life.wewu.web.domain.item;

import lombok.Data;
import java.sql.Date;

public class ShoppingCart {
	private int shoppingCartNo;//장바구니 번호
    private String nickname; //사용자 닉네임
    private int itemNo; //아이템 번호
    private int itemCnt; //아이템 개수
	}
	