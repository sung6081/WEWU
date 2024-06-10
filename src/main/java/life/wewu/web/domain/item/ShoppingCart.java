/* Shopping Cart의 도메인
*
*
*/

package life.wewu.web.domain.item;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class ShoppingCart {
	private int shoppingCartNo;//장바구니 번호
    private String nickname; //사용자 닉네임
    private String itemName; //아이템 이름
    private int itemNo; //아이템 번호
    private int itemCnt; //아이템 개수
    private int itemPrice; //아이템 가격
    private String itemImg; //아이템 이미지
    
}
