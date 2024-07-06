package life.wewu.web.service.board.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import io.micrometer.core.instrument.search.Search;
import life.wewu.web.domain.board.Board;
import life.wewu.web.domain.board.BoardFile;
import life.wewu.web.domain.board.Bookmark;
import life.wewu.web.domain.board.Comment;
import life.wewu.web.domain.board.Donation;
import life.wewu.web.domain.board.Question;
import life.wewu.web.service.board.BoardService;

@SpringBootTest
public class BoardServiceTest {
	
	@Autowired
	@Qualifier("boardService")
	private BoardService boardService;


	/*
	 * Board
	 */
	//@Test
	public void testAddBoard() throws Exception{
		Board board = Board.builder()
						.boardType(1)
						.nickName("nick1")
						.title("테스트 제목 new")
						.userGroupNo(1)
						.contents("테스트 내용 new")
						.build();
		boardService.addBoard(board);
		System.out.println("=======================\n");
	}
	
	//@Test
	public void testDeleteBoard() throws Exception{
		boardService.deleteBoard(1);
		
		Board board  = boardService.getBoard(1);
		
		System.out.println("board Domain :: "+ board);
		
		System.out.println("=======================\n");
	
	}
	
	//@Test
	public void testUpdateBoard() throws Exception{
		System.out.println("\n===================================");
		
		Board board = Board.builder()
				.boardNo(2)
				.boardType(1)
				.nickName("nick1")
				.title("테스트 제목 update2")
				.userGroupNo(1)
				.contents("테스트 내용 update2")
				.build();
		
		boardService.updateBoard(board);
		
		System.out.println("board Domain :: "+boardService.getBoard(2));

	}
	
	//@Test
	public void testGetBoard() throws Exception{
		System.out.println("\n===================================");
		
		Board board = boardService.getBoard(3);
		System.out.println("getBoard :: "+ board);
	}
	
	//@Test
	public void testGetBoardList() throws Exception{
		System.out.println("\n===================================");
		
		life.wewu.web.common.Search search = new life.wewu.web.common.Search();
		search.setSearchCondition("0");
		search.setSearchKeyword("update");
		int bordType = 1;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("boardType", bordType);
		
		List<Board> list = boardService.getBoardList(map);
		System.out.println("getBoardList :: "+list);
		
		
	}
	
	//@Test
		public void testGetTotalCount() throws Exception{
			System.out.println("\n===================================");
			
			life.wewu.web.common.Search search = new life.wewu.web.common.Search();
			search.setSearchCondition("0");
			search.setSearchKeyword("update");
			int bordType = 1;
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("search", search);
			map.put("boardType", bordType);
			
			int cnt = boardService.getTotalCount(map);
			System.out.println("getBoardList :: "+cnt);
						
		}
	
		/*
		 * BoardFile
		 */
		//@Test
		public void testAddBoardFile() throws Exception{
			BoardFile boardfile = BoardFile.builder()
							.boardNo(3)
							.fileName("addfile")
							.fileUUID("234sdf")
							.fileExt(".jpg")
							.build();
			boardService.addBoardFile(boardfile);
			System.out.println("=======================\n");
		}
		
		//@Test
		public void testDeleteBoardFile() throws Exception{
			boardService.deleteBoardFile(1);
			
			
			
			List<BoardFile> file  = boardService.getBoardFileList(1);
			
			System.out.println("삭제 확인 :: "+ file);
			
			System.out.println("=======================\n");
		
		}
		
		//@Test
		public void testUpdateBoardFile() throws Exception{
			System.out.println("\n===================================");
			
			BoardFile file = BoardFile.builder()
					.fileName("updateFile")
					.fileUUID("uu")
					.fileExt(".txt")
					.fileNo(5)
					.build();
			
			boardService.updateBoardFile(file);
			
			System.out.println("testUpdateBoardFile :: "+boardService.getBoardFileList(3));

		}
		
		//@Test
		public void testGetBoardFile() throws Exception{
			System.out.println("\n===================================");
			
			//int file = boardService.getBoardFile(3);
			//System.out.println("getBoardFile :: "+ file);
		}
		
		//@Test
		public void testGetBoardListFile() throws Exception{
			System.out.println("\n===================================");
			
			int boarNo = 2;
			
			List<BoardFile> list = boardService.getBoardFileList(boarNo);
			System.out.println("getBoardFileList :: "+list);	
			
		}
		
		
		/*
		 * Bookmark
		 */
		//@Test
		public void testAddBookmark() throws Exception{
			Bookmark mark = Bookmark.builder()
							.boardNo(2)
							.nickName("nick1")
							.build();
			boardService.addBookmark(mark);
			System.out.println("=======================\n");
		}
		
