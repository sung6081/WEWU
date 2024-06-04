package life.wewu.web.service.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.domain.board.Board;
import life.wewu.web.domain.board.Bookmark;

@Mapper
public interface BoardDao {
	
	public void addBookmark(Bookmark bookmark) throws Exception;
	
	public void deleteBookmark(int bookmarkNo) throws Exception;
	
	public List<Board> getBookmarkList(int boardType, String nickname) throws Exception;
	

}
