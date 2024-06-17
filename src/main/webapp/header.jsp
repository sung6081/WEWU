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
    <!-- swiper -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/8.3.1/swiper-bundle.css">


<!-- 프로젝트 이름 헤더 추가 -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>WEWU</title>

<div class="fixed-top">

	<header class="navbar navbar-expand-lg navbar-light bg-light"
		style="height: 100px;">
		<div class="container d-flex justify-content-center">
			<span class="navbar-brand mb-0 h1">WEWU</span>
		</div>
	</header>

	<!-- Navbar -->
	<nav
		class="navbar navbar-expand-lg navbar-light bg-body-tertiary navbar-custom-height">
		<div class="container">
			<a class="navbar-brand" href="main.jsp"> <img
				src="images/logo.svg" alt="Skydash" style="height: 40px;">
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item"><a class="nav-link" href="#">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Features</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="#">Pricing</a>
					</li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						id="navbarDropdownMenuLink" role="button" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> Dropdown link </a>
						<div class="dropdown-menu"
							aria-labelledby="navbarDropdownMenuLink">
							<a class="dropdown-item" href="#">Action</a> <a
								class="dropdown-item" href="#">Another action</a> <a
								class="dropdown-item" href="#">Something else here</a>
						</div></li>
				</ul>
				<ul class="navbar-nav ml-auto">
					<li class="nav-item dropdown"><a class="nav-link" href="#"
						id="profileDropdown" role="button" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> <img
							src="images/faces/face28.jpg" alt="profile"
							class="rounded-circle" style="width: 30px;">
					</a>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="profileDropdown">
							<a class="dropdown-item" href="#"><i
								class="feather icon-settings"></i> Settings</a> <a
								class="dropdown-item" href="#"><i class="feather icon-power"></i>
								Logout</a>
						</div></li>
					<li class="nav-item nav-settings d-none d-lg-flex"><a
						class="nav-link" href="#"> <i class="icon-ellipsis"></i>
					</a></li>
				</ul>
				<button
					class="navbar-toggler navbar-toggler-right d-lg-none align-self-right"
					type="button" data-toggle="offcanvas">
					<span class="icon-menu"></span>
				</button>
			</div>
		</div>
	</nav>
</div>

<div style="height: 100px;"></div>
<!-- partial -->
<!-- quest list -->
<div id="right-sidebar" class="settings-panel">
	<i class="settings-close ti-close"></i>
	<ul class="nav nav-tabs border-top" id="setting-panel" role="tablist">
		<li class="nav-item"><a class="nav-link active" id="todo-tab"
			data-toggle="tab" href="#todo-section" role="tab"
			aria-controls="todo-section" aria-expanded="true">TO DO LIST</a></li>
		<li class="nav-item"><a class="nav-link" id="chats-tab"
			data-toggle="tab" href="#chats-section" role="tab"
			aria-controls="chats-section">CHATS</a></li>
	</ul>
	<div class="tab-content" id="setting-content">
		<div class="tab-pane fade show active scroll-wrapper"
			id="todo-section" role="tabpanel" aria-labelledby="todo-section">
			<div class="add-items d-flex px-3 mb-0">
				<form class="form w-100">
					<div class="form-group d-flex">
						<input type="text" class="form-control todo-list-input"
							placeholder="Add To-do">
						<button type="submit"
							class="add btn btn-primary todo-list-add-btn" id="add-task">Add</button>
					</div>
				</form>
			</div>
			<div class="list-wrapper px-3">
				<ul class="d-flex flex-column-reverse todo-list">
					<li>
						<div class="form-check">
							<label class="form-check-label"> <input class="checkbox"
								type="checkbox"> Team review meeting at 3.00 PM
							</label>
						</div> <i class="remove ti-close"></i>
					</li>
					<li>
						<div class="form-check">
							<label class="form-check-label"> <input class="checkbox"
								type="checkbox"> Prepare for presentation
							</label>
						</div> <i class="remove ti-close"></i>
					</li>
					<li>
						<div class="form-check">
							<label class="form-check-label"> <input class="checkbox"
								type="checkbox"> Resolve all the low priority tickets
								due today
							</label>
						</div> <i class="remove ti-close"></i>
					</li>
					<li class="completed">
						<div class="form-check">
							<label class="form-check-label"> <input class="checkbox"
								type="checkbox" checked> Schedule meeting for next week
							</label>
						</div> <i class="remove ti-close"></i>
					</li>
					<li class="completed">
						<div class="form-check">
							<label class="form-check-label"> <input class="checkbox"
								type="checkbox" checked> Project review
							</label>
						</div> <i class="remove ti-close"></i>
					</li>
				</ul>
			</div>
			<h4 class="px-3 text-muted mt-5 font-weight-light mb-0">Events</h4>
			<div class="events pt-4 px-3">
				<div class="wrapper d-flex mb-2">
					<i class="ti-control-record text-primary mr-2"></i> <span>Feb
						11 2018</span>
				</div>
				<p class="mb-0 font-weight-thin text-gray">Creating component
					page build a js</p>
				<p class="text-gray mb-0">The total number of sessions</p>
			</div>
			<div class="events pt-4 px-3">
				<div class="wrapper d-flex mb-2">
					<i class="ti-control-record text-primary mr-2"></i> <span>Feb
						7 2018</span>
				</div>
				<p class="mb-0 font-weight-thin text-gray">Meeting with Alisa</p>
				<p class="text-gray mb-0 ">Call Sarah Graves</p>
			</div>
		</div>
	</div>
</div>
