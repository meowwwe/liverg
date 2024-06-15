<%@ page import="java.sql.*, java.util.*, java.util.stream.Collectors" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="com.registration.bean.*" %>
<%@ page import="com.connection.DBConnect" %>

<%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    List<Clerk> clerks = new ArrayList<>();
    int judgeCount = 0;
    int clerkCount = 0;
    int headCount = 0;
    int gymnastCount = 0;
    int teamCount = 0;
    List<Gymnast> gymnasts = new ArrayList<>();
    List<Apparatus> apparatusList = new ArrayList<>();
    List<Team> teams = new ArrayList<>();

    try {
        DBConnect db = new DBConnect();
        con = db.getConnection();
        stmt = con.createStatement();
        
        // Fetch all clerks
        rs = stmt.executeQuery("SELECT * FROM CLERK LIMIT 1");
        while (rs.next()) {
            Clerk clerk = new Clerk();
            clerk.setClerkID(rs.getInt("clerkID"));
            clerk.setClerkName(rs.getString("clerkName"));
            clerks.add(clerk);
        }
        rs.close();

        // Get judge count
        rs = stmt.executeQuery("SELECT COUNT(JUDGEID) AS judgeCount FROM JUDGE");
        if (rs.next()) {
            judgeCount = rs.getInt("judgeCount");
        }
        rs.close();

        // Get clerk count
        rs = stmt.executeQuery("SELECT COUNT(CLERKID) AS clerkCount FROM CLERK");
        if (rs.next()) {
            clerkCount = rs.getInt("clerkCount");
        }
        rs.close();
        
        // Get headjudge count
        rs = stmt.executeQuery("SELECT COUNT(HEADJUDGEID) AS headCount FROM HEADJUDGE");
        if (rs.next()) {
            headCount = rs.getInt("headCount");
        }
        rs.close();
        
        // Get gymnast count
        rs = stmt.executeQuery("SELECT COUNT(GYMNASTID) AS gymnastCount FROM GYMNAST");
        if (rs.next()) {
            gymnastCount = rs.getInt("gymnastCount");
        }
        rs.close();
        
        // Get team count
        rs = stmt.executeQuery("SELECT COUNT(TEAMID) AS teamCount FROM TEAM");
        if (rs.next()) {
            teamCount = rs.getInt("teamCount");
        }
        rs.close();

        // Fetch gymnasts and apparatus details
        rs = stmt.executeQuery("SELECT G.GYMNASTID, G.GYMNASTIC, G.GYMNASTNAME, G.GYMNASTSCHOOL, G.GYMNASTCATEGORY, GROUP_CONCAT(A.APPARATUSNAME ORDER BY A.APPARATUSNAME SEPARATOR ', ') AS APPARATUS_LIST, T.TEAMNAME FROM GYMNAST G JOIN GYMNAST_APP GA ON G.GYMNASTID = GA.GYMNASTID JOIN APPARATUS A ON GA.APPARATUSID = A.APPARATUSID JOIN TEAM T ON G.TEAMID = T.TEAMID GROUP BY G.GYMNASTID, G.GYMNASTNAME");
        while (rs.next()) {
            Gymnast gymnast = new Gymnast();
            gymnast.setGymnastID(rs.getInt("GYMNASTID"));
            gymnast.setGymnastIC(rs.getString("GYMNASTIC")); 
            gymnast.setGymnastName(rs.getString("GYMNASTNAME"));
            gymnast.setGymnastSchool(rs.getString("GYMNASTSCHOOL"));
            gymnast.setGymnastCategory(rs.getString("GYMNASTCATEGORY"));
            gymnasts.add(gymnast);

            Apparatus apparatus = new Apparatus();
            apparatus.setApparatusName(rs.getString("APPARATUS_LIST"));
            apparatusList.add(apparatus);
            
            Team team = new Team();
            team.setTeamName(rs.getString("TEAMNAME"));
            teams.add(team);
        }
        rs.close();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    // Group gymnasts by team name
    Map<String, List<Gymnast>> gymnastsByTeam = gymnasts.stream().collect(Collectors.groupingBy(g -> {
        int index = gymnasts.indexOf(g);
        return teams.get(index).getTeamName();
    }));
%>

<!DOCTYPE html>
<html lang="en">

 <head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="../assets/img/favicon.png">
  <link href="vendors/feather/feather.css" rel="stylesheet" type="text/css" />
  <link href="vendors/ti-icons/css/themify-icons.css" rel="stylesheet" type="text/css" />
  <link href="vendors/css/vendor.bundle.base.css" rel="stylesheet" type="text/css" />
  <link href="assets/css/vertical-layout-light/style.css" rel="stylesheet" type="text/css" />
  <link rel="shortcut icon" href="assets/img/favicon.png" />

  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">

  <title>
   Dashboard
  </title>
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
  <!-- Nucleo Icons -->
  <link href="assets/css/nucleo-icons.css" rel="stylesheet" type="text/css" />
  <link href="assets/css/nucleo-svg.css" rel="stylesheet" type="text/css" />
  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <link href="assets/css/nucleo-svg.css" rel="stylesheet" type="text/css" />
  <!-- CSS Files -->
  <link href="assets/css/soft-ui-dashboard.css" rel="stylesheet" type="text/css" />

  <style>
   .sidebar {
    overflow-y: hidden;
   }

   /* Sidebar styles */
   .sidenav {
    overflow-y: auto;
    transition: width 0.3s ease;
    width: 72px;
    /* Initial width */
    background-color: #fff;
    /* Sidebar background color */
    box-shadow: 0px 8px 10px rgba(0, 0, 0, 0.1);
    /* Sidebar shadow */
   }

   .navbar-toggler {
    border: none;
    background: transparent;
    cursor: pointer;
    transition: transform 0.3s ease;
    /* Smooth transition for the button */
   }

   .navbar-toggler:hover {
    transform: scale(1.1);
    /* Scale up the button on hover */
   }

   .sidenav:hover {
    width: 250px;
    /* Expanded width on hover */
   }

   .sidenav-header {
    padding: 15px;
    /* Padding for the header */
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
    width: 40px;
    /* Icon container width */
    height: 40px;
    /* Icon container height */
    border-radius: 50%;
    /* Make icon container circular */
    transition: all 0.3s ease;
   }

   /* Expand individual icons on hover */
   .nav-item:hover .icon-shape {
    width: 60px;
    height: 60px;
   }

   /* Active link styles */
   .nav-link.active {
    background-color: #f8f9fe;
    /* Active link background color */
    color: #5e72e4;
    /* Active link text color */
    font-weight: 600;
    /* Bold font weight for active link */
   }

   .nav-link.active .icon-shape {
    background-color: #f8f9fe;
    /* Active icon background color */
    color: #5e72e4;
    /* Active icon color */
   }

   .ag-format-container {
    width: 1142px;
    margin: 0 auto;
   }

   .ag-courses_box {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: start;
    -ms-flex-align: start;
    align-items: flex-start;
    -ms-flex-wrap: wrap;
    flex-wrap: wrap;
    padding: 50px 0;
   }

   .ag-courses_item {
    -ms-flex-preferred-size: calc(33.33333% - 30px);
    flex-basis: calc(33.33333% - 30px);
    margin: 0 15px 30px;
    overflow: hidden;
    border-radius: 28px;
   }

   .ag-courses-item_link {
    display: block;
    padding: 30px 20px;
    background-color: #121212;
    overflow: hidden;
    position: relative;
   }

   .ag-courses-item_link:hover,
   .ag-courses-item_link:hover .ag-courses-item_date {
    text-decoration: none;
    color: #fff;
   }

   .ag-courses-item_link:hover .ag-courses-item_bg {
    -webkit-transform: scale(10);
    -ms-transform: scale(10);
    transform: scale(10);
   }

   .ag-courses-item_title {
    min-height: 87px;
    margin: 0 0 25px;
    overflow: hidden;
    font-weight: bold;
    font-size: 30px;
    color: #fff;
    z-index: 2;
    position: relative;
   }

   .ag-courses-item_date-box {
    font-size: 18px;
    color: #fff;
    z-index: 2;
    position: relative;
   }

   .ag-courses-item_date {
    font-weight: bold;
    color: #f9b234;
    -webkit-transition: color 0.5s ease;
    -o-transition: color 0.5s ease;
    transition: color 0.5s ease;
   }

   .ag-courses-item_bg {
    height: 128px;
    width: 128px;
    background-color: #f9b234;
    z-index: 1;
    position: absolute;
    top: -75px;
    right: -75px;
    border-radius: 50%;
    -webkit-transition: all 0.5s ease;
    -o-transition: all 0.5s ease;
    transition: all 0.5s ease;
   }

   .ag-courses_item:nth-child(2n) .ag-courses-item_bg {
    background-color: #3ecd5e;
   }

   .ag-courses_item:nth-child(3n) .ag-courses-item_bg {
    background-color: #e44002;
   }

   .ag-courses_item:nth-child(4n) .ag-courses-item_bg {
    background-color: #952aff;
   }

   .ag-courses_item:nth-child(5n) .ag-courses-item_bg {
    background-color: #cd3e94;
   }

   .ag-courses_item:nth-child(6n) .ag-courses-item_bg {
    background-color: #4c49ea;
   }

   @media only screen and (max-width: 979px) {
    .ag-courses_item {
     -ms-flex-preferred-size: calc(50% - 30px);
     flex-basis: calc(50% - 30px);
    }

    .ag-courses-item_title {
     font-size: 24px;
    }
   }

   @media only screen and (max-width: 767px) {
    .ag-format-container {
     width: 96%;
    }
   }

   @media only screen and (max-width: 639px) {
    .ag-courses_item {
     -ms-flex-preferred-size: 100%;
     flex-basis: 100%;
    }

    .ag-courses-item_title {
     min-height: 72px;
     line-height: 1;
     font-size: 24px;
    }

    .ag-courses-item_link {
     padding: 22px 40px;
    }

    .ag-courses-item_date-box {
     font-size: 16px;
    }
   }
  </style>
 </head>

 <body style="overflow: hidden">
  <div class="container-scroller">
   <!-- partial:../../partials/_navbar.html -->
   <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
    <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
     <a class="navbar-brand brand-logo mr-5" href=""> <img src="assets/img/curved-images/gymnastLogo.png"
                                                           class="mr-1" alt="logo" /></a>
     <a class="navbar-brand brand-logo-mini" href=""><img src="assets/img/curved-images/miniLogo.png" alt="logo" /></a>
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

   <div class="container-fluid page-body-wrapper">

    <%
        // Get the user's role from the session
        String userRole = (String) session.getAttribute("userRole");

        // Include the navbar based on the user's role
        if (userRole != null) {
            if (userRole.equals("clerk")) {
    %>
    <jsp:include page="clerkNavbar.jsp" />
    <%
            } else if (userRole.equals("staff")) {
    %>
    <jsp:include page="staffNavbar.jsp" />
    <%
            } else {
                // Redirect to LogoutServlet if userRole is not recognized
                response.sendRedirect("../LogoutServlet");
            }
        } else {
            // Redirect to LogoutServlet if userRole is null
            response.sendRedirect("../LogoutServlet");
        }
    %>


    <!-- partial -->
    <div class="main-panel">
     <div class="content-wrapper">
      <section>

       <h2>Dashboard</h2>
       <div class="container-fluid py-1 px-3">
        <div class="container-fluid py-4">
         <div class="row">

          <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
           <div class="card">
            <div class="card-body p-3">
             <div class="row">
              <div class="col-8">
               <div class="numbers">
                <p class="text-sm mb-0 text-capitalize font-weight-bold">Clerk Information <i class="ni ni-bold-right text-success"></i></p>
                <div class="font-weight-bolder mb-0">
                 <span class="text-sm font-weight-bolder">TOTAL <i class="ni ni-bold-down text-success"></i></span>
                 <span class="text-success text-sm font-weight-bolder text-center"><h1><%= clerkCount %></h1></span>
                </div>
               </div>
              </div>
              <div class="col-4 text-end">
               <div class="icon icon-shape bg-gradient-primary shadow text-center border-radius-md">
                <i class="ni ni-single-02 text-lg opacity-10" aria-hidden="true"></i>
               </div>
              </div>
             </div>
            </div>
           </div>
          </div>

          <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
           <div class="card">
            <div class="card-body p-3">
             <div class="row">
              <div class="col-8">
               <div class="numbers">
                <p class="text-sm mb-0 text-capitalize font-weight-bold">Head Judge <i class="ni ni-bold-right text-success"></i></p>
                <div class="font-weight-bolder mb-0">
                 <span class="text-sm font-weight-bolder">TOTAL <i class="ni ni-bold-down text-success"></i></span>
                 <span class="text-success text-sm font-weight-bolder text-center"><h1><%= headCount %></h1></span>
                </div>
               </div>
              </div>
              <div class="col-4 text-end">
               <div class="icon icon-shape bg-gradient-primary shadow text-center border-radius-md">
                <i class="ni ni-hat-3 text-lg opacity-10" aria-hidden="true"></i>
               </div>
              </div>
             </div>
            </div>
           </div>
          </div>


          <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
           <div class="card">
            <div class="card-body p-3">
             <div class="row">
              <div class="col-8">
               <div class="numbers">
                <p class="text-sm mb-0 text-capitalize font-weight-bold">Judge Details <i class="ni ni-bold-right text-success"></i></p>
                <div class="font-weight-bolder mb-0">
                 <span class="text-sm font-weight-bolder">TOTAL <i class="ni ni-bold-down text-success"></i></span>
                 <span class="text-success text-sm font-weight-bolder text-center"><h1><%= judgeCount %></h1></span>
                </div>
               </div>
              </div>
              <div class="col-4 text-end">
               <div class="icon icon-shape bg-gradient-primary shadow text-center border-radius-md">
                <i class="ni ni-sound-wave text-lg opacity-10" aria-hidden="true"></i>
               </div>
              </div>
             </div>
            </div>
           </div>
          </div>


          <div class="col-xl-3 col-sm-6">
           <div class="card">
            <div class="card-body p-3">
             <div class="row">
              <div class="col-8">
               <div class="numbers">
                <p class="text-sm mb-0 text-capitalize font-weight-bold">Gymnast Details <i class="ni ni-bold-right text-success"></i></p>
                <div class="font-weight-bolder mb-0">
                 <span class="text-sm font-weight-bolder">TOTAL <i class="ni ni-bold-down text-success"></i></span>
                 <span class="text-success text-sm font-weight-bolder text-center"><h1><%= gymnastCount %></h1></span>
                </div>
               </div>
              </div>
              <div class="col-4 text-end">
               <div class="icon icon-shape bg-gradient-primary shadow text-center border-radius-md">
                <i class="ni ni-user-run text-lg opacity-10" aria-hidden="true"></i>
               </div>
              </div>
             </div>
            </div>
           </div>
          </div>


          <h6 style="margin-top:20px"><span class="badge bg-gradient-dark">Team Information : <%= teamCount %> Teams</span></h6>

          <!-- Team Table -->
          <div class="col-12">
           <div class="card mb-4">
            <div class="card-header pb-0">
            </div>
            <div class="card-body px-0 pt-0 pb-2">
             <div class="table-responsive p-0">
              <% if (gymnastsByTeam.isEmpty()) { %>
              <div class="text-center" style="font-family: 'Comic Sans MS', cursive;">
               <img src="sleepingcat.gif" alt="Cat Image" style="max-width: 100px;">
               <p style="text-transform: uppercase;">CURRENTLY NO DATA</p>
              </div>
              <% } else { %>
              <table class="table align-items-center mb-0">
               <thead>
                <tr>
                 <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Team Name</th>
                 <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Gymnast Name</th>
                 <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Gymnast Identity Card</th>
                 <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Gymnast School</th>
                 <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Category / Apparatus</th>
                </tr>
               </thead>
               <tbody>
                <% for (Map.Entry<String, List<Gymnast>> entry : gymnastsByTeam.entrySet()) { %>
                <% int rowCount = 1; %>
                <tr>
                 <td colspan="5" class="text-uppercase">
                  <span class="badge bg-gradient-dark"><%= entry.getKey() %></span>
                 </td>
                </tr>
                <% for (Gymnast gymnast : entry.getValue()) { 
                        int index = gymnasts.indexOf(gymnast);
                        Apparatus apparatus = apparatusList.get(index);
                %>
                <tr>
                 <td class="text-center"><%= rowCount++ %>.</td>
                 <!-- Empty cell for team name -->
                 <td>
                  <div class="d-flex px-2 py-1">
                   <div class="d-flex flex-column justify-content-center">
                    <p class="text-xs font-weight-bold mb-0"><%= gymnast.getGymnastName() %></p>
                   </div>
                  </div>
                 </td>
                 <td>
                  <p class="text-xs font-weight-bold mb-0"><%= gymnast.getGymnastIC() %></p>
                  <!--<p class="text-xs text-secondary mb-0"><%= gymnast.getGymnastIC() %></p>-->
                 </td>
                 <td>
                  <h5 class="text-xs font-weight-bold mb-0"><%= gymnast.getGymnastSchool() %></h5>
                  <!--<p class="text-xs text-secondary mb-0"><%= gymnast.getGymnastIC() %></p>-->
                 </td>
                 <td class="align-middle text-center text-sm">
                  <div class="d-flex flex-column justify-content-center">
                   <p class="text-xs text-secondary mb-0"><span class="badge badge-sm bg-gradient-success"><%= gymnast.getGymnastCategory() %></span></p>
                   <p class="text-xs text-secondary mb-0"><%= apparatus.getApparatusName() %></p>
                  </div>
                 </td>
                </tr>
                <% } %>
                <% } %>
               </tbody>
              </table>
              <% } %>
             </div>
            </div>
           </div>
          </div>

         </div>
        </div>
       </div>
      </section>
     </div>
     <footer class="footer">
      <div class="d-sm-flex justify-content-center justify-content-sm-between">
       <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2024<a
         href="" target="_blank"></a> Gymnastic Scoring System</span>
      </div>
     </footer>
    </div>
   </div>
  </div>

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
 </body>

</html>
