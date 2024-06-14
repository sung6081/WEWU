/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 */
package life.wewu.web.service.pay.impl;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import life.wewu.web.common.Search;
import life.wewu.web.domain.pay.Pay;
import life.wewu.web.domain.user.User;
import life.wewu.web.service.pay.PayService;

@SpringBootTest
public class PayServiceTest{

	///필드
	@Autowired
	@Qualifier("payService")
	private PayService payService;

	///생성자

	///메소드
	//@Test
	public void testAddPointCharge() throws Exception {

		System.out.println("\n===================================");
		User user = User.builder()
				.nickname("nick1")
				.currentPoint(100)
				.build();
		Pay pay = Pay.builder()
				.buyerNickname(user.getNickname())
				.currentPoint(user.getCurrentPoint())
				.payAmount(100)
				.afterChargePoint(user.getCurrentPoint() + 100)
				.payOption("K")
				.payFlag("T")
				.build();
		payService.addPointCharge(pay);
		System.out.println("pay AddPointCharge :: " + pay);
		System.out.println("===================================\n");
	}

	//@Test
	public void testGetPointCharge() throws Exception {

		System.out.println("\n===================================");
		Pay pay = payService.getPointCharge(7);
		System.out.println("pay GetPointCharge :: " + pay);
		System.out.println("===================================\n");
	}

	//@Test
	public void testGetPointChargeList() throws Exception {

		System.out.println("\n===================================");
		Search search = new Search();
		List<Pay> list = payService.getPointChargeList(search);
		System.out.println("pay getPointChargeList :: " + list);
		System.out.println("===================================\n");
	}

	//@Test
	public void testDeletePointCharge() throws Exception {

		System.out.println("\n===================================");
		payService.deletePointCharge(7);
		System.out.println("pay DeletePointCharge :: ");
		System.out.println("===================================\n");
	}

	//@Test
	public void testUpdatePointCharge() throws Exception {

		System.out.println("\n===================================");

		Pay pay = Pay.builder()
				.payNo(7)
				.deletePayDate(new Date(2024-06-06))
				.payFlag("D")
				.build();
		payService.updatePointCharge(pay);
		pay = payService.getPointCharge(pay.getPayNo());
		System.out.println("pay UpdatePointCharge :: " + pay);
		System.out.println("===================================\n");
	}
}
