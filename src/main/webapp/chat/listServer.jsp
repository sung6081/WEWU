<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chat server</title>
<script type="text/javascript">
	$(function() {
		
		//alert('check');
		
		function listServer() {
			$.ajax({
				
				url: 'https://www.wewu.life/listServer',
				method: 'GET',
				success: function(response) {
			        // 서버 목록을 성공적으로 가져왔을 때의 처리
			        console.log('Received server list:', response);
			        
			        //왜 안바뀌지?
			        
			     	// 서버 목록을 테이블에 추가
			        var tbody = $('#tableBody');
			     	
			     	tbody.empty();
			     	
			        response.forEach(function(server, index) {
			            var row = '<tr>' +
			                          '<td>' + (index + 1) + '</td>' +
			                          '<td class="serverName clickable-text" >' + server.server_name + '</td>' +
			                          '<td>' + server.server_pers + '명</td>' +
			                      '</tr>';
			            tbody.append(row);
			        });
			        
			        $('.serverName').css('color', '#FFC107');
					
					$('.serverName').on('click', function(event) {
						//alert('check');
						
						var nick = '${user.nickname}';
						
						if(nick == '') {
							alert('로그인을 해주세요.');
							self.location = '/user/login';
							return;
						}
						
						var room = $(event.target).text().trim();
						console.log(room);
						
						//self.location = '/chat/chatting.jsp?room="'+room+'"&nick="'+nick+'"';
						window.open('/chat/chatting.jsp?room="'+room+'"&nick="'+nick+'"', 'popupWindow', 'width=800,height=660,left=100,top=100,menubar=no,toolbar=no,location=no,status=no,resizable=yes,scrollbars=yes');
					});
			        
			    },
			    error: function(xhr, status, error) {
			        // 서버 목록을 가져오는 데 실패했을 때의 처리
			        console.error('Failed to fetch server list:', error);
			    }
				
			});
		}
		
		listServer();
		
		setInterval(listServer, 1000);
		
	});
	
</script>
</head>
<body>

	<!-- <img src="https://wewu-project-test.kr.object.ncloudstorage.com/677e32c7-b7b6-4d23-ba8f-f6270767d664"> -->

	<table class="table serverTable">
		<thead>
			<tr>
				<th>No</th>
				<th>서버 이름</th>
				<th>접속 인원</th>
			</tr>
		</thead>
		<tbody id="tableBody" >
			
		</tbody>
	</table>

</body>
</html>