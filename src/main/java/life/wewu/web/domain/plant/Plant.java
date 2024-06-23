package life.wewu.web.domain.plant;

import com.fasterxml.jackson.annotation.JsonCreator;

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

	private int plantNo;		 //식물식별번호
	private String plantName;	 //식물이름
	private PlantLevl plantLevl; //PlantLevl
	private String value;

	public Plant(String value) {
        this.value = value;
    }
	
}
