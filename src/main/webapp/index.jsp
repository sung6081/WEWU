<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <!-- 필요한 메타 데이터 및 CSS/JS 링크 포함 -->
  <!-- plugins:js -->
  <script src="vendors/js/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page -->
  <script src="vendors/chart.js/Chart.min.js"></script>
  <script src="vendors/datatables.net/jquery.dataTables.js"></script>
  <script src="vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
  <script src="js/dataTables.select.min.js"></script>
  <!-- End plugin js for this page -->
  <!-- inject:js -->
  <script src="js/off-canvas.js"></script>
  <script src="js/hoverable-collapse.js"></script>
  <script src="js/template.js"></script>
  <script src="js/settings.js"></script>
  <script src="js/todolist.js"></script>
  <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <script src="js/dashboard.js"></script>
  <script src="js/Chart.roundedBarCharts.js"></script>
  <!-- plugins:css -->
  <link rel="stylesheet" href="vendors/feather/feather.css">
  <link rel="stylesheet" href="vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <link rel="stylesheet" href="vendors/datatables.net-bs4/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" type="text/css" href="js/select.dataTables.min.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="css/vertical-layout-light/style.css">
  <link rel="stylesheet" href="css/index.css">
  <link rel="stylesheet" href="css/main.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="images/favicon.png" />
</head>
<body>
    <script>
	<jsp:include page="/footer.jsp" flush="true" />
	<jsp:include page="/header.jsp" flush="true" />
	<!-- partial -->
	<div class="main-panel">
		<div class="content-wrapper">
			<div class="row">
				<div class="col-md-12 grid-margin">
					<div class="row">
						<div class="col-12 col-xl-8 mb-4 mb-xl-0">
							<h3 class="font-weight-bold">Welcome Aamir</h3>
							<h6 class="font-weight-normal mb-0">
								All systems are running smoothly! You have <span
									class="text-primary">3 unread alerts!</span>
							</h6>
						</div>
						<div class="col-12 col-xl-4">
							<div class="justify-content-end d-flex">
								<div class="dropdown flex-md-grow-1 flex-xl-grow-0">
									<button class="btn btn-sm btn-light bg-white dropdown-toggle"
										type="button" id="dropdownMenuDate2" data-toggle="dropdown"
										aria-haspopup="true" aria-expanded="true">
										<i class="mdi mdi-calendar"></i> Today (10 Jan 2021)
									</button>
									<div class="dropdown-menu dropdown-menu-right"
										aria-labelledby="dropdownMenuDate2">
										<a class="dropdown-item" href="#">January - March</a> <a
											class="dropdown-item" href="#">March - June</a> <a
											class="dropdown-item" href="#">June - August</a> <a
											class="dropdown-item" href="#">August - November</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6 grid-margin stretch-card">
					<div class="card tale-bg">
						<div class="card-people mt-auto">
							<img src="images/dashboard/people.svg" alt="people">
							<div class="weather-info">
								<div class="d-flex">
									<div>
										<h2 class="mb-0 font-weight-normal">
											<i class="icon-sun mr-2"></i>31<sup>C</sup>
										</h2>
									</div>
									<div class="ml-2">
										<h4 class="location font-weight-normal">Bangalore</h4>
										<h6 class="font-weight-normal">India</h6>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-6 grid-margin stretch-card">
					<div class="card tale-bg">
						<div class="card-people mt-auto">
							<img src="images/dashboard/people.svg" alt="people">
							<div class="weather-info">
								<div class="d-flex">
									<div>
										<h2 class="mb-0 font-weight-normal">
											<i class="icon-sun mr-2"></i>31<sup>C</sup>
										</h2>
									</div>
									<div class="ml-2">
										<h4 class="location font-weight-normal">Bangalore</h4>
										<h6 class="font-weight-normal">India</h6>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- swiper -->
				<div class="row mx-auto">
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<div class="swiper-slide">
								<img src="https://via.placeholder.com/500x300" alt="Plant 1">
								<div class="slide-content">
									<h3>Philodendron</h3>
									<p>The Philodendron White Princess Has Been Around For Some
										Time In Private Collections. But They Have Hit The Market...</p>
								</div>
							</div>
							<div class="swiper-slide">
								<img src="https://via.placeholder.com/500x300" alt="Plant 2">
								<div class="slide-content">
									<h3>Monstera Obliqua Peruvian</h3>
									<p>AS It Is A Small Species, Monstera Obliqua Is Uncommon.
										Another Reason For Its Scarcity Is That It Grows Slowly And
										Has Short...</p>
								</div>
							</div>
							<div class="swiper-slide">
								<img src="https://via.placeholder.com/500x300" alt="Plant 3">
								<div class="slide-content">
									<h3>Norfolk Island Pine</h3>
									<p>Although A Lively Addition To Your Home All Year
										Round—The Norfolk Island Pine Shines As A Live Holiday Tree
										During The Winter...</p>
								</div>
							</div>
						</div>
						<div class="swiper-button-next"></div>
						<div class="swiper-button-prev"></div>
					</div>
				</div>
				<!-- 추가 슬라이드 -->
				<div class="row mx-auto">
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<div class="swiper-slide">
								<img src="https://via.placeholder.com/500x300" alt="Plant 1">
								<div class="slide-content">
									<h3>Philodendron</h3>
									<p>The Philodendron White Princess Has Been Around For Some
										Time In Private Collections. But They Have Hit The Market...</p>
								</div>
							</div>
							<div class="swiper-slide">
								<img src="https://via.placeholder.com/500x300" alt="Plant 2">
								<div class="slide-content">
									<h3>Monstera Obliqua Peruvian</h3>
									<p>AS It Is A Small Species, Monstera Obliqua Is Uncommon.
										Another Reason For Its Scarcity Is That It Grows Slowly And
										Has Short...</p>
								</div>
							</div>
							<div class="swiper-slide">
								<img src="https://via.placeholder.com/500x300" alt="Plant 3">
								<div class="slide-content">
									<h3>Norfolk Island Pine</h3>
									<p>Although A Lively Addition To Your Home All Year
										Round—The Norfolk Island Pine Shines As A Live Holiday Tree
										During The Winter...</p>
								</div>
							</div>
						</div>
							<div class="swiper-button-next"></div>
							<div class="swiper-button-prev"></div>
					</div>
				</div>

				<!-- content-wrapper ends -->
				<!-- partial:partials/_footer.html -->
				<jsp:include page="footer.jsp" />
				<!-- partial -->
			</div>
			<!-- main-panel ends -->
		</div>
	</div>
</body>
</html>