		//@Test
		public void testDeleteBookmark() throws Exception{
			boardService.deleteBookmark(2);
			

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("boardType", 1);
			map.put("nickName", "nick1");
			
			List<Board> mark  = boardService.getBookmarkList(map);
			
			System.out.println("=======================\n");
		
		}
			
		
		//@Test
		public void testGetBookmarkList() throws Exception{
			System.out.println("\n===================================");
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("boardType", 1);
			map.put("nickName", "nick1");
			
			List<Board> mark  = boardService.getBookmarkList(map);
			
			System.out.println("getBoardFileList :: "+mark);	
			
		}
		
		//@Test
		public void testGetBookmarkCnt() throws Exception{
			System.out.println("\n==============");
			
			System.out.println("bookmarkCnt :: "+ boardService.getBookmarkCnt(2));
		}
		
		
		/*
		 * Comment
		 */
		
		//@Test
		public void testAddComment() throws Exception{
			System.out.println("\n===================");
			
			Comment comment = Comment.builder()
								.boardNo(3)
								.commentNickName("nick2")
								.commentContents("댓글 내용test")
								.build();
			
			boardService.addComment(comment);
		}
		
		//@Test
		public void testDeleteComment() throws Exception{
			boardService.deleteComment(1);
			
			
			
			List<Comment> comment  = boardService.getCommentListByBoard(2);
			
			System.out.println("삭제 확인 :: "+ comment);
			
			System.out.println("=======================\n");
		}
		
		//@Test
		public void testUpdateComment() throws Exception{
			System.out.println("\n===================");
			
			Comment comment = Comment.builder()
								.commentNickName("nick3")
								.commentContents("댓글 내용 update")
								.commentNo(2)
								.build();
			
			boardService.updateComment(comment);
			
			System.out.println("testupdateComment :: "+comment+"\n");
		}
		
		//@Test
		public void testGetCommenListByBoard() throws Exception{
			System.out.println("\n===============================");
			List<Comment> comment  = boardService.getCommentListByBoard(3);
							
			System.out.println("testGetCommentCnt :: "+ comment);
			
			System.out.println("=================================\n");
		}		
		
		//@Test
		public void testGetCommentListByNic() throws Exception{
			System.out.println("\n===============================");
			List<Comment> comment  = boardService.getCommentListByNic("nick3");
			
			System.out.println("testGetCommentListByNic - nick3 :: "+ comment);
			System.out.println("\n===============================");
		}
		
		//@Test
		public void testGetCommentCnt() throws Exception{
			System.out.println("\n===============================");
			System.out.println("testGetCommentCnt :: "+ boardService.getCommentCnt(2));
		}
		
		
		/*
		 * question
		 */
		//@Test
		public void testAddQuestion() throws Exception{
			System.out.println("\n================================");
			
			Question q = Question.builder()
						.nickName("nick1")
						.questionType("문의")
						.questionCategory("배송문의")
						.title("배송문의test")
						.contents("test")
						.build();
			boardService.addQuestion(q);
		}
		
		//@Test
		public void testUpdateReply() throws Exception{
			System.out.println("\n================================");
			
			Question q = Question.builder()
					.reply("답변내용")
					.questionNo(2)
					.build();
			
			boardService.updateReply(q);
		}
		
		//@Test//////////
		public void testGetQuestionById() throws Exception{
			System.out.println("\n===================================");
			
			Question q = boardService.getQuestionById(2);
			
			System.out.println(q);
			
			System.out.println("====================================\n");
		}
		
		//@Test//////////////////////
		public void testGetQuestionList() throws Exception{
			System.out.println("\n===================================");
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("questionNo", 2);
			map.put("questionType", "문의");
					
			
			List<Question> list= boardService.getQuestionList(map);
			
			System.out.println("questionList :: "+list);
			
			System.out.println("====================================\n");
		}
		
		
		/*
		 * Donation
		 */
		
		//@Test
		public void testAddDonation() throws Exception{
			System.out.println("\n=======================================");
			Donation d = Donation.builder()
						.userName("이름")
						.payOption("2")
						.payType("1")
						.userBirth("20240608")
						.phoneNum("010-0000-0000")
						.email("test@naver.com")
						.payAmount(10000)
						.payFlag("2")
						.build();
			
			boardService.addDonation(d);
		}
		
		//@Test
		public void testDeleteDonation() throws Exception{
			System.out.println("\n================================");
			boardService.deleteDonation(1);
		}
		
		//@Test
		public void testGetDonationById() throws Exception{
			System.out.println("\n=================================");
			Donation d = boardService.getDonationById(2);
			System.out.println("getDonation :: "+d);
		}
		
		//@Test
		public void testGetDonationList() throws Exception{
			System.out.println("\n================================");
			
			//List<Donation> list = boardService.getDonationList("1");
			
			//System.out.println("testGetDonationList :: "+list);
		}
		
}
