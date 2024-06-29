<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WEWU 채팅방</title>
 <!-- 필요한 메타 데이터 및 CSS/JS 링크 포함 -->
 <script src="https://code.jquery.com/jquery-latest.js"></script>
 <!-- plugins:js -->
 <script src="/vendors/js/vendor.bundle.base.js"></script>
 <!-- endinject -->
 <!-- Plugin js for this page -->
 <script src="/vendors/chart.js/Chart.min.js"></script>
 <script src="/vendors/datatables.net/jquery.dataTables.js"></script>
 <script src="/vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
 <script src="/js/dataTables.select.min.js"></script>
 <!-- End plugin js for this page -->
 <!-- inject:js -->
 <script src="/js/off-canvas.js"></script>
 <script src="/js/hoverable-collapse.js"></script>
 <script src="/js/template.js"></script>
 <script src="/js/settings.js"></script>
 <script src="/js/todolist.js"></script>
 <!-- endinject -->
 <!-- Custom js for this page-->
 <script src="/js/dashboard.js"></script>
 <script src="/js/Chart.roundedBarCharts.js"></script>
 <!-- dropdown -->
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
 <!-- plugins:css -->
 <link rel="stylesheet" href="/vendors/feather/feather.css">
 <link rel="stylesheet" href="/vendors/ti-icons/css/themify-icons.css">
 <link rel="stylesheet" href="/vendors/css/vendor.bundle.base.css">
 <!-- endinject -->
 <!-- Plugin css for this page -->
 <link rel="stylesheet" href="/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
 <link rel="stylesheet" type="/text/css" href="/js/select.dataTables.min.css">
 <!-- End plugin css for this page -->
 <!-- inject:css -->
 <link rel="stylesheet" href="/css/vertical-layout-light/style.css">
 <link rel="stylesheet" href="/css/index.css">
 <link rel="stylesheet" href="/css/swiper.css">
 <!-- endinject -->
 <link rel="shortcut icon" href="/images/favicon.ico" />
 <link rel="stylesheet" href="/vendors/mdi/css/materialdesignicons.min.css">
 <link rel="shortcut icon" href="/images/favicon.ico" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>

	body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f9;
        color: #333;
        margin: 0;
        padding: 0;
    }

    #chatBox {
        border: 1px solid #ccc;
        border-radius: 10px;
        height: 500px;
        overflow-y: scroll;
        padding: 20px;
        background-color: $background;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
    }
    
    /* Webkit 기반 브라우저 (Chrome, Safari)용 스크롤바 스타일링 */
    #chatBox::-webkit-scrollbar {
        width: 10px; /* 스크롤바 너비 */
    }
    
    #chatBox::-webkit-scrollbar-track {
        background: #f1f1f1; /* 스크롤바 트랙 배경색 */
        border-radius: 10px; /* 둥근 트랙 */
    }
    
    #chatBox::-webkit-scrollbar-thumb {
        background: #888; /* 스크롤바 손잡이 색 */
        border-radius: 10px; /* 둥근 손잡이 */
    }
    
    #chatBox::-webkit-scrollbar-thumb:hover {
        background: #555; /* 호버 상태의 스크롤바 손잡이 색 */
    }

    /* Firefox 용 스크롤바 스타일링 */
    #chatBox {
        scrollbar-width: thin; /* 스크롤바 너비 */
        scrollbar-color: #888 #f1f1f1; /* 스크롤바 손잡이와 트랙 색 */
    }
    
    #messageInput {
      width: 60%;
      padding: 10px;
    }
    
    /* #fileInput {
        margin-top: 10px;
    } */
    
    #sendButton {
      padding: 10px;
    }
    
    .chat-img {
        height: 150px;
        width: 150px;
        margin-top: 1rem;
        border-radius: 10px;
    }
    
    video {
        height: 300px;
        width: auto;
        border-radius: 10px;
        margin-top: 10px;
    }
    
    .input-group .form-control-sm {
         height: 49px; /* 동일한 높이 설정 */
     }
     
     .my {
        display: flex;
        align-items: flex-end;
        justify-content: flex-end;
     }
     
     .center-text {
	    text-align: center;
	}
	
	.added {
		background-color: #4B49AC !important;
		color: white !important;
	}
	
	.chats {
		margin-bottom: 10px;
	}
	
	.other {
		display: flex;
		align-items: flex-end;
		justify-content: flex-start;
	}
	
	.chats video {
        width: 100%;
        max-width: 600px;
        border: 2px solid #ddd;
        border-radius: 8px;s
        margin-top: 10px;
    }
    
    .date {
        font-size: 10px;
        color: #999;
    }
    
    .messages {
		background: $background;
		flex-shrink: 2;
		overflow-y: auto;
		
		box-shadow: 
			inset 0 2rem 2rem -2rem rgba(black, 0.05),
			inset 0 -2rem 2rem -2rem rgba(black, 0.05);
		
		.time {
			font-size: 0.8rem;
			background: $time-bg;
			padding: 0.25rem 1rem;
			border-radius: 2rem;
			color: $text-3;
			width: fit-content;
			margin: 0 auto;
		}
		
		.message {
			box-sizing: border-box;
			padding: 0.5rem 1rem;
			margin-top: 1rem;
	        margin-right: 1rem;
	        margin-bottom: 1rem;
			background: #FFF;
			border-radius: 1.125rem 1.125rem 1.125rem 0;
			min-height: 2.25rem;
			width: fit-content;
			max-width: 66%;
			
			box-shadow: 
				0 0 2rem rgba(black, 0.075),
				0rem 1rem 1rem -1rem rgba(black, 0.1);
			
			&.parker {
				background-color: #4B49AC !important;
				margin-left: 1rem;
				color: white !important;
			}
			
			.typing {
				display: inline-block;
				width: 0.8rem;
				height: 0.8rem;
				margin-right: 0rem;
				box-sizing: border-box;
				background: #ccc;
				border-radius: 50%;
				
				&.typing-1 { animation: typing 3s infinite }
				&.typing-2 { animation: typing 3s 250ms infinite }
				&.typing-3 { animation: typing 3s 500ms infinite }
			}
		}
	}
	
	#loading {
		padding: 20px; /* Loading 요소의 패딩을 조정하여 크기를 조절 */
	}
	
	.mdi-close {
        font-size: 48px; /* 원하는 크기로 설정 */
    }
    
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/4.2.0/socket.io.js"></script>
</head>
<body>

	<script type="text/javascript">
	
		$(function () {
			
			var nick = ${param.nick};
			var room = ${param.room};
			var data = {};
			data.nick = nick;
			data.room = room;
				
			//console.log(data);
				
			var socket = io('https://www.wewu.life', { path: '/chatting/' });
			
			socket.emit('join_room', data);
			
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
				
				var chatBox = $('#chatBox');
				var isScrolledToBottom = chatBox[0].scrollHeight - chatBox[0].clientHeight <= chatBox[0].scrollTop + 1;
				//$('#chatBox').append('<div><strong>'+data.nick+'</strong> : ' + data.msg + '<span>' + data.date + '</span></div>');
				if(data.file_url != undefined && data.fileType == 'img') {
					$('#loading').remove();
					$('#sendButton').prop('disabled', false); // disabled 속성 제거하여 버튼 활성화
					if(data.nick == nick) {
		        		$('#chatBox').append('<div class="chats my"><span class="date" style="font-size: 10px;">' + data.date + '</span><img class="chat-img" src="'+data.shortUrl+'"></div>');
					}else {
						$('#chatBox').append('<strong>'+data.nick+'</strong><br/><div class="chats"><img class="chat-img" src="'+data.shortUrl+'"><span class="date" style="font-size: 10px;">' + data.date + '</span></div>');
					}
				}else if(data.file_url != undefined && data.fileType == 'video') {
					$('#loading').remove();
					$('#sendButton').prop('disabled', false); // disabled 속성 제거하여 버튼 활성화
					if(data.nick == nick) {
		        		$('#chatBox').append('<div class="chats my"><span class="date" style="font-size: 10px;">' + data.date + '</span><video src="'+data.file_short_url+'" controls="controls" ></video></div>');
					}else {
						$('#chatBox').append('<strong>'+data.nick+'</strong><br/><div class="chats"><video src="'+data.file_short_url+'" controls="controls" ></video><span class="date" style="font-size: 10px;">' + data.date + '</span></div>');
					}
		        }
				if(data.msg != '') {
					$('#loading').remove();
					$('#sendButton').prop('disabled', false); // disabled 속성 제거하여 버튼 활성화
					if(data.nick == nick){
						$('#chatBox').append('<div class="chats my"><span class="date" style="font-size: 10px;">'+ data.date +'</span><div class="message parker">' + data.msg + '</div>' + '</div>');
					}else {
						$('#chatBox').append('<strong>'+data.nick+'</strong><br/><div class="chats other"><div class="message">' + data.msg + '</div><span class="date" style="font-size: 10px;">' + data.date + '</span></div>');
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
				
		});
		
	</script>

	<div id="chattingDiv">
        	<div class="content-wrapper">
        	<!-- <div>
        		<i class="mdi mdi-close"></i>
        	</div> -->
				<h3 class="center-text">
					${param.room}
				</h3>
				<div class="messages">
				<div id="chatBox"></div>
				</div>
				<div class="row">
				<div class="col-lg-12">
				
				<div class="input-group text-right">
				    <div class="input-group-prepend">
				        <!-- 이미지 업로드 버튼 -->
				        <button type="button" class="btn btn-outline-primary btn-icon-text img-btn">
				            <i class="mdi mdi-file-image btn-icon-prepend"></i>
				            이미지
				        </button>
				        <!-- 이미지 파일 입력 -->
				        <input type="file" hidden="hidden" id="fileInput" accept=".jpg,.jpeg,.png,.gif">
				    </div>
				    <div class="input-group-prepend">
				        <!-- 영상 업로드 버튼 -->
				        <button type="button" class="btn btn-outline-primary btn-icon-text video-btn">
				            <i class="mdi mdi-movie btn-icon-prepend"></i>
				            영상
				        </button>
				        <!-- 영상 파일 입력 -->
				        <input type="file" hidden="hidden" id="videoInput" accept=".mp4">
				    </div>
				    
				    <script type="text/javascript">
				    
				    	$('.img-btn').on('click', function() {
				    		$('#fileInput').click();
				    	});
				    	
				    	$('#fileInput').on('change', function() {
				    		
				    		//alert('::'+$(this).val()+'::');
				    		
				    		if($(this).val() != '') {
				    			$('.img-btn').addClass('added');
				    		}else {
				    			$('.img-btn').removeClass('added');
				    		}
				    		
				    	});
				    	
				    	$('.video-btn').on('click', function() {
				    		$('#videoInput').click();
				    	});
				    	
						$('#videoInput').on('change', function() {
				    		
				    		//alert('::'+$(this).val()+'::');
				    		
				    		if($(this).val() != '') {
				    			$('.video-btn').addClass('added');
				    		}else {
				    			$('.video-btn').removeClass('added');
				    		}
				    		
				    	});
				    
				    </script>
				    
				    <!-- 메시지 입력란 -->
				    <input type="text" id="messageInput" class="form-control-sm keyword" placeholder="채팅을 입력하세요...">
				    <!-- 전송 버튼 -->
				    <div class="input-group-append">
				        <button id="sendButton" class="btn btn-sm btn-primary search-btn">Send</button>
				    </div>
				</div>
				</div>
				</div>
			</div>
	</div>

</body>
</html>