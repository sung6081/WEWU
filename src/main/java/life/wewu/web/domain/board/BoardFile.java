package life.wewu.web.domain.board;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class BoardFile {
	private int fileNo;
	private int boardNo;
	private String fileName;
	private String fileUUID;
	private String fileExt;
}
