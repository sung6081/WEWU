<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- HEADER -->
<jsp:include page="/header.jsp"/>
<!-- HEADER -->
<style>
    .clickable-text {
        cursor: pointer; /* 커서를 포인터로 변경하여 클릭 가능함을 나타냄 */
    }
    
    #addBtn {
	    z-index: 1000; /* 버튼을 상위에 배치 */
	    pointer-events: auto; /* 클릭 가능하도록 설정 */
	    position: relative; /* 필요에 따라 position 속성 설정 */
	}
	
	.stretch-card {
		justify-content: space-around;
	}
	
	.options {
		color: #FFC107;
	}
	
	.options:hover {
		color: #FFC107 !important;
	}
	
	.activing {
		color: #00A06C;
	}
	
	.activeEnd {
		color: red;
	}
	
	.display-4 {
	  color: #fff; /* 원하는 색상으로 변경 */
	}
	
	.main-panel{
		margin:0;
	}
	
	.jumbotron{
		background-color: #00A06C;
		margin-top:160px;
		margin-bottom:0;
		background-size: contain; /* 이미지가 컨테이너 안에 맞도록 */
		background-image: url('/images/plant1.jpg'); /* 배경 이미지 경로 */
		background-size: cover; /* 이미지가 컨테이너를 덮도록 */
		background-position: center; /* 이미지가 중앙에 위치하도록 */
	}
	
	.sidebar {
		margin-top: 30px;
	}
    
