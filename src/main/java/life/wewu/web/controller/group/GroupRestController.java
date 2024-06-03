/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 */
package life.wewu.web.controller.group;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import life.wewu.web.service.group.GroupService;

@RestController
@RequestMapping("/app/group/*")
public class GroupRestController {

	///필드
	@Autowired
	@Qualifier("groupService")
	private GroupService groupService;
}
