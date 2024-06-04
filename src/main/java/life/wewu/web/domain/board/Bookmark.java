/*
 *	작성자: 최지원
 *	작성일: 2024-06-04 
 */
package life.wewu.web.domain.board;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Bookmark {
	
	//필드
	private int bookmarkNo;			//pk 북마크 번호		//
	private int boardNo;
	private String nickName;
	
}