</style>
</head>
<body>

	<div class="jumbotron">
	  <div class="container">
	    <p class="display-4"><b>ActiveList</b></p>
	  </div>
  	</div>

	<!-- SIDE -->
	<jsp:include page="/group/groupSide.jsp"></jsp:include>
	<!-- SIDE -->
	
	<script type="text/javascript">
	
		$(document).ready(function() {
			
			currentPage = 1;
			
			$('.spread-btn').attr('hidden', 'hidden');
			
			if(currentPage == 1) {
				//alert('check');
        		$('.hold-btn').attr('hidden', 'hidden');
        	}
			
			if(${isLast}) {
				//alert('check');
        		$('.more-btn').attr('hidden', 'hidden');
			}
			
			searchCondition = $('.condition').val();
    		searchKeyword = $('.keyword').val();
    		groupNo = ${groupNo};
    		url = '/app/active/listGroupActive?groupNo=' + ${groupNo};
			
			$('.dropdown-item').on('click', function(event) {
				
				$('.dropdown-btn').html($(event.target).html().trim());
				$('.condition').val($(event.target).html().trim());
				console.log($('.condition').val());
				
			});
			
			$('.keyword').on('keydown', function(e) {
		        var keyCode = e.which;
				
		        if (keyCode === 13) { // Enter Key
		        	
		        	$('.search-btn').click();
		        }
		    });
			
			$('.search-btn').on('click', function() {
				
				var searchKeyword = $('.keyword').val();
				var searchCondition = $('.condition').val();
				
				//alert(searchKeyword);
				//alert(searchCondition);
				
				/* if(searchKeyword == '') {
					return;
				} */
				
				
				$('form').attr('method', 'post');
				$('form').attr('action', '/active/listActive/?groupNo='+${groupNo});
				$('#searchForm')[0].submit();
				
			});
			
		});
	
	</script>
	
	<div class="main-panel">
		
       	<div class="content-wrapper">
       	
       		<div class="row">
       		
	       			<div class="col-lg-12 grid-margin stretch-card">
	       			
		       			<form id="searchForm" style="width: 100%;" class="searchForm" >
		       			
			              <div class="card">
			                <div class="card-body">
			                	
								<div class="row">
								    <div class="col-lg-6">
								        <h4 class="card-title">모임 활동 리스트</h4>
								    </div>
								    <c:if test="${isLeader}">
								        <div class="col-lg-6 text-lg-right">
								            <button type="button" id="addBtn" class="btn btn-outline-success btn-fw">등록하기</button>
								        </div>
								    </c:if>
								</div>
								
								<script type="text/javascript">
								
									$('#addBtn').on('click', function() {
										
										self.location = '/active/addActive/'+${param.groupNo};
										
									});
								
								</script>
			                  
								<div class="input-group text-right">
									
									<div class="input-group-prepend">
										<button class="dropdown-btn btn btn-sm btn-outline-success dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
											<c:if test="${search.searchCondition == null || search.searchCondition == ''}">
												활동 상태
											</c:if>
											<c:if test="${search.searchCondition != ''}">
												${search.searchCondition}
											</c:if>
										</button>
										<div class="dropdown-menu" style="">
											<a class="dropdown-item options" href="#">전체</a>
											<div role="separator" class="dropdown-divider"></div>
											<a class="dropdown-item options" href="#">활동중</a>
											<div role="separator" class="dropdown-divider"></div>
											<a class="dropdown-item options" href="#">활동 종료</a>
										</div>
									</div>
									<input type="hidden" class="condition" name="searchCondition" value="${search.searchCondition}" >
								
									<input type="text" name="searchKeyword" class="form-control-sm keyword" value="${search.searchKeyword}" placeholder="활동명 해쉬태그 검색">
									
									<div class="input-group-append">
									  <button class="btn btn-sm btn-success search-btn" type="button">Search</button>
									</div>
									
					 			</div>
			                  
			                  <p class="card-description">
			                  </p>
			                  <div class="table-responsive">
			                  
			                    <table class="table">
			                    
			                      <thead>
			                        <tr>
			                        	<th>No</th>
			                        	<th>활동 이름</th>
			                        	<th>활동 시작일</th>
			                        	<th>활동 종료일</th>
			                        	<th>활동 등록일</th>
			                        	<th>활동 종료 여부</th>
			                        </tr>
			                      </thead>
			                      
			                      <tbody class="list-body" >
			                      	<c:set var="i" value="1" ></c:set>
			                        <c:forEach var="active" items="${list}">
			                        
			                        	<tr>
											<td>${i}</td>
											<td class="name clickable-text" >
												${active.activeName}
												<input type="hidden" name="activeNo" value="${active.activeNo}">
											</td>
											<td>${active.activeStartDate}</td>
											<td>${active.activeEndDate}</td>
											<td>${active.activeRegDate}</td>
											<c:if test="${active.stateFlag == '활동중'}">
												<td class="activing">${active.stateFlag}</td>
											</c:if>
											<c:if test="${active.stateFlag == '활동 종료'}">
												<td class="activeEnd">${active.stateFlag}</td>
											</c:if>
										</tr>
			                        	
			                        <c:set var="i" value="${i+1}" ></c:set>
			                        </c:forEach>
			                        
			                      </tbody>
			                      
			                    </table>
			                    
			                    <script type="text/javascript">
			                    
			                    	$('.name').css('color', '#FFC107');
			                    	
			                    	$('.name').on('click', function(event) {
			                    		
			                    		var activeNo = $(event.target).children().val();
			                    		
			                    		//alert(activeNo);
			                    		
			                    		self.location = '/active/getActive/'+activeNo;
			                    	});
			                    
			                    </script>
			                    
			                   
			                    	
	                    	 	<button type="button" class="more-btn btn btn-secondary btn-lg btn-block">
	                    			더보기
	                    		</button>
	                    		<button type="button" class="hold-btn btn btn-secondary btn-lg btn-block">
	                    			접기
	                    		</button>
	                    		<button type="button" class="spread-btn btn btn-secondary btn-lg btn-block">
	                    			펼치기
	                    		</button>
			                    
			                    
			                    <script type="text/javascript">
			                    
			                    	$('.hold-btn').on('click', function() {
			                    		
			                    		$('.append').attr('hidden', 'hidden');
			                    		$('.hold-btn').attr('hidden', 'hidden');
			                    		$('.spread-btn').removeAttr('hidden');
			                    		
			                    	});
			                    	
			                    	$('.spread-btn').on('click', function() {
			                    		
			                    		$('.spread-btn').attr('hidden', 'hidden');
			                    		$('.hold-btn').removeAttr('hidden');
			                    		$('.append').removeAttr('hidden');
			                    		
			                    	});
			                    
			                    	$('.more-btn').on('click', function() {
			                    	
			                    		//alert(${isLast});
			                    		
			                    		currentPage++;
			                    		body = new Object();
			                			body.searchCondition = searchCondition;
			                    		body.searchKeyword = searchKeyword;
			                    		body.groupNo = groupNo;
			                    		body.currentPage = currentPage;
			                    		
			                    		let data = new Array();
			                    		data.push(body);
			                    		let json = JSON.stringify(body);
			                    		
			                    		console.log(json);
			                    		
			                    		$.ajax({
			                    			url: url,
			                    			method: 'POST',
			                    			data: json,
			                    			contentType : 'application/json',
			                    			success: function(JSONData, status) {
			                    				
			                    				console.log(JSONData);
			                    				console.log(JSONData.isLast);
			                    				
			                    				var list = JSONData.list;
			                    				
			                    				console.log(list);
			                    				
			                    				if(JSONData.isLast) {
						                    		$('.more-btn').attr('hidden', 'hidden');
						                    		$('.hold-btn').removeAttr('hidden');
						                    	}
			                					
			                					if(list.length == 0){
			                						return;
			                					}
			                    				
			                					var appendEl = '';
			                					
			                					var state = '';
			                    				for(let i = 0; i < list.length; i++) {
			                    					
			                    					let j = (currentPage-1) * 10 + i + 1;
			                    					
			                    					if(list[i].stateFlag == '활동중') {
			                    						state = 'activing';
			                    					}else {
			                    						state = 'activeEnd';
			                    					}
			                    					
			                    					appendEl += '<tr class="append">\n'+
																	'<td>'+j+'</td>\n'+
																	'<td class="name clickable-text" >\n'+
																		list[i].activeName+
																		'<input type="hidden" name="activeNo" value="'+list[i].activeNo+'">\n'+
																	'</td>\n'+
																	'<td>'+list[i].activeStartDate+'</td>\n'+
																	'<td>'+list[i].activeEndDate+'</td>\n'+
																	'<td>'+list[i].activeRegDate+'</td>\n'+
																	'<td class="'+state+'">'+list[i].stateFlag+'</td>\n'+
																'</tr>';
			                    					
			                    				}
			                    				
			                    				//console.log(appendEl);
			                    				
			                    				$('.list-body').append(appendEl);
			                    				
			                    				$('.name').css('color', 'blue');
						                    	
						                    	$('.name').on('click', function(event) {
						                    		
						                    		var activeNo = $(event.target).children().val();
						                    		
						                    		//alert(activeNo);
						                    		
						                    		self.location = '/active/getActive/'+activeNo;
						                    	});
			                    				
			                    			},
			                    		    error: function(xhr, status, error) {
			                    		        // 서버 목록을 가져오는 데 실패했을 때의 처리
			                    		        console.error('Failed to fetch list:', error);
			                    		    }
			                    		});
			                    		
			                    	});
			                    
			                    </script>
			                    
			                  </div>
			                </div>
			              </div>
		              
		              </form>
		              
		            </div>
		            
		            <!-- <div class="col-lg-3 grid-margin stretch-card">
       				</div> -->
	            
	            
       		
       		</div>
			
       	</div>
       		
			<!-- FOOTER -->
		    <jsp:include page="/footer.jsp" />
		    <!-- FOOTER -->
		    
		    <script type="text/javascript">
		    	//$('footer').removeClass('fixed-bottom');
		    </script>
       	
       </div>

</body>
</html>