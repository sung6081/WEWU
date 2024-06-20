<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>활동 목록 조회</title>
</head>
<body>

	<!-- HEADER -->
	<jsp:include page="/header.jsp"/>
	<!-- HEADER -->
	
	<!-- SIDE -->
	<jsp:include page="/activeSide.jsp"></jsp:include>
	<!-- SIDE -->
	
	<script type="text/javascript">
	
		$(document).ready(function() {
			
			currentPage = 1;
			
			$('.dropdown-item').on('click', function(event) {
				
				$('.dropdown-btn').html($(event.target).html().trim());
				$('.condition').val($(event.target).html().trim());
				console.log($('.condition').val());
				
			});
			
		});
	
	</script>
	
	<div class="main-panel">
       	<div class="content-wrapper">
       	
       		<div class="row">
       		
       				<div class="col-lg-2 grid-margin stretch-card">
       				</div>
       		
	       			<div class="col-lg-6 grid-margin stretch-card">
	       			
		       			<form class="search-form" >
		       			
			              <div class="card">
			                <div class="card-body">
			                	
								<div class="row">
									<div class="col-lg-6">
										<h4 class="card-title">모임 활동 리스트</h4>
									</div>
									<c:if test="${user.role == '3' }">
										<div class="col-lg-6 d-flex justify-content-end">
											<button type="button" class="btn to-add-btn btn-outline-primary btn-fw">등록하기</button>
										</div>
									</c:if>
								</div>
			                  
								<div class="input-group text-right">
								
									<div class="input-group-prepend">
										<button class="dropdown-btn btn btn-sm btn-outline-primary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">활동 상태</button>
										<div class="dropdown-menu" style="">
											<a class="dropdown-item" href="#">전체</a>
											<div role="separator" class="dropdown-divider"></div>
											<a class="dropdown-item" href="#">활동중</a>
											<div role="separator" class="dropdown-divider"></div>
											<a class="dropdown-item" href="#">활동 종료</a>
										</div>
									</div>
									<input type="hidden" class="condition" name="searchCondition">
								
									<input type="text" name="searchKeyword" class="form-control-sm keyword" placeholder="활동명 해쉬태그 검색">
									
									<div class="input-group-append">
									  <button class="btn btn-sm btn-primary" type="button">Search</button>
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
											<td class="name" >
												${active.activeName}
												<input type="hidden" name="activeNo" value="${active.activeNo}">
											</td>
											<td>${active.activeStartDate}</td>
											<td>${active.activeEndDate}</td>
											<td>${active.activeRegDate}</td>
											<td>${active.stateFlag}</td>
										</tr>
			                        	
			                        <c:set var="i" value="${i+1}" ></c:set>
			                        </c:forEach>
			                        
			                      </tbody>
			                      
			                    </table>
			                    
			                    <script type="text/javascript">
			                    
			                    	$('.name').css('color', 'blue');
			                    	
			                    	$('.name').on('click', function(event) {
			                    		
			                    		var activeNo = $(event.target).children().val();
			                    		
			                    		//alert(activeNo);
			                    		
			                    		self.location = '/active/getActive/'+activeNo;
			                    	})
			                    
			                    </script>
			                    
			                    <button type="button" class="more-btn btn btn-secondary btn-lg btn-block">
			                    	<c:if test="${!isLast}">
			                    		더보기
			                    	</c:if>
			                    	<c:if test="${isLast}">
			                    		접기
			                    	</c:if>
			                    </button>
			                    
			                    <script type="text/javascript">
			                    
			                    	$('.more-btn').on('click', function() {
			                    	
			                    		//alert(${isLast});
			                    		var body = new Object();
			                    		body.searchCondition = $('.condition').val();
			                    		body.searchKeyword = $('.keyword').val();
			                    		body.groupNo = ${groupNo};
			                    		body.currentPage = currentPage
			                    		var url = '/app/active/listGroupActive?groupNo=' + ${groupNo};
			                    		let data = new Array();
			                    		data.push(body);
			                    		let json = JSON.stringify(body);
			                    		
			                    		currentPage++;
			                    		
			                    		$.ajax({
			                    			url: url,
			                    			method: 'POST',
			                    			data: json,
			                    			contentType : 'application/json',
			                    			success: function(JSONData, status) {
			                    				
			                    				console.log(JSONData);
			                					
			                					if(JSONData.length == 0){
			                						return;
			                					}
			                    				
			                    				/* for(int i = 0; i < response.list.length; i++) {
			                    					
			                    					let append = '<tr class="append">\n'+
																	'<td>${i}</td>\n'+
																	'<td class="name" >\n'+
																		+
																		<input type="hidden" name="activeNo" value="${active.activeNo}">
																	</td>
																	<td>${active.activeStartDate}</td>
																	<td>${active.activeEndDate}</td>
																	<td>${active.activeRegDate}</td>
																	<td>${active.stateFlag}</td>
																</tr>
			                    					
			                    				} */
			                    				
			                    			},
			                    		    error: function(xhr, status, error) {
			                    		        // 서버 목록을 가져오는 데 실패했을 때의 처리
			                    		        console.error('Failed to fetch list:', error);
			                    		    }
			                    		});
			                    		
			                    	})
			                    
			                    </script>
			                    
			                  </div>
			                </div>
			              </div>
		              
		              </form>
		              
		            </div>
		            
		            <div class="col-lg-3 grid-margin stretch-card">
       				</div>
	            
	            
       		
       		</div>
			
       	</div>
       		
			<!-- FOOTER -->
		    <jsp:include page="/footer.jsp" />
		    <!-- FOOTER -->
		    
		    <script type="text/javascript">
		    	$('footer').removeClass('fixed-bottom');
		    </script>
       	
       </div>

</body>
</html>