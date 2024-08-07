/*
 * 작성자 : 최지원
 * 작성일 : 2024-06-09
 */
package life.wewu.web.controller.board;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


import life.wewu.web.common.Page;
import life.wewu.web.common.Search;
import life.wewu.web.domain.board.Board;
import life.wewu.web.domain.board.BoardFile;
import life.wewu.web.domain.board.Bookmark;
import life.wewu.web.domain.board.Comment;
import life.wewu.web.domain.board.Donation;
import life.wewu.web.domain.board.Question;
import life.wewu.web.domain.user.User;
import life.wewu.web.repository.S3Repository;
import life.wewu.web.service.board.BoardService;
import life.wewu.web.service.board.MailService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	//필드
	@Autowired
	@Qualifier("boardService")
	private BoardService boardService;
	
	@Autowired
	@Qualifier("s3RepositoryImpl")
	private S3Repository s3Repository;
	
	@Autowired
	@Qualifier("mailService")
	private MailService mailService;
	
	@Value("${pageUnit}") //
	int pageUnit;

	@Value("${pageSize}") // 
	int pageSize;
	
	//메소드
	
	/*
	 * Board
	 */
	//게시글 등록 GET
	@GetMapping(value = "addBoard")
	public String addBoard(@RequestParam("boardType") int boardType) throws Exception{
		System.out.println("/board/addBoard : GET");
		
		return "forward:/board/addBoard.jsp?";
	}
	//게시글 등록 POST
	//게시글 등록 및 파일 등록(boardFile)
	//addBoard, addBoardFile
	@PostMapping(value = "addBoard")
	public String addBoard(@RequestParam("boardType") int boardType, @ModelAttribute("board") Board board,
			@ModelAttribute("boardFile") BoardFile boardFile,
			Model model, @RequestPart(required = false) List<MultipartFile> file) throws Exception{
		
		System.out.println("/board/addBoard : POST");
		
		board = boardService.addBoard(board);	//board 등록
		System.out.println("::::::::::;;"+board);
		
		
		if(file != null && file.size() != 0) {
			for(MultipartFile s:file) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("file", s);
				map.put("folderName", "board");
				
				String url = s3Repository.uplodaFile(map);
				
				boardFile.setFileName(s3Repository.getShortUrl(url));
				
				boardFile.setBoardNo(board.getBoardNo());
				boardService.addBoardFile(boardFile);	//boardFile등록
			}

		}else {
			System.out.println("-------파일 없음---------");
		}
		
		
		
		List<BoardFile> fileList = boardService.getBoardFileList(board.getBoardNo());	//boardfileList 출력
		
		//board.setThumnail(boardService.getBoardFile(board.getBoardNo()));
		
		int boardNo = board.getBoardNo();
		System.out.println(boardNo);
		System.out.println(":::::::::::::::::::::"+fileList.size());
		
		model.addAttribute("board", boardService.getBoard(boardNo));
		model.addAttribute("boardFile", fileList);
		
		return "redirect:/board/getBoard?boardType="+boardType+"&boardNo="+boardNo;
	}
	
	//게시글 삭제 GET
	//게시글에 포함된 파일, 댓글, 즐겨찾기까지 모두 삭제
	@GetMapping(value = "deleteBoard") //?boardType=""&boardNo=0
	public String deleteBoard(@RequestParam("boardType") int boardType, @RequestParam("boardNo") int boardNo ) throws Exception{
		
		System.out.println("/board/deleteBoard?boardType"+ boardType +" : GET");
		
		
		boardService.deleteBoardFile(boardNo);
		
		boardService.deleteComment(boardNo);
		boardService.deleteBookmark(boardNo);
		
		boardService.deleteBoard(boardNo);
		
		return "forward:/board/listBoard?boardType="+boardType;
	}
	
	//게시글 수정 GET
	//게시글에 포함된 첨부파일 정보도 출력
	@GetMapping(value = "updateBoard") //?boardType=""&boardNo=0
	public String updateBoard(@RequestParam("boardType") int boardType, 
			@RequestParam("boardNo") int boardNo, Model model,
			@ModelAttribute("boardFile") BoardFile boardFile,
			 @RequestPart(required = false) List<MultipartFile> file) throws Exception{
		System.out.println("/board/updateBoard : GET");
		
		Board board = boardService.getBoard(boardNo);
		
		if(file != null && file.size() != 0) {
			for(MultipartFile s:file) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("file", s);
				map.put("folderName", "board");
				
				String url = s3Repository.uplodaFile(map);
				
				boardFile.setFileName(s3Repository.getShortUrl(url));
				
				boardFile.setBoardNo(board.getBoardNo());
				boardService.addBoardFile(boardFile);	//boardFile등록
			}

		}else {
			System.out.println("-------파일 없음---------");
		}
		
		
		
		List<BoardFile> fileList = boardService.getBoardFileList(board.getBoardNo());	//boardfileList 출력
		
		model.addAttribute("board", board);
		model.addAttribute("boardFile", fileList);
		
		return "forward:/board/updateBoard.jsp";
	}
	
	//게시글 수정 POST
	//게시글에 포함된 첨부파일도 수정
	@PostMapping(value = "updateBoard")
	public String updateBoard(@RequestParam("boardType") int boardType, 
			@RequestParam("boardNo") int boardNo,
			@ModelAttribute("board") Board board,
			@ModelAttribute("boardFile") BoardFile boardFile) throws Exception{
		System.out.println("/board/updateBoard : POST");
		
		boardService.updateBoard(board);

		
		return "redirect:/board/getBoard?boardType="+boardType+"&boardNo="+boardNo;
	}
	
	//게시글 상세 조회 GET
	//게시글에 포함된 첨부파일-조회, 댓글 리스트 조회
	@GetMapping(value = "getBoard")
	public String getBoard(@RequestParam("boardType") int boardType, 
			@RequestParam("boardNo") int boardNo, Model model)throws Exception{
		System.out.println("/board/getBoard : GET");
		
		Board board = boardService.getBoard(boardNo);
		
		boardService.updateViews(boardNo);
		
		List<BoardFile> boardFile = boardService.getBoardFileList(boardNo);
		
		List<Comment> commentList = boardService.getCommentListByBoard(boardNo);//
		
		model.addAttribute("board", board);
		model.addAttribute("comment", commentList);
		model.addAttribute("boardFile", boardFile);
		
		return "forward:/board/getBoard.jsp";
	}
	
	//게시글 목록 조회 GET	//////////////////////////////
	//댓글 수, 즐겨찾기 수..?
	@GetMapping(value = "listBoard")
	public String getBoardList(@RequestParam("boardType") int boardType,Model model,@ModelAttribute("search") Search search, HttpSession session) throws Exception{
		
		
		System.out.println("/board/listBoard : GET");
		User user = (User) session.getAttribute("user");
		
		System.out.println("================"+user);
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchCondition("");
//		String keyword = search.getSearchKeyword() != null ?search.getSearchKeyword() : "";
//		search.setSearchKeyword(keyword);
		if (search.getSearchKeyword() == null || search.getSearchKeyword().isEmpty()) {
		    search.setSearchKeyword("");
		}
		 if (search.getSearchOrderBy() == null || search.getSearchOrderBy().isEmpty()) {
		        search.setSearchOrderBy("1"); // 기본값 설정
		    }
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("boardType", boardType);
		if (user != null) {
			map.put("nickName", user.getNickname());
		}
		map.put("offset", (search.getCurrentPage() - 1) * 8);
		
		System.out.println("::::: map :"+ map);
		
		int totalCount = boardService.getTotalCount(map);
		
		Page resultPage = new Page(search.getCurrentPage(), totalCount, pageUnit, pageSize);
		System.out.println("\n::::::::::::RESULT PAGE"+resultPage);
		
		
		List<Board> list = boardService.getBoardList(map);
		
//		for(Board board : list) {
//			System.out.println("::: board : "+board);
//		}
		
		List<BoardFile> fileName = boardService.getBoardFile(map);
		
		
		System.out.println("\n--lll"+list);
		System.out.println("|||--"+ fileName);
		System.out.println("|||--"+ search);
		System.out.println();
			
		model.addAttribute("list",list);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("file", fileName);
		
		return "forward:/board/listBoard.jsp";
	}

	/*
	 * Donation
	 */
	//후원 등록 GET
	@GetMapping(value = "addDonation")
	public String addDonation() throws Exception{
		System.out.println("/board/addDonation : GET");
		return "forward:/board/addDonation.jsp";
	}
	
	//후원 등록 POST
	@PostMapping(value = "addDonation")
	public String addDonation(@ModelAttribute("donation") Donation donation
			,Model model
			,@RequestParam("payType") String payType) throws Exception{
		System.out.println("/board/addDonation : POST");
		
		donation = boardService.addDonation(donation);
		
		model.addAttribute("donation", donation);
		
		return "redirect:/board/getDonation?payType="+payType+"payNo="+donation.getPayNo();
	}
	
	//후원 내역 삭제 GET
	@GetMapping(value = "deleteDonation")//?payType=""&payNo=""
	public String deleteDonation(@RequestParam("payNo") int payNo
			,@RequestParam("payType")String payType) throws Exception{
		System.out.println("/board/deleteDonation : GET");
		boardService.deleteDonation(payNo);
		return "forward:/board/listDonation?payType="+payType;
	}
	
	//후원 내역 상세보기
	@GetMapping(value = "getDonation")
	public String getDonation(@RequestParam("payNo") int payNo
			,@RequestParam("payType")String payType,
			Model model) throws Exception{
		System.out.println("/board/getDonation : GET");
		
		Donation donation = boardService.getDonationById(payNo);
		
		model.addAttribute("donation", donation);
		
		return "forward:/board/getDonation.jsp";
	}
	
	//후원 내역 목록 보기
	@GetMapping(value = "listDonation")
	public String getDonationList(@RequestParam("payType")String payType,
			Model model,@ModelAttribute Search search
			) throws Exception{
		System.out.println("/board/getDonationList : GET");
		
		System.out.println(":::::: search_donation : "+search);
		
		
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchCondition("");
		//search.setSearchKeyword("");
		if (search.getSearchKeyword() == null || search.getSearchKeyword().isEmpty()) {
		    search.setSearchKeyword("");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		//map.put("questionType",questionType);
		//map.put("questionType", "문의");
		map.put("offset", (search.getCurrentPage() - 1) * 8);
		map.put("search", search);
		map.put("payType", payType);
		
		
		int totalCount = boardService.getTotalCountD(map);
		Page resultPage = new Page(search.getCurrentPage(), totalCount, pageUnit, pageSize);
		System.out.println("\n::::::::::::RESULT PAGE"+resultPage);
		
		List<Donation> list = boardService.getDonationList(map);
		System.out.println(":::::::::::::;"+list.size());
		model.addAttribute("list",list);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/board/listDonation.jsp";
	}
	
	/*
	 * Question 
	 */
	
	//문의 등록 GET
	@GetMapping(value = "addQuestion")
	public String addQuestion(@RequestParam("questionType")String questionType) throws Exception{
		
		System.out.println("/board/addQuestion : GET");
		
		return "forward:/board/addQuestion.jsp";
	}
	
	//문의 등록 POST
	@PostMapping(value="addQuestion")
	public String addQuestion(@RequestParam("questionType")String questionType,
			@ModelAttribute("question")Question question) throws Exception{
		System.out.println("/board/addQuestion : POST");
		
		question = boardService.addQuestion(question);
		
		return "redirect:/board/getQuestion?questionType="+questionType+"&questionNo="+question.getQuestionNo();		
	}
	
	//문의 수정 GET
	@GetMapping(value = "updateQuestion")
	public String updateQuestion(@RequestParam("questionType")String questionType,
			@RequestParam("questionNo")int questionNo, Model model) throws Exception {
		System.out.println("/board/updateQuestion : GET");
		
		Question question = boardService.getQuestionById(questionNo);
		
		model.addAttribute("question", question);
		
		return "forward:/board/updateQuestion.jsp";
	}
	
	//문의 수정POST
	@PostMapping(value = "updateQuestion")
	public String updateQuestion(@RequestParam("questionType")String questionType,
			@RequestParam("questionNo")int questionNo,@ModelAttribute("question") Question question) throws Exception{
		
		System.out.println("/board/updateQuestion : POST");
		
		boardService.updateQuestion(question);
		
		return "redirect:/board/getQuestion?questionType="+questionType+"&questionNo="+question.getQuestionNo();
	}
	
	//문의 삭제 GET
	@GetMapping(value = "deleteQuestion")
	public String deleteQuestion(@RequestParam("questionType")String questionType,
			@RequestParam("questionNo")int questionNo) throws Exception{
		System.out.println("/board/deleteQuestion : GET");
		
		boardService.deleteQuestion(questionNo);
		
		return "forward:/board/listQuestion?questionType="+questionType;
	}
	
	//문의 상세 조회 GET
	@GetMapping(value = "getQuestion")
	public String getQeustion(Model model, @RequestParam("questionNo")int questionNo,@RequestParam("questionType")String questionType) throws Exception{
		System.out.println("/board/getQeustion : GET");
		
		Question question = boardService.getQuestionById(questionNo);
		
		model.addAttribute("question",question);
		
		return "forward:/board/getQuestion.jsp";
	}
	
	//문의 목록 조회 GET
	@GetMapping(value = "listQuestion")
	public String getQuestionList(@RequestParam("questionType")String questionType,@ModelAttribute Search search,Model model) throws Exception{
		
		System.out.println("/board/listQeustion : GET");
		
		
		System.out.println(":::::: search : "+search);
		
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchCondition("");
		if (search.getSearchKeyword() == null || search.getSearchKeyword().isEmpty()) {
		    search.setSearchKeyword("");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("questionType",questionType);
		//map.put("questionType", "문의");
		map.put("offset", (search.getCurrentPage() - 1) * 8);
		map.put("search", search);
		
		int totalCount = boardService.getTotalCountQ(map);
		Page resultPage = new Page(search.getCurrentPage(), totalCount, pageUnit, pageSize);
		System.out.println("\n::::::::::::RESULT PAGE"+resultPage);
		
		List<Question> list = boardService.getQuestionList(map);
		
		System.out.println("::::: "+map.get("questionType"));
		
		model.addAttribute("list", list);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/board/listQuestion.jsp";		
	}
	
	
	//답변 등록 및 변경 GET
	@GetMapping(value = "updateReply")
	public String updateReply(@RequestParam("questionType")String questionType,
			@RequestParam("questionNo")int questionNo,
			@ModelAttribute("question")Question question, Model model) throws Exception{
			
		System.out.println("/board/udpateReply : GET");
			
		question= boardService.getQuestionById(questionNo);
			
		model.addAttribute("question", question);
			
		return "forward:/board/updateReply.jsp";
	}
	
	
	//답변 등록 및 변경 POST
	@PostMapping(value = "updateReply")
	public String updateReply(@RequestParam("questionType")String questionType,
			@RequestParam("questionNo")int questionNo,
			@ModelAttribute("question")Question question) throws Exception{
		
		System.out.println("/board/udpateReply : POST");
		
		boardService.updateReply(question);
		
		return "redirect:/board/getQuestion?questionType="+questionType+"&questionNo="+question.getQuestionNo();
	}
	
	/*
	 * Mail
	 */
	@RequestMapping(value="donationMail")
	public String donationMail(@ModelAttribute("donation")Donation donation, Model model,@RequestParam("payNo")int payNo) throws Exception {
		String title ="WEWU 후원 확인 메일";
		
		System.out.println("donation :: " + donation);
		
		String user_name="dtbsmf01@gmail.com";
		String password="iavd gqcj ymbv qjdv";
		
		donation = boardService.getDonationById(payNo);
		String content= makeMailContents(donation.getUserName(), donation.getPayDate(), donation.getPayAmount());
		
		mailService.goMail(mailService.setting(new Properties(), user_name, password), 
				title, content, donation.getEmail());
		
		model.addAttribute("donation", donation);
		
		return "forward:/board/donationMail.jsp";
	}
	
	public String makeMailContents(String userName, Date payDate, int payAmount) {
		
		String content = "<div class='mail_view_body'><div class='mail_view_contents'><div class='mail_view_contents_inner' data-translate-body-25271=''><div>"
			    + "<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
			    + "<tbody><tr><td>"
			    + "<table width='100%' border='0' cellspacing='0' cellpadding='0' style='border-top:4px solid #FFCA00;max-width:679px;margin:auto;width:100%'>"
			    + "<tbody><tr><td><img src='https://www.wewu.life/images/wewu.png' width='120' height='35' style='padding:30px 39px' alt='nicepay' loading='lazy'></td></tr>"
			    + "<tr><td>"
			    + "<table width='100%' border='0' cellspacing='0' cellpadding='0' style='border-top:1px solid #eee;border-bottom:1px solid #eee;'>"
			    + "<tbody><tr><td width='39'></td><td width='600' style='font-size:28px;color:#666;padding:25px 0;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>"
			    + "<span>"+userName+"</span>님,<br><span style='color:#00A06C;font-weight: bold;'>후원 완료</span>되었습니다."
			    + "</td><td width='39'></td></tr>"
			    + "</tbody></table>"
			    + "</td></tr>"
			    + "<tr><td>"
			    + "<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
			    + "<tbody><tr><td width='39'></td><td width='600' style='font-size:15px;color:#666;word-break: keep-all;padding: 25px 0;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>고객님이 <span style='font-weight:bold'>WEWU</span>에서 후원하신 내역입니다.</td><td width='39'></td></tr>"
			    + "</tbody></table>"
			    + "</td></tr>"
			    + "<tr><td>"
			    + "<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
			    + "<tbody><tr><td width='39'></td><td width='600'>"
			    + "<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
			    + "<tbody><tr><td colspan='2' style='font-size:15px;color:#000;font-weight: bold;padding-bottom: 10px;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>결제정보</td></tr>"
			    + "<tr><td colspan='2' width='100%' height='1' style='background: #000'></td></tr>"
			    + "<tr><td width='100' style='font-size:13px;color:#666;padding-bottom:10px;padding-top:15px;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>구매자명</td><td align='right' width='500' style='font-size:13px;color:#666;font-weight: bold;padding-bottom:10px;padding-top:15px;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>"+userName+"</td></tr>"
			    + "<tr><td width='100' style='font-size:13px;color:#666;padding-bottom:10px;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>결제일시</td><td align='right' width='500' style='font-size:13px;color:#666;font-weight: bold;padding-bottom:10px;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>"+payDate+"일 </td></tr>"
			    + "<tr><td width='100' style='font-size:13px;color:#666;padding-bottom:15px;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>결제수단</td><td align='right' width='500' style='font-size:13px;color:#666;font-weight: bold;padding-bottom:15px;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>카카오 페이</td></tr>"
			    + "<tr><td colspan='2' width='100%' height='1' style='background: #ccc'></td></tr>"
			    + "<tr><td width='100' style='font-size:19px;color:#00A06C;font-weight: bold;padding:15px 0;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>결제금액</td><td align='right' width='500' style='font-size:19px;color:#666;font-weight: bold;color:#00A06C;padding:15px 0;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>"
			    + "<span>"+payAmount+"원</span>"
			    + "</td></tr>"
			    + "</tbody></table>"
			    + "</td><td width='39'></td></tr>"
			    + "</tbody></table>"
			    + "</td></tr>"
			    + "<tr><td>"
			    + "<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
			    + "</td></tr>"
			    + "<tr><td>"
			    + "<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
			    + "<tbody><tr><td width='39'></td><td width='600'>"
			    + "<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
			    + "<tbody><tr><td colspan='2' style='font-size:15px;color:#000;font-weight: bold;padding-bottom: 10px;padding-top:40px;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>상점정보</td></tr>"
			    + "<tr><td colspan='2' width='100%' height='1' style='background: #000'></td></tr>"
			    + "<tr><td width='100' style='font-size:13px;color:#666;padding-bottom:10px;padding-top:15px;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>상점명</td><td align='right' width='500' style='font-size:13px;color:#666;font-weight: bold;padding-bottom:10px;padding-top:15px;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>(사)WEWU</td></tr>"
			    + "<tr><td width='100' style='font-size:13px;color:#666;padding-bottom:10px;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>사이트주소</td><td align='right' width='500' style='font-size:13px;color:#666;font-weight: bold;padding-bottom:10px;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'><a href='https://www.wewu.life' target='_blank' rel='noopener noreferrer'>https://www.wewu.life</a></td></tr>"
			    + "<tr><td colspan='2' width='100%' height='1' style='background: #ccc"
			    + "<tr><td colspan='2' width='100%' height='1' style='background: #ccc'></td></tr>"
			    + "</tbody></table>"
			    + "</td><td width='39'></td></tr>"
			    + "</tbody></table>"
			    + "</td></tr>"
			    + "<tr><td>"
			    + "<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
			    + "<tbody><tr><td height='20px'></td></tr>"
			    + "<tr><td width='39'></td><td valign='middle' width='600' style='height:42px;background: #FFCA00;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>"
			    + "<a href='https://www.wewu.life/' target='_blank' style='color:#fff;font-size:15px;text-align:center;text-decoration: none;:600px;display: block;' rel='noreferrer noopener'>WEWU 바로가기</a>"
			    + "</td><td width='39'></td></tr>"
			    + "</tbody></table>"
			    + "</td></tr>"
			    + "<tr><td>"
			    + "<table width='100%' border='0' cellspacing='0' cellpadding='0' style='border-bottom:1px solid #eee;'>"
			    + "<tbody><tr><td width='39'></td><td valign='middle' width='600' style='padding:40px 0;'>"
			    + "<a href='https://www.wewu.life' target='_blank' style=':600px;display: block;' rel='noreferrer noopener'>"
			    + "<img src='https://www.wewu.life/images/wewujumbo.jpg' alt='wewu' loading='lazy' width='600' height='120'>"
			    + "</a>"
			    + "<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
			    + "<tbody><tr><td width='39'>&nbsp;</td><td width='600'>"
			    + "<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
			    + "<tbody><tr><td width='20'></td><td width='150'>"
			    + "<img src='https://www.wewu.life/images/wewu.png' width='120' height='35' style='border:0;vertical-align:middle' alt='nicepay' loading='lazy'>"
			    + "</td><td align='left' style='font-size:11px;color:#aaa;padding:30px 0;;font-family: 나눔고딕,NanumGothic,맑은고딕,Malgun Gothic,돋움,Dotum,Helvetica,Apple SD Gothic Neo,Sans-serif;'>"
			    + "사업자 등록번호: 000-00-0000 ㅣ 결제대금예치업 등록번호: 02-0000-0000<br>"
			    + "04117 강남구 역삼동 819-3 삼오빌딩 비트캠프 5-9층<br>"
			    + "Copyright@2019 . All rights reserved."
			    + "</td><td width='20'></td></tr></tbody>"
			    + "</table>"
			    + "</td><td width='39'>&nbsp;</td></tr>"
			    + "</tbody></table>"
			    + "</td></tr>"
			    + "</tbody></table>"
			    + "</div></div></div></div>";


				
		return content;
	}
	
	

	
}