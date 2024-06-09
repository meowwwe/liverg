<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.connection.DBConnect" %>
<%@ page import="com.registration.bean.Team" %>

<%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    List<Team> teams = new ArrayList<>(); // Assuming you have a Team class

    try {
        DBConnect db = new DBConnect();
        con = db.getConnection();
        stmt = con.createStatement();
        
        // Fetching data from TEAM table
        rs = stmt.executeQuery("SELECT * FROM TEAM");
        while (rs.next()) {
            Team team = new Team();
            team.setTeamID(rs.getInt("teamID"));
            team.setTeamName(rs.getString("teamName"));
            teams.add(team);
        }
        rs.close(); // Close the ResultSet before reusing the Statement
%> 

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
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <link rel="shortcut icon" href="assets/img/favicon.png" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">

  <title>
   Judge Information
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
   .card {
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    margin-top: -30px;
   }
   .table th, .table td {
    vertical-align: middle;
    text-align: center;
   }
   .table thead th {
    background-color: #343a40;
    color: #fff;
   }
   .table tbody tr:hover {
    background-color: #f1f1f1;
   }
   .container-fluid {
    padding: 20px;
    background-color: #f8f9fa;
    padding-top: 0;
    margin-top: 70px; /* Adjust the top margin to create space */
   }
   .card-header h6 {
    font-size: 1.25rem;
    font-weight: bold;
   }
   .modal-body {
    text-align: left; /* Align text to the left inside modal */
   }
   .page-body-wrapper {
    padding-top: 0px; /* Adjust padding to match the top margin of container-fluid */
   }
  </style>

 </head>

 <body>
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
        <a class="dropdown-item">
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

    <%   
        String userRole = (String) session.getAttribute("userRole");
        Integer staffID = (Integer) session.getAttribute("staffID");

        if (staffID == null) {
            response.sendRedirect("../LogoutServlet");
        } else if (userRole != null) {
            if (userRole.equals("clerk")) {
                // Clerk Navbar
    %><jsp:include page="clerkNavbar.jsp" /><%
            } else if (userRole.equals("staff")) {
                // Staff Navbar
    %><jsp:include page="staffNavbar.jsp" /><%
            } else {
                // Handle other roles if needed
            }
        } else {
            // Handle the case where userRole is null
            response.sendRedirect("../LogoutServlet");
        }
    %>


    <div class="main-panel">
     <div class="content-wrapper">
      <section class="min-vh-100 mb-8">
       <div class="page-header align-items-start min-vh-50 pt-5 pb-11 m-3 border-radius-lg" style="background-image: url('assets/img/curved-images/sport8.jpg');">
        <span class="mask bg-gradient-dark opacity-0"></span>
        <div class="container">
         <div class="row justify-content-center">
         </div>
        </div>
       </div>


       <div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="errorModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
         <div class="modal-content">
          <div class="modal-header">
           <h5 class="modal-title" id="errorModalLabel">Error</h5>
          </div>
          <div class="modal-body" id="errorMsg">
           Please fill in all fields.
          </div>
          <div class="modal-footer">
           <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          </div>
         </div>
        </div>
       </div>

       <div class="container-fluid py-4">
        <div class="row">
         <div class="col-12">
          <div class="card mb-2" style="margin-top: -30px;"> <!-- Negative margin to pull the card upwards -->
           <div class="card-header pb-0 d-flex justify-content-between align-items-center">
            <h6>Judge Information</h6>
            <a href="#" class="btn btn-sm bg-gradient-dark my-4 mb-2" data-bs-toggle="modal" data-bs-target="#AddJudgeModal">Add</a>
           </div>
           <div class="card-body px-0 pt-0 pb-2">
            <div class="table-responsive p-0">
             <table class="table">
              <thead class="thead-light">
               <tr>
                <th scope="col">#</th>
                <th scope="col">Judge Name</th>
                <th scope="col">Judge Identity Card</th>
                <th scope="col">Judge Place Of Duty</th>
                <th scope="col">Team</th>
                <th scope="col">Action</th>
               </tr>
              </thead>

              <div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
               <div class="modal-dialog">
                <div class="modal-content">
                 <div class="modal-header">
                  <h5 class="modal-title" id="confirmationModalLabel">Confirmation</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                 </div>
                 <div class="modal-body">
                  Are you sure you want to delete the data?
                 </div>
                 <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                  <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                 </div>
                </div>
               </div>
              </div>
              <tbody id="judgeTableBody">

               <!-- Modal Add Judge -->
              <div class="modal fade" id="AddJudgeModal" tabindex="-1" aria-hidden="true">
               <div class="modal-dialog">
                <div class="modal-content">
                 <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">Add Judge</h5>
                  <button type="button" id="closeModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                 </div>
                 <div class="modal-body">
                  <!-- Your form content goes here -->
                  <form id="ajaxAddJudge">
                   <div class="mb-3">
                    <label class="form-label">Judge Name</label>
                    <input type="text" name="judgeName" id="judgeName" class="form-control">
                   </div>
                   <div class="mb-3">
                    <label class="form-label">Judge Identity Card</label>
                    <input type="text" name="judgeIC" id="judgeIC" class="form-control">
                   </div>
                   <div class="mb-3">
                    <label class="form-label">Judge Place Of Duty</label>
                    <input type="text" name="judgePOD" id="judgePOD" class="form-control">
                   </div>
                   <div class="mb-3">
                    <label class="form-label">Judge Team</label>
                    <select name="judgeTeam" id="judgeTeam" class="form-control" style="color: black">
                     <option value="" hidden>Select a Team</option>
                     <% for (Team team : teams) { %>
                     <option value="<%= team.getTeamID() %>"><%= team.getTeamName() %></option>
                     <% } %>
                    </select>
                   </div>

                   <button type="button" onclick="addJudge()" class="btn btn-sm bg-gradient-dark my-4 mb-2">Submit</button>
                  </form>
                 </div>
                 <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                 </div>
                </div>
               </div>
              </div>

              <!-- Update Judge Modal -->
              <div class="modal fade" id="updateJudgeModal" tabindex="-1" aria-hidden="true">
               <div class="modal-dialog">
                <div class="modal-content">
                 <div class="modal-header">
                  <h5 class="modal-title">Update Judge</h5>
                  <button type="button" id="closeModalUpdate" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                 </div>
                 <div class="modal-body">
                  <!-- Update Judge Form -->
                  <form id="ajaxUpdateJudge">
                   <div class="mb-3">
                    <label class="form-label">Judge Name</label>
                    <input type="text" name="updateJudgeName" id="updateJudgeName" class="form-control">
                   </div>
                   <div class="mb-3">
                    <label class="form-label">Judge Identity Card</label>
                    <input type="text" name="updateJudgeIC" id="updateJudgeIC" class="form-control">
                   </div>
                   <div class="mb-3">
                    <label class="form-label">Judge Place Of Duty</label>
                    <input type="text" name="updateJudgePOD" id="updateJudgePOD" class="form-control">
                   </div>
                   <div class="mb-3">
                    <label class="form-label">Judge Team</label>
                    <select name="updateJudgeTeam" id="updateJudgeTeam" class="form-control" style="color: black">
                     <option value="" hidden>Select a Team</option>
                     <% for (Team team : teams) { %>
                     <option value="<%= team.getTeamID() %>"><%= team.getTeamName() %></option>
                     <% } %>
                    </select>
                   </div>
                   <div class="mb-3">
                    <input type="text" hidden name="updateJudgeID" id="updateJudgeID" class="form-control">
                   </div>
                   <button type="button" onclick="updateJudge()" class="btn btn-sm bg-gradient-dark my-4 mb-2">Submit</button>
                  </form>
                 </div>
                 <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                 </div>
                </div>
               </div>
              </div>

              </tbody>
             </table>
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


  <%
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
  %>



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
                    function fetchJudgeData() {
                     $.ajax({
                      type: 'GET',
                      url: '../ListJudgeServlet',
                      dataType: 'JSON',
                      success: function (data) {
                       // Clear existing table content
                       $('#judgeTableBody').empty();

                       var rowIndex = 1;
                       // Iterate over received data and generate HTML for each Judge
                       $.each(data, function (index, judge) {
                        // Create table row for judge data
                        var row = $('<tr>');
                        // Create table cells for Judge ID, username, and password
                        //var judgeIDCell = $('<td>').text(judge.judgeID);
                        var rowNumberCell = $('<td>').text(rowIndex).addClass('align-middle text-center text-sm');
                        var judgeNameCell = $('<td>').text(judge.judgeName);
                        var judgeICCell = $('<td>').text(judge.judgeNoIc);
                        var judgePODCell = $('<td>').text(judge.judgePOD);
                        var judgeTeamCell = $('<td>').text(judge.teamName);

                        // Create edit and delete buttons
                        var editButton = $('<button>').addClass('btn bg-gradient-dark')
                                .html('<i class="bi bi-file-earmark-check-fill bi-lg"></i>')
                                .attr('data-bs-toggle', 'modal')
                                .attr('data-bs-target', '#updateJudgeModal')
                                .css('margin-right', '5px');

                        var deleteButton = $('<button>').addClass('btn bg-gradient-dark')
                                .html('<i class="bi bi-trash2-fill"></i>')
                                .attr('data-bs-toggle', 'modal')
                                .attr('data-bs-target', '#confirmationModal');

                        // Add click event handlers to buttons
                        editButton.click(function () {
                         console.log("Updating Judge ID:", judge.judgeID);
                         displayJudge(judge.judgeID); //Pass Parameter
                        });

                        deleteButton.click(function () {
                         deleteJudge(judge.judgeID); // Implement deleteJudge function
                        });

                        // Append buttons to a cell
                        var actionCell = $('<td>').addClass('align-middle text-center text-sm').append(editButton, deleteButton);

                        // Append cells to the row
                        row.append(rowNumberCell, judgeNameCell, judgeICCell, judgePODCell, judgeTeamCell, actionCell);

                        // Append row to the table body
                        $('#judgeTableBody').append(row);

                        rowIndex++;
                       });
                      },
                      error: function (xhr, status, error) {
                       console.error("Error occurred during AJAX request:", error);
                      }
                     });
                    }
                    $(document).ready(function () {
                     fetchJudgeData();
                    });
  </script>


  <script>
   var msg = null;
   function addJudge() {
    var name = $("#judgeName").val().trim();
    var username = $("#judgeIC").val().trim();
    var password = $("#judgePOD").val().trim();

    // Check if any field is empty
    if (!judgeName || !judgeIC || !judgePOD) {
     alert("Please fill in all fields.");
     return;
    }

    var data = $("#ajaxAddJudge").serialize();

    $.ajax({
     type: 'POST',
     url: '../AddJudgeServlet',
     data: data,
     dataType: 'JSON',

     success: function (data) {
      msg = data[0].msg

      if (msg == 1) {
       alert('Submit Inserted');
       $('#ajaxAddJudge')[0].reset();
       $("#closeModal").trigger('click');
       fetchJudgeData();

      } else {
       alert('Data Not Inserted');
      }
     }
    })
   }
  </script>

  <script>
   // Function to handle deletion after confirmation
   function deleteJudge(judgeID) {
    console.log("Deleting Judge ID:", judgeID);
    // Show confirmation modal
    $('#confirmationModal').modal('show');
    $('#confirmDeleteBtn').click(function () {
     $.ajax({
      type: 'POST',
      url: '../DeleteJudgeServlet',
      data: {judgeID: judgeID},
      success: function (response) {
       console.log("Judge deleted successfully");
       fetchJudgeData();
      },
      error: function (xhr, status, error) {
       // Handle error
       console.error("Error deleting Judge:", error);
      }
     });

     $('#confirmationModal').modal('hide');
    });
   }
  </script>

  <script>
   function updateJudge() {
    var formData = $("#ajaxUpdateJudge").serialize();

    $.ajax({
     type: 'POST',
     url: '../UpdateJudgeServlet',
     data: formData,
     dataType: 'JSON',
     success: function (response) {
      if (response.success) {
       alert('Judge information updated successfully');
       $("#closeModalUpdate").trigger('click');
       fetchJudgeData();
      } else {
       alert('Failed to update judge information. Please try again.');
      }
     },
     error: function (xhr, status, error) {
      console.error("Error updating judge information:", error);
      alert('An error occurred while updating judge information. Please try again later.');
     }
    });
   }
  </script>

  <script>
   function displayJudge(judgeID) {

    $.ajax({
     type: 'GET',
     url: '../DisplayJudgeServlet',
     data: {judgeID: judgeID},
     dataType: 'JSON',
     success: function (judge) {
      $('#updateJudgeName').val(judge.judgeName);
      $('#updateJudgeIC').val(judge.judgeNoIc);
      $('#updateJudgePOD').val(judge.judgePOD);
      $('#updateJudgeID').val(judge.judgeID);
      $('#updateJudgeModal').modal('show');
     },
     error: function (xhr, status, error) {
      console.error("Error retrieving judge information:", error);
     }
    });
   }
  </script>

  <script>
   $(document).ready(function () {
    function togglePasswordVisibility(passwordFieldId1, passwordFieldId2, toggleIconId) {
     var passwordField1 = document.getElementById(passwordFieldId1);
     var passwordField2 = document.getElementById(passwordFieldId2);
     var toggleIcon = document.getElementById(toggleIconId);

     if (passwordField1 && passwordField2 && toggleIcon) {
      if (passwordField1.type === "password") {
       passwordField1.type = "text";
       passwordField2.type = "text";
       toggleIcon.classList.remove("bi-eye");
       toggleIcon.classList.add("bi-eye-slash");
      } else {
       passwordField1.type = "password";
       passwordField2.type = "password";
       toggleIcon.classList.remove("bi-eye-slash");
       toggleIcon.classList.add("bi-eye");
      }
     } else {
      console.error('One or more elements not found:', {
       passwordField1,
       passwordField2,
       toggleIcon
      });
     }
    }

    // Attach the function to the global scope
    window.togglePasswordVisibility = togglePasswordVisibility;
   });
  </script>

 </body>
</html>



