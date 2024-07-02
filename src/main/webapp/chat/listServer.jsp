<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chat server</title>
<script type="text/javascript">
	$(function() {
		
		room = '';
		
		//alert('check');
		
		// 모달창 열기
		$(".btn-open-modal").on("click", function () {
			//alert('check');
			
			var nick = '${user.nickname}';
			
			if(nick == '') {
				alert('로그인을 해주세요.');
				self.location = '/user/login';
				return;
			}
			
			room = $(this).children().html().trim();
			
			$('h3.center-text').html($(this).children().html().trim());
			
			//alert(room);
			return;
			var data = {};
			data.nick = nick;
			data.room = room;
			
			$('.room').val(room);
			
			console.log("모달 열기 버튼 클릭됨");
			socket.emit('join_room', data);
			$(".modal").show();
		});
		
		// 모달창 닫기
		$(".modal-close").on("click", function () {
		  console.log("모달 닫기 버튼 클릭됨");
		  $(".modal").hide();
		});
		
		// 모달창 외부 클릭 시 닫기
		$(window).on("click", function (event) {
		  if ($(event.target).is(".modal")) {
		    console.log("모달 외부 클릭됨");
		    $(".modal").hide();
		  }
		});
		
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
			                          '<td class="serverName btn-open-modal clickable-text" ><strong>' + server.server_name + '</strong></td>' +
			                          '<td>' + server.server_pers + '명</td>' +
			                      '</tr>';
			            tbody.append(row);
			        });
			        
			        //$('.serverName').css('color', '#FFC107');
			        $('.serverName').css('color', '#444');
					
					/* $('.serverName').on('click', function(event) {
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
					}); */
					
			        $(".btn-open-modal").on("click", function () {
						//alert('check');
						
						var nick = '${user.nickname}';
						
						if(nick == '') {
							alert('로그인을 해주세요.');
							self.location = '/user/login';
							return;
						}
						
						room = $(this).children().html().trim();
						
						$('h3.center-text').html($(this).children().html().trim());
						
						if(socket.connected) {
							
						}else {
							socket = io('https://www.wewu.life', { path: '/chatting/' });
							
							socket = io('https://www.wewu.life', { path: '/chatting/' });
							
							//socket.emit('join_room', data);
							
							$('#messageInput').focus();
							
							//이전 기록 가져오는 함수
							socket.on('chatList', function(previousChats) {
								
								previousChats.forEach(function(chat) {
									
									console.log(chat);
									
									var date = new Date(chat.chat_date);
									//var formattedDate = date.toLocaleString();
									// 시간 부분 포맷 (오후 3:24 형식으로)
									var formattedDate = date.toLocaleTimeString('ko-KR', {
									    hour: 'numeric',
									    minute: 'numeric',
									    hour12: true // 12시간제로 표시 (오전/오후)
									});
									
									//console.log(chat.file_url);
									
									var chatBox = $('#chatBox');
							        var isScrolledToBottom = chatBox[0].scrollHeight - chatBox[0].clientHeight <= chatBox[0].scrollTop + 1;
							        if(chat.file_url != undefined && chat.file_type == 'img') {
							        	if(chat.chat_nickname == nick) {
							        		$('#chatBox').append('<div class="chats my"><span class="date" style="font-size: 10px;">' + formattedDate + '</span><img class="chat-img" src="'+chat.file_short_url+'"></div>');
							        	}else {
							        		$('#chatBox').append('<strong>'+chat.chat_nickname+'</strong><br/><div class="chats other"><img class="chat-img" src="'+chat.file_short_url+'"><span class="date" style="font-size: 10px;">' + formattedDate + '</span></div>');
							        	}
							        } else if(chat.file_url != undefined && chat.file_type == 'video') {
							        	if(chat.chat_nickname == nick) {
							        		$('#chatBox').append('<div class="chats my"><span class="date" style="font-size: 10px;">' + formattedDate + '</span><video src="'+chat.file_short_url+'" controls="controls" ></video></div>');
							        	}else {
							        		$('#chatBox').append('<strong>'+chat.chat_nickname+'</strong><br/><div class="chats other"><video src="'+chat.file_short_url+'" controls="controls" ></video><span class="date" style="font-size: 10px;">' + formattedDate + '</span></div>');
							        	}
							        }  
							        if(chat.chat_contents != '') {
							        	if(chat.chat_nickname == nick) {
							        		$('#chatBox').append('<div class="chats my"><span class="date" style="font-size: 10px;">' + formattedDate + '</span><div class="message parker">' + chat.chat_contents + '</div></div>');
							        	}else {
							        		//$('#chatBox').append('<div class="chats"><strong>'+ chat.chat_nickname +'</strong><br/><div class="chat-text">' + chat.chat_contents + ' ' + '</div><span class="date" style="font-size: 10px;">' + formattedDate + '</span></div>');
							        		$('#chatBox').append('<strong>'+ chat.chat_nickname +'</strong><br/><div class="chats other"><div class="message">' + chat.chat_contents + ' ' + '</div><span class="date" style="font-size: 10px;">' + formattedDate + '</span></div>');
							        	}
							        }
							        if (isScrolledToBottom) {
							            chatBox.scrollTop(chatBox[0].scrollHeight);
							        }
									
								});
								
							});
								
							//채팅방 입장 함수
							socket.on('enter', function(nick) {
								//$('#chatBox').append('<div><strong>'+${param.nick}+'</strong>님이 입장하였습니다.</div>');
								
								var chatBox = $('#chatBox');
								var isScrolledToBottom = chatBox[0].scrollHeight - chatBox[0].clientHeight <= chatBox[0].scrollTop + 1;
								$('#chatBox').append('<div class="center-text"><strong>'+nick+'</strong>님이 입장하였습니다.</div>');
								if (isScrolledToBottom) {
									chatBox.scrollTop(chatBox[0].scrollHeight);
								}
							});
								
							//전송받은 메세지 채팅창에 출력
							socket.on('message', function(data) {
								//$('#chatBox').append('<div><strong>'+data.nick+'</strong> : ' + data.msg + '</div>');
								
								console.log(data);
								
								// MongoDB에서 가져온 날짜 문자열
								var dateString = data.date; // 예: '2024-06-29T06:52:50.000Z'

								// Date 객체로 변환
								var date = new Date(dateString);

								// 로컬 시간으로 변환
								var localDate = new Date(date.getTime() - (date.getTimezoneOffset() * 60000));

								// 시간 부분 포맷 (오후 3:48 형식으로)
								var formattedTime = localDate.toLocaleTimeString('ko-KR', {
								    hour: 'numeric',
								    minute: 'numeric',
								    hour12: true // 12시간제로 표시 (오전/오후)
								});
								
								var chatBox = $('#chatBox');
								var isScrolledToBottom = chatBox[0].scrollHeight - chatBox[0].clientHeight <= chatBox[0].scrollTop + 1;
								//$('#chatBox').append('<div><strong>'+data.nick+'</strong> : ' + data.msg + '<span>' + data.date + '</span></div>');
								if(data.file_url != undefined && data.fileType == 'img') {
									$('#loading').remove();
									$('#sendButton').prop('disabled', false); // disabled 속성 제거하여 버튼 활성화
									if(data.nick == nick) {
						        		$('#chatBox').append('<div class="chats my"><span class="date" style="font-size: 10px;">' + formattedTime + '</span><img class="chat-img" src="'+data.shortUrl+'"></div>');
									}else {
										$('#chatBox').append('<strong>'+data.nick+'</strong><br/><div class="chats"><img class="chat-img" src="'+data.shortUrl+'"><span class="date" style="font-size: 10px;">' + formattedTime + '</span></div>');
									}
								}else if(data.file_url != undefined && data.fileType == 'video') {
									$('#loading').remove();
									$('#sendButton').prop('disabled', false); // disabled 속성 제거하여 버튼 활성화
									if(data.nick == nick) {
						        		$('#chatBox').append('<div class="chats my"><span class="date" style="font-size: 10px;">' + formattedTime + '</span><video src="'+data.file_short_url+'" controls="controls" ></video></div>');
									}else {
										$('#chatBox').append('<strong>'+data.nick+'</strong><br/><div class="chats"><video src="'+data.file_short_url+'" controls="controls" ></video><span class="date" style="font-size: 10px;">' + formattedTime + '</span></div>');
									}
						        }
								if(data.msg != '') {
									$('#loading').remove();
									$('#sendButton').prop('disabled', false); // disabled 속성 제거하여 버튼 활성화
									if(data.nick == nick){
										$('#chatBox').append('<div class="chats my"><span class="date" style="font-size: 10px;">'+ formattedTime +'</span><div class="message parker">' + data.msg + '</div>' + '</div>');
									}else {
										$('#chatBox').append('<strong>'+data.nick+'</strong><br/><div class="chats other"><div class="message">' + data.msg + '</div><span class="date" style="font-size: 10px;">' + formattedTime + '</span></div>');
									}
								}
								if (isScrolledToBottom) {
									chatBox.scrollTop(chatBox[0].scrollHeight);
									$('#loading').appendTo('#chatBox');
								}
							});
							
							//메시지 전송(enter 입력)
							$('#messageInput').on('keyup', function(event) {
								if($('#messageInput').val() != ''){
									if(event.keyCode == 13) {
										event.preventDefault();
										$('#sendButton').click();
									}
								}
							});
							
							//메시지 전송(button 클릭)
							$('#sendButton').on('click', function() {
								
								//아무것도 입력하지 않았다면 보낼 수 없다.
								if($('#messageInput').val() == '' && $('#fileInput').val() == ''){
									if($('#videoInput').val() == '') {
										//alert('check');
										
										return;
									}
								}
								
								//alert('check');
								
								//영상은 영상만 보낼 수 있다.
								if($('#videoInput').val() != '') {
									$('#messageInput').val('');
									$('#fileInput').val('');
								}
								
								var msg = $('#messageInput').val();
								
								//console.log(msg);
								
								var send_data = {};
								send_data.room = room;
								send_data.msg = msg;
								send_data.nick = nick;
								var chatBox = $('#chatBox');
								
								var loadingHtml = '<div id="loading" class="chats my"><div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div></div>';
							    $('#chatBox').append(loadingHtml);
							    $('#sendButton').prop('disabled', true); // sendButton을 비활성화
							    chatBox.scrollTop(chatBox[0].scrollHeight);
								
								if($('#fileInput').val() != '') {
									
									//파일 업로드, 채팅 저장 후 return
									var file = $('#fileInput')[0].files[0];
									
									if(file) {
										
										var reader = new FileReader();
										
										reader.onload = function(event) {
											var buffer = event.target.result;
											var fileData = {
													fileName: file.name,
													fileData: buffer,
													room: room,
													nick: nick,
													msg: msg
											};
											
											socket.emit('upload', fileData);
											
											//입력필드 초기화
											$('#fileInput').val('');
											$('#messageInput').val('');
										};
										
										reader.readAsArrayBuffer(file);
										//입력필드 초기화
										$('#fileInput').val('');
										$('#messageInput').val('');
										
									}
									
									$('.img-btn').removeClass('added');
									
									return;
									
								}else if($('#videoInput').val() != '') {
									
									console.log('start video upload');
									
									//alert('check');
									
									//파일 업로드, 채팅 저장 후 return
									var file = $('#videoInput')[0].files[0];
									
									if(file) {
										
										//alert('check');
										
										var formData = new FormData();
						                formData.append('video', file);
						               	formData.append('nick', nick);
						               	formData.append('fileName', file.name);
						               	formData.append('room', room);
						               	formData.append('msg', '');
					
						               	//alert('check');
						               	
						               	$.ajax({
						                    url: 'https://www.wewu.life/upload',
						                    type: 'POST',
						                    data: formData,
						                    processData: false,
						                    contentType: false,
						                    success: function(response) {
						                        console.log('Video uploaded successfully.');
						                        $('#videoInput').val('');
						                    },
						                    error: function(jqXHR, textStatus, errorThrown) {
						                    	alert(errorThrown);
						                        console.error('Error uploading video: ' + textStatus, errorThrown);
						                    }
						                });
						               	
						               	$('#videoInput').val('');
						               	
						               	//alert('check');
						               	
									}
									
									$('.video-btn').removeClass('added');
									
									return;
									
								}
								
								socket.emit('send_msg', send_data);
								
								$('#messageInput').val('');
								
								$('#messageInput').focus();
								
							});
							
							//메세지에 <>이거 불가하게 바꾸기
							$('#messageInput').on('input', function() {
					            var value = $(this).val();
					            if (value.includes('<') || value.includes('>')) {
					                $(this).val(value.replace(/[<>]/g, ''));
					            }
					        });
						}
						
						//alert(room);
						//return;
						var data = {};
						data.nick = nick;
						data.room = room;
						
						console.log("모달 열기 버튼 클릭됨");
						socket.emit('join_room', data);
						$(".modal").show();
					});
					
					// 모달창 닫기
					$(".modal-close").on("click", function () {
					  console.log("모달 닫기 버튼 클릭됨");
					  socket.disconnect();
					  var logs = $('#chatBox').children();
					  logs.remove();
					  $(".modal").hide();
					});
					
					// 모달창 외부 클릭 시 닫기
					$(window).on("click", function (event) {
					  if ($(event.target).is(".modal")) {
					    console.log("모달 외부 클릭됨");
					    socket.disconnect();
					    var logs = $('#chatBox').children();
					  	logs.remove();
					    $(".modal").hide();
					  }
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
	
	 <div class="modal">
	    <div class="modal-content">
	      <span class="modal-close">&times;</span>
	      <div class="modal-body">
	        <jsp:include page="/chat/chatting.jsp"></jsp:include>
	      </div>
	    </div>
	  </div>
	<input type="hidden" class="room" value="" >
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