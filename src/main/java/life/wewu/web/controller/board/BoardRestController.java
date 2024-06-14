package life.wewu.web.controller.board;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import life.wewu.web.domain.board.Board;
import life.wewu.web.domain.board.Bookmark;
import life.wewu.web.domain.board.Question;
import life.wewu.web.domain.user.User;
import life.wewu.web.service.board.BoardService;

@RestController
@RequestMapping(value = "/app/board/*")
public class BoardRestController {
	
	//필드
	@Autowired
	@Qualifier("boardService")
	private BoardService boardService;
	
	@PostMapping(value = "addBookmark")
	public void addBookmark (@RequestBody Board board,@ModelAttribute("bookmark") Bookmark bookmark,
			HttpSession session) throws Exception{
		System.out.println("addBookmark");
		
		//session nullcheck
		String sessioString = ((User)session.getAttribute("nickname")).getNickname();
		
		bookmark.setBoardNo(board.getBoardNo());
		bookmark.setNickName(sessioString);
		
		boardService.addBookmark(bookmark);

	}
	
	@GetMapping(value = "deleteBookmark")
	public void deleteBookmark() {
		
	}
	
}
