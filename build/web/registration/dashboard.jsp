<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
        <link rel="icon" type="image/png" href="../assets/img/favicon.png">
        <link href="vendors/feather/feather.css" rel="stylesheet" type="text/css"/>
        <link href="vendors/ti-icons/css/themify-icons.css" rel="stylesheet" type="text/css"/>
        <link href="vendors/css/vendor.bundle.base.css" rel="stylesheet" type="text/css"/>
        <link href="assets/css/vertical-layout-light/style.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="assets/img/favicon.png" />

        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">

        <title>
            Dashboard
        </title>
        <!--     Fonts and icons     -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
        <!-- Nucleo Icons -->
        <link href="assets/css/nucleo-icons.css" rel="stylesheet" type="text/css"/>
        <link href="assets/css/nucleo-svg.css" rel="stylesheet" type="text/css"/>
        <!-- Font Awesome Icons -->
        <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
        <link href="assets/css/nucleo-svg.css" rel="stylesheet" type="text/css"/>
        <!-- CSS Files -->
        <link href="assets/css/soft-ui-dashboard.css" rel="stylesheet" type="text/css"/>

        <style>
            .sidebar {
                overflow-y: hidden;
            }
            /* Sidebar styles */
            .sidenav {
                overflow-y: auto;
                transition: width 0.3s ease;
                width: 72px; /* Initial width */
                background-color: #fff; /* Sidebar background color */
                box-shadow: 0px 8px 10px rgba(0, 0, 0, 0.1); /* Sidebar shadow */
            }

            .navbar-toggler {
                border: none;
                background: transparent;
                cursor: pointer;
                transition: transform 0.3s ease; /* Smooth transition for the button */
            }

            .navbar-toggler:hover {
                transform: scale(1.1); /* Scale up the button on hover */
            }

            .sidenav:hover {
                width: 250px; /* Expanded width on hover */
            }

            .sidenav-header {
                padding: 15px; /* Padding for the header */
            }

            .navbar-brand {
                display: flex;
                align-items: center;
                padding: 10px;
                margin-bottom: 10px;
            }

            .nav-link {
                padding: 10px;
                transition: padding 0.3s ease;
            }

            /* Adjust padding of individual links on hover */
            .nav-item:hover .nav-link {
                padding: 15px;
            }

            /* Icon styles */
            .icon-shape {
                width: 40px; /* Icon container width */
                height: 40px; /* Icon container height */
                border-radius: 50%; /* Make icon container circular */
                transition: all 0.3s ease;
            }

            /* Expand individual icons on hover */
            .nav-item:hover .icon-shape {
                width: 60px;
                height: 60px;
            }

            /* Active link styles */
            .nav-link.active {
                background-color: #f8f9fe; /* Active link background color */
                color: #5e72e4; /* Active link text color */
                font-weight: 600; /* Bold font weight for active link */
            }

            .nav-link.active .icon-shape {
                background-color: #f8f9fe; /* Active icon background color */
                color: #5e72e4; /* Active icon color */
            }



        </style>

    </head>

    <body style="overflow: hidden">
        <div class="container-scroller">
            <!-- partial:../../partials/_navbar.html -->
            <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
                <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
                    <a class="navbar-brand brand-logo mr-5" href=""> <img src="assets/img/curved-images/sport16.jpg" class="mr-1" alt="logo"/></a>
                    <a class="navbar-brand brand-logo-mini" href=""><img src="assets/img/curved-images/gym.jpg" alt="logo"/></a>
                </div>
                <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
                    <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
                        <span class="icon-menu"></span>
                    </button>

                    <ul class="navbar-nav navbar-nav-right">
                        <li class="nav-item dropdown">
                        </li>
                        <li class="nav-item nav-profile dropdown">
                            <div aria-labelledby="profileDropdown">
                                <a href="../LogoutServlet" class="dropdown-item">
                                    <i class="ti-power-off text-primary"></i>
                                    Logout
                                </a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
                <!-- partial:../../partials/_settings-panel.html -->
                <%
            // Get the user's role from the session
            String userRole = (String) session.getAttribute("userRole");

            // Include the navbar based on the user's role
            if (userRole != null) {
                if (userRole.equals("clerk")) {
                    // Clerk Navbar
                %><jsp:include page="clerkNavbar.jsp" /><%
                } else if (userRole.equals("staff")) {
                    // Staff Navbar
                %><jsp:include page="staffNavbar.jsp" /><%
                } else {
                    //
                }
            }
                %>
                <!-- partial -->
                <div class="main-panel">
                    <div class="content-wrapper">
                        <section>
                            <div class="page-header align-items-start min-vh-50 pt-5 pb-11 m-3 border-radius-lg" style="background-image: url('assets/img/curved-images/sport8.jpg');">
                                <span class="mask bg-gradient-dark opacity-0"></span>
                                <div class="container">
                                    <div class="row justify-content-center">
                                    </div>
                                </div>
                            </div>


                            <div class="container-fluid py-1 px-3">
                                <div class="container-fluid py-4">
                                    <div class="row">
                                        <div class="col-xl-6 col-sm-6 mb-xl-4 mb-4">
                                            <div class="card">
                                                <div class="card-body p-3">
                                                    <div class="row">
                                                        <div class="col-8">
                                                            <div class="numbers">
                                                                <p class="text-sm mb-0 text-capitalize font-weight-bold" style="color: blue;">Event</p>
                                                                <h5 class="font-weight-bolder mb-0">Kejohanan Gimrama Majlis Sukan Malaysia <span class="text-success text-sm font-weight-bolder"></span></h5>
                                                            </div>
                                                        </div>
                                                        <div class="col-4 text-end">
                                                            <div class="icon icon-shape bg-gradient-primary shadow text-center border-radius-md">
                                                                <i class="ni ni-money-coins text-lg opacity-10" aria-hidden="true"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-6 col-sm-6 mb-xl-4 mb-4">
                                            <div class="card">
                                                <div class="card-body p-3">
                                                    <div class="row">
                                                        <div class="col-8">
                                                            <div class="numbers">
                                                                <p class="text-sm mb-0 text-capitalize font-weight-bold" style="color: blue;">Total Jury</p>
                                                                <h5 class="font-weight-bolder mb-0">3</h5>
                                                            </div>
                                                        </div>
                                                        <div class="col-4 text-end">
                                                            <div class="icon icon-shape bg-gradient-primary shadow text-center border-radius-md">
                                                                <i class="ni ni-world text-lg opacity-10" aria-hidden="true"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xl-6 col-sm-6 mb-xl-0 mb-4">
                                            <div class="card">
                                                <div class="card-body p-3">
                                                    <div class="row">
                                                        <div class="col-8">
                                                            <div class="numbers">
                                                                <p class="text-sm mb-0 text-capitalize font-weight-bold" style="color: blue;">Clerk's Name</p>
                                                                <h5 class="font-weight-bolder mb-0">Alias Bin Yusuof</h5>
                                                            </div>
                                                        </div>
                                                        <div class="col-4 text-end">
                                                            <div class="icon icon-shape bg-gradient-primary shadow text-center border-radius-md">
                                                                <i class="ni ni-paper-diploma text-lg opacity-10" aria-hidden="true"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-6 col-sm-6 mb-xl-0 mb-4">
                                            <div class="card">
                                                <div class="card-body p-3">
                                                    <div class="row">
                                                        <div class="col-8">
                                                            <div class="numbers">
                                                                <p class="text-sm mb-0 text-capitalize font-weight-bold" style="color: blue;">Participation: Total gymnast</p>
                                                                <h5 class="font-weight-bolder mb-0">8</h5>
                                                            </div>
                                                        </div>
                                                        <div class="col-4 text-end">
                                                            <div class="icon icon-shape bg-gradient-primary shadow text-center border-radius-md">
                                                                <i class="ni ni-cart text-lg opacity-10" aria-hidden="true"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div> 
                                    </div>



                                </div>    
                                <footer class="footer">
                                    <div class="d-sm-flex justify-content-center justify-content-sm-between">
                                        <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2024<a href="" target="_blank"></a> Gymnastic Scoring System</span>
                                    </div>
                                </footer>

                                </body>
                                </html>
                                <!--   Core JS Files   -->
                                <script src="vendors/js/vendor.bundle.base.js" type="text/javascript"></script>
                                <script src="assets/js/core/popper.min.js"></script>
                                <script src="assets/js/core/bootstrap.min.js"></script>
                                <script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
                                <script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
                                <script src="assets/off-canvas.js" type="text/javascript"></script>
                                <script src="assets/hoverable-collapse.js" type="text/javascript"></script>
                                <script src="assets/template.js" type="text/javascript"></script>
                                <script src="assets/settings.js" type="text/javascript"></script>
                                <script src="assets/todolist.js" type="text/javascript"></script>
                                <script>

                                    var win = navigator.platform.indexOf('Win') > -1;
                                    if (win && document.querySelector('#sidenav-scrollbar')) {
                                        var options = {
                                            damping: '0.5'
                                        }
                                        Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
                                    }
                                </script>

