package life.wewu.web.domain.plant;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PlantRequest {
	
	//field
	@JsonProperty("plantNo")
	private int plantNo;

	@JsonProperty("plant")
    private Plant plant;

    @JsonProperty("plantLevl")
    private PlantLevl plantLevl;
    
    @JsonProperty("myPlantNo") 
    private int myPlantNo;


	}
	

	

