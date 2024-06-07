/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 */
package life.wewu.web.service.report.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import life.wewu.web.common.Search;
import life.wewu.web.domain.group.Group;
import life.wewu.web.domain.group.GroupAcle;
import life.wewu.web.domain.group.GroupBoard;
import life.wewu.web.domain.group.GroupMember;
import life.wewu.web.domain.report.Report;
import life.wewu.web.service.group.GroupService;
import life.wewu.web.service.report.ReportService;

@SpringBootTest
public class ReportServiceTest{

	///필드
	@Autowired
	@Qualifier("reportService")
	private ReportService reportService;
	
	///필드
	@Autowired
	@Qualifier("groupService")
	private GroupService groupService;
	
	///생성자
	
	///메소드
	//@Test
	public void testAddReport() throws Exception {
		
		System.out.println("\n===================================");
		GroupAcle groupAcle = groupService.getGroupAcle(3);
		
		Report report = Report.builder()
								.targetNo(groupAcle.getBoardNo())
								.reportNickname("nick1")
								.targetNickname(groupAcle.getWrteName())
								.reportNote("공지사항이 어이가 없어요.")
								.reportType("B")
								.reportContents(groupAcle.getAcleContents())
								.build();

		report = reportService.addReport(report);
		
		System.out.println("report addReport :: " + report);
		System.out.println("===================================\n");
	}

	//@Test
	public void testGetReport() throws Exception {
		
		System.out.println("\n===================================");
		
		Report report = reportService.getReport(1);
		System.out.println("report GetReport :: " + report);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testGetReportList() throws Exception {
		
		System.out.println("\n===================================");
		
		Search search = new Search();
		List<Report> list = reportService.getReportList(search);
		System.out.println("report GetReportList :: " + list);
		System.out.println("===================================\n");
	}

	//@Test
	public void testUpdateReport() throws Exception {
		
		System.out.println("\n===================================");
		Report report = Report.builder()
				.reportNo(1)
				.rsltFlag("T")
				.rsltRepl("처리 완료하였습니다")
				.build();
		report = reportService.updateReport(report);
		System.out.println("report UpdateReport :: " + report);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testUpdateReportRslt() throws Exception {
		
		System.out.println("\n===================================");
		Report report = Report.builder()
				.reportNo(1)
				.rsltFlag("F")
				.build();
		report = reportService.updateReportRslt(report);
		System.out.println("report UpdateReportRslt :: " + report);
		System.out.println("===================================\n");
	}
	
	//@Test
	public void testDeleteReport() throws Exception {
		
		System.out.println("\n===================================");
		
		reportService.deleteReport(1);
		System.out.println("report DeleteReport :: ");
		System.out.println("===================================\n");
	}
}
