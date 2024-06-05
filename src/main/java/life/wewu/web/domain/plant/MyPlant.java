package life.wewu.web.domain.plant;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MyPlant {
	
	//field
	
	private int myPlantNo; 			//나의식물식별번호
	private String myPlantState;	//나의식물상태(Y,N)
	private String myPlantName;		//나의식물이름
	private int myPlantExp;			//나의식물경험치
	private Date plantStartDate;	//나의식물키우기시작한날짜
	private Date plantEndDate;		//나의식물종료날짜
	private String myPlantLevl;		//나의식물현재단계
	private int inventoryNo;		//인벤토리식별번호
	private int itemNo;				//아이템식별번호
	private String itemState;		//아이템상태(Y,N)
	private String itemType;		//아이템카테고리
	private int itemNum;			//가지고있는아이템수
	private int weatherNo;
	private String weatherImg;
}