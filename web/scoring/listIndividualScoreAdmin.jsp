
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.scoring.bean.Composite" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
        <link rel="icon" type="image/png" href="assets/img/favicon.png">
        <link href="registration/vendors/feather/feather.css" rel="stylesheet" type="text/css"/>
        <link href="registration/vendors/ti-icons/css/themify-icons.css" rel="stylesheet" type="text/css"/>
        <link href="registration/vendors/css/vendor.bundle.base.css" rel="stylesheet" type="text/css"/>
        <link href="registration/assets/css/vertical-layout-light/style.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="registration/assets/img/favicon.png" />

        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">

        <title>
            Gymnast Personal Information
        </title>
        <!--     Fonts and icons     -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
        <!-- Nucleo Icons -->
        <link href="registration/assets/css/nucleo-icons.css" rel="stylesheet" type="text/css"/>
        <link href="registration/assets/css/nucleo-svg.css" rel="stylesheet" type="text/css"/>
        <!-- Font Awesome Icons -->
        <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
        <link href="registration/assets/css/nucleo-svg.css" rel="stylesheet" type="text/css"/>
        <!-- CSS Files -->
        <link href="registration/assets/css/soft-ui-dashboard.css" rel="stylesheet" type="text/css"/>

        <style>
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

    <body>
        <div class="container-scroller">
            <!-- partial:partials/_navbar.html -->
            <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
                <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
                    <a class="navbar-brand brand-logo mr-5" href=""> <img src="registration/assets/img/curved-images/sport16.jpg" class="mr-1" alt="logo"/></a>
                    <a class="navbar-brand brand-logo-mini" href=""><img src="registration/assets/img/curved-images/gym.jpg" alt="logo"/></a>
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
                                <a  href="LiveScoring">
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
                <!-- partial:partials/_settings-panel.html -->

                <!-- partial:partials/_sidebar.html -->
                <nav class="sidebar sidebar-offcanvas" id="sidebar">
                    <ul class="nav">
                        <!--                        <li class="nav-item">
                                                    <a class="nav-link" href="dashboard.jsp">
                                                        <i class="icon-grid menu-icon"></i>
                                                        <span class="menu-title">Dashboard</span>
                                                    </a>
                                                </li>-->
                        <li class="nav-item">
                            <a class="nav-link"  href="Score" aria-expanded="false" aria-controls="ui-basic">
                                <i class="icon-layout menu-icon"></i>
                                <span class="menu-title">Key In Score</span>
                                <i class="menu-arrow"></i>
                            </a>

                        </li>
                        <li class="nav-item">
                            <a class="nav-link"  href="Team" aria-expanded="false" aria-controls="charts">
                                <i class="icon-bar-graph menu-icon"></i>
                                <span class="menu-title">Team</span>
                                <i class="menu-arrow"></i>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Gymnast" aria-expanded="false" aria-controls="tables">
                                <i class="icon-grid-2 menu-icon"></i>
                                <span class="menu-title">Gymnast</span>
                                <i class="menu-arrow"></i>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="LiveScoringAdmin" aria-expanded="false" aria-controls="">
                                <i class="icon-grid-2 menu-icon"></i>
                                <span class="menu-title">Leaderboard</span>
                                <i class="menu-arrow"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
                <!-- partial -->
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="page-header align-items-start min-vh-50 pt-5 pb-11 m-3 border-radius-lg" style="background-image: url('registration/assets/img/curved-images/sport8.jpg');">
                            <span class="mask bg-gradient-dark opacity-0"></span>
                            <div class="container">
                                <div class="row justify-content-center">
                                </div>
                            </div>
                        </div>

                        <div class="container-fluid py-4">
                            <div class="row">
                                <div class="col-12">
                                    <div class="card ">
                                        <div class="card-header pb-0">
                                            <h6>Gymnast Score Information</h6>
                                        </div>
                                        <div class="card-body px-5 pt-0 pb-2 ">

                                            <form action="" class="d-flex" method="post">
                                                <select class="form-control mb-3 ml-3" name="gymnastID" style="width:300px">
                                                    <option value="0" selected>Filter The Gymnast</option>
                                                    <% 
                                              List<Composite> listGymnast = (List<Composite>) request.getAttribute("listGymnast");
                                                           List<String> listSeenGymnast = new ArrayList<>();
                                               if (listGymnast != null && !listGymnast.isEmpty()) {
                                                     int x = 0; // Initialize counter variable
                                               while (x < listGymnast.size()) {
                                                       Composite composite2 = (Composite) listGymnast.get(x); // Assuming ArrayList type
                                                        String currentGymnastName = composite2.getGymnast().get(x).getGymnastName();
                                                        
if(!listSeenGymnast.contains(currentGymnastName)){
                                                    %>

                                                    <option value="<%= composite2.getGymnast().get(x).getGymnastID()%>"><%= composite2.getGymnast().get(x).getGymnastName()%></option>

                                                    <%
                                                        listSeenGymnast.add(currentGymnastName);
                                                        }
                                                             x++;       
                                                           }
                                                     }

                                                    %>
                                                </select>

                                                <select class="form-control mb-3 ml-3" name="teamID" style="width:300px">
                                                    <option value="0" selected>Filter The Team</option>
                                                    <%
                                                      List<Composite> listTeam = (List<Composite>) request.getAttribute("listTeam");
                                                      List<String> listSeenTeamNames = new ArrayList<>(); // Store unique team names

                                                      if (listTeam != null && !listTeam.isEmpty()) {
                                                        int z = 0;
                                                        while (z < listTeam.size()) {
                                                          Composite composite3 = (Composite) listTeam.get(z);
                                                          String currentTeamName = composite3.getTeam().get(z).getTeamName();

                                                          if (!listSeenTeamNames.contains(currentTeamName)) {
                                                            // Display option only if name is not found in the list
                                                    %>
                                                    <option value="<%= composite3.getTeam().get(z).getTeamID()%>"><%= currentTeamName %></option>
                                                    <%
                                                    listSeenTeamNames.add(currentTeamName); // Add name to list for next iteration
                                                  }
                                                  z++;
                                                }
                                              }
                                                    %>
                                                </select>



                                                <select class="form-control mb-3 ml-3" name="apparatusID" style="width:300px">
                                                    <option selected value="0">Filter The Apparatus</option>
                                                    <% 
                                                             List<Composite> listApparatus = (List<Composite>) request.getAttribute("listApparatus");  
                                                             List<String> listSeenApparatusNames = new ArrayList<>();
                                                             
                                               if (listApparatus != null && !listApparatus.isEmpty()) {
                                                     int v = 0; // Initialize counter variable
                                                      
                                               while (v < listApparatus.size()) {
                                               Composite composite4 = (Composite) listApparatus.get(v); // Assuming ArrayList type
                                                        String currentApparatusName = composite4.getApparatus().get(v).getApparatusName();
                                               if (!listSeenApparatusNames.contains(currentApparatusName)) {
                                                       
                                                    %>

                                                    <option value="<%= composite4.getApparatus().get(v).getApparatusID()%>"><%= composite4.getApparatus().get(v).getApparatusName()%></option>

                                                    <%
                                                        }
                                                     listSeenApparatusNames.add(currentApparatusName);
                                                             v++;       
                                                           }
                                                     }

                                                    %>
                                                </select>
                                                <button type="submit" name="submit" class="btn btn-primary ml-3" style="height:50px">Filter</button>
                                            </form>

                                            <div class="table-responsive pt-3">
                                                <div class="text-center">
                                                    <table class="table table-striped mb-5 bg-white" id="sourceTable" style="width:100%;max-height:500px;">
                                                        <thead>
                                                            <tr >
                                                                <th >GymnastID</th>
                                                                <th>GYMNAST</th>
                                                                <th>CLUB</th>
                                                                <th>FREE</th>
                                                                <th>RIBBON</th>
                                                                <th>HOOP</th>
                                                                <th>BALL</th>
                                                                <th>CLUBS</th>
                                                                <th>INDIVIDUAL SCORE</th>
                                                                <th></th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% 
                                                              List<Composite> listScoreboard = (List<Composite>) request.getAttribute("listScoreboard");
                                                              Map<String, Double> individualScores = new HashMap<>();
                                                              List<String> listSeenGymnastScore = new ArrayList<>();

                                                              if (listScoreboard != null && !listScoreboard.isEmpty()) {
                                                                int i = 0; // Initialize counter variable
                                                                int rank = 1;
                                                                while (i < listScoreboard.size()) {
                                                                  Composite composite = (Composite) listScoreboard.get(i); 
                                                                  String currentGymnastScore = composite.getGymnast().get(i).getGymnastName();
                                                                  String gymnastName = composite.getGymnast().get(i).getGymnastName();
                                                                  double finalScore = composite.getScore().get(i).getFinalScore();
                                                                  boolean gymnastShown = individualScores.containsKey(gymnastName);
                                                                  Double currentIndividualScore = individualScores.get(gymnastName);
                                                                  individualScores.put(gymnastName, currentIndividualScore == null ? finalScore : currentIndividualScore + finalScore);
                    //                                              if (!listSeenGymnastScore.contains(currentGymnastScore)) {
                                                            %>

                                                            <tr>
                                                                <td><%= composite.getGymnast().get(i).getGymnastID()%></td>
                                                                <td><%= composite.getGymnast().get(i).getGymnastName()%></td>
                                                                <td><%= composite.getTeam().get(i).getTeamName()%></td>
                                                                <% if(composite.getApparatus().get(i).getApparatusName().equals("Free Hand")){%>
                                                                <td><%= String.format("%.3f", composite.getScore().get(i).getFinalScore()) %></td>
                                                                <% }else{%>
                                                                <td></td>
                                                                <% }%>

                                                                <% if(composite.getApparatus().get(i).getApparatusName().equals("Ribbon")){ %>
                                                                <td><%= String.format("%.3f", composite.getScore().get(i).getFinalScore()) %></td>
                                                                <% }else{%>
                                                                <td></td>
                                                                <% } %>

                                                                <% if(composite.getApparatus().get(i).getApparatusName().equals("Hoop")){ %>
                                                                <td><%= String.format("%.3f", composite.getScore().get(i).getFinalScore()) %></td>
                                                                <% }else{%>
                                                                <td></td>
                                                                <% }%>

                                                                <% if(composite.getApparatus().get(i).getApparatusName().equals("Ball")){ %>
                                                                <td><%= String.format("%.3f", composite.getScore().get(i).getFinalScore()) %></td>
                                                                <% }else{ %>
                                                                <td></td>
                                                                <% } %>

                                                                <% if(composite.getApparatus().get(i).getApparatusName().equals("Clubs")){ %>
                                                                <td><%= String.format("%.3f", composite.getScore().get(i).getFinalScore()) %></td>
                                                                <% }else{ %>
                                                                <td></td>
                                                                <% } %>


                                                                <td><%= String.format("%.3f", composite.getScore().get(i).getFinalScore()) %></td>

                                                                <td><a href="LiveScoring?gymnastID='" <%= composite.getGymnast().get(i).getGymnastID()%> >info > </a></td>
                                                            </tr>

                                                            <%
                    //                                          listSeenGymnastScore.add(currentGymnastScore);
                    //                                      }
                                                          i++; // Increment counter
                                                          rank++;
                                                        }
                                                      }
                                                            %>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <footer class="footer">
                            <div class="d-sm-flex justify-content-center justify-content-sm-between">
                                <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright � 2024<a href="" target="_blank"></a> Gymnastic Scoring System. All rights reserved.</span>
                                <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="ti-heart text-danger ml-1"></i></span>
                            </div>
                        </footer>

                        <script>

                            function rankingTable() {

                                const sourceTable = document.getElementById('sourceTable');
                                const resultTableBody = document.getElementById('resultTable').getElementsByTagName('tbody')[0];

                                // Function to calculate gymnast score (can be modified based on your table structure)
                                function getGymnastScore(row) {
                                    const gymnastScoreCell = row.getElementsByTagName('td')[8]; // Assuming score is in 3rd column (index 2)
                                    return parseFloat(gymnastScoreCell.innerText);
                                }

                                // Function to get gymnast ID (modify based on your table structure)
                                function getGymnastID(row) {
                                    const gymnastIDCell = row.getElementsByTagName('td')[0]; // Assuming ID is in 1st column (index 0)
                                    return gymnastIDCell.innerText;
                                }

                                // Extract and accumulate data from source table
                                const gymnastData = {};
                                for (const row of sourceTable.getElementsByTagName('tr')) {
                                    if (row.rowIndex === 0)
                                        continue; // Skip header row
                                    const gymnastName = row.getElementsByTagName('td')[1].innerText;
                                    const clubName = row.getElementsByTagName('td')[2].innerText;
                                    const score = getGymnastScore(row);
                                    const gymnastID = getGymnastID(row);
                                    const freeScore = row.getElementsByTagName('td')[3].innerText;
                                    const ribbonScore = row.getElementsByTagName('td')[4].innerText;
                                    const hoopScore = row.getElementsByTagName('td')[5].innerText;
                                    const ballScore = row.getElementsByTagName('td')[6].innerText;
                                    const clubsScore = row.getElementsByTagName('td')[7].innerText;
                                    // Check if gymnast exists in gymnastData
                                    if (!gymnastData.hasOwnProperty(gymnastName)) {
                                        gymnastData[gymnastName] = {gymnastName, clubName, gymnastID, freeScore: 0, ribbonScore: 0, hoopScore: 0, ballScore: 0, score: 0};
                                    }

                                    // Accumulate score for existing gymnast
                                    gymnastData[gymnastName].score += score;
                                    gymnastData[gymnastName].freeScore += freeScore;
                                    gymnastData[gymnastName].ribbonScore += ribbonScore;
                                    gymnastData[gymnastName].hoopScore += hoopScore;
                                    gymnastData[gymnastName].ballScore += ballScore;
                                    gymnastData[gymnastName].clubsScore += clubsScore;
                                }

                                // Convert gymnastData object to array and sort
                                const gymnastDataArray = Object.values(gymnastData);
                                gymnastDataArray.sort((a, b) => b.score - a.score);

                                // Generate ranking and populate result table
                                let rank = 1;
                                for (const gymnast of gymnastDataArray) {
                                    const tableRow = document.createElement('tr');
                                    const rankCell = document.createElement('td');
                                    rankCell.innerText = rank++;

                                    const gymnastNameCell = document.createElement('td');
                                    gymnastNameCell.innerText = gymnast.gymnastName;

                                    const clubNameCell = document.createElement('td');
                                    clubNameCell.innerText = gymnast.clubName;


                                    const freeCell = document.createElement('td');
                                    if (parseFloat(gymnast.freeScore).toFixed(2) == 0.00) {
                                        freeCell.innerText = "";
                                    } else {
                                        freeCell.innerText = parseFloat(gymnast.freeScore).toFixed(2);
                                    }

                                    const ropeCell = document.createElement('td');
                                    if (parseFloat(gymnast.ribbonScore).toFixed(2) == 0.00) {
                                        ropeCell.innerText = "";
                                    } else {
                                        ropeCell.innerText = parseFloat(gymnast.ribbonScore).toFixed(2);
                                    }

                                    const hoopCell = document.createElement('td');
                                    if (parseFloat(gymnast.hoopScore).toFixed(2) == 0.00) {
                                        hoopCell.innerText = "";
                                    } else {
                                        hoopCell.innerText = parseFloat(gymnast.hoopScore).toFixed(2);
                                    }

                                    const ballCell = document.createElement('td');
                                    if (parseFloat(gymnast.ballScore).toFixed(2) == 0.00) {
                                        ballCell.innerText = "";
                                    } else {
                                        ballCell.innerText = parseFloat(gymnast.ballScore).toFixed(2);
                                    }

                                    const clubsCell = document.createElement('td');
                                    if (parseFloat(gymnast.clubsScore).toFixed(2) == 0.00) {
                                        clubsCell.innerText = "";
                                    } else {
                                        clubsCell.innerText = parseFloat(gymnast.ballScore).toFixed(2);
                                    }

                                    const scoreCell = document.createElement('td');
                                    const scoreAnchor = document.createElement('a');
                                    scoreAnchor.innerText = gymnast.score.toFixed(2);
                                    // You can customize the link URL here

                                    scoreCell.appendChild(scoreAnchor);
                                    const actionCell = document.createElement('td');
                                    actionCell.innerHTML = '<a href="LiveScoring?gymnastID=' + gymnast.gymnastID + '">info > </a>';

                                    tableRow.appendChild(rankCell);
                                    tableRow.appendChild(gymnastNameCell);
                                    tableRow.appendChild(clubNameCell);
                                    tableRow.appendChild(freeCell);
                                    tableRow.appendChild(ropeCell);
                                    tableRow.appendChild(hoopCell);
                                    tableRow.appendChild(ballCell);
                                    tableRow.appendChild(clubsCell);
                                    tableRow.appendChild(scoreCell);
                                    tableRow.appendChild(actionCell);

                                    resultTableBody.appendChild(tableRow);
                                }

                                sourceTable.style.display = "none";
                            }
                            rankingTable();

                        </script>


                        </body>
                        </html>
                        <!--   Core JS Files   -->
                        <script src="registration/vendors/js/vendor.bundle.base.js" type="text/javascript"></script>
                        <script src="registration/assets/js/core/popper.min.js"></script>
                        <script src="registration/assets/js/core/bootstrap.min.js"></script>
                        <script src="registration/assets/js/plugins/perfect-scrollbar.min.js"></script>
                        <script src="registration/assets/js/plugins/smooth-scrollbar.min.js"></script>
                        <script src="registration/assets/off-canvas.js" type="text/javascript"></script>
                        <script src="registration/assets/hoverable-collapse.js" type="text/javascript"></script>
                        <script src="registration/assets/template.js" type="text/javascript"></script>
                        <script src="registration/assets/settings.js" type="text/javascript"></script>
                        <script src="registration/assets/todolist.js" type="text/javascript"></script>

