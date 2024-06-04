package life.wewu.web.domain.plant;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Plant {
	
	//field

	private int plantNo;		//식물식별번호
	private int plantLevlNo;	//식물단계식별번호
	private String plantName;	//식물이름
	private String plantLevl;	//식물단계
	private String plantImg;	//식물단계별이미지
	private int plantMaxExp;	//식물단계별최대경험치
	private int plantMinExp;	//식물단계별최소경험치
	
}
