<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>

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
   Team Information
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
            <h6>Team Information</h6>
            <div class="d-flex">
             <a href="#" class="btn btn-sm bg-gradient-dark my-4 mb-2 me-2" data-bs-toggle="modal" data-bs-target="#addCoachModal">Add Coach/Team</a>
            </div>
           </div>
           <div class="card-body px-0 pt-0 pb-2">
            <div class="table-responsive p-0">
             <table class="table">
              <thead class="thead-light">
               <tr>
                <th scope="col">#</th>
                <th scope="col">Coach Details</th>
<!--                <th scope="col">Coach Identity Card</th>
                <th scope="col">Coach Place Of Duty</th>-->
                <th scope="col">Fisio Details</th>
<!--                <th scope="col">Fisio Identity Card</th>
                <th scope="col">Fisio Place Of Duty</th>-->
                <th scope="col">Team Name</th>
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
              <tbody id="teamTableBody">

               <!--Modal Add Coach-->
              <div class="modal fade" id="addCoachModal" tabindex="-1" aria-labelledby="addCoachModalLabel" aria-hidden="true">
               <div class="modal-dialog">
                <div class="modal-content">
                 <div class="modal-header">
                  <h5 class="modal-title" id="addCoachModalLabel">Coach Information</h5>
                  <button type="button" id="closeModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>

                 </div>
                 <div class="modal-body">
                  <form id="ajaxAddCoach">

                   <div class="mb-3">
                    <label class="form-label">Coach Name</label>
                    <input type="text" class="form-control" name="coachName" id="coachName">
                   </div>
                   <div class="mb-3">
                    <label class="form-label">Coach Identity Card</label>
                    <input type="text" class="form-control" name="coachIC" id="coachIC">
                   </div>
                   <div class="mb-3">
                    <label class="form-label">Coach Place Of Duty</label>
                    <input type="text" class="form-control" name="coachPOD" id="coachPOD">
                   </div>
                   <div class="mb-3">
                    <label class="form-label">Fisio Name</label>
                    <input type="text" class="form-control" name="fisioName" id="fisioName">
                   </div>

                   <div class="mb-3">
                    <label class="form-label">Fisio Identity Card</label>
                    <input type="text" class="form-control" name="fisioIC" id="fisioIC">
                   </div>

                   <div class="mb-3">
                    <label class="form-label">Fisio Place Of Duty</label>
                    <input type="text" class="form-control" name="fisioPOD" id="fisioPOD">
                   </div>

                   <div class="mb-3">
                    <label class="form-label">Team Name</label>
                    <input type="text" class="form-control" name="teamName" id="teamName">
                   </div>

                   <button type="button" onclick="addCoach()" class="btn btn-sm bg-gradient-dark my-4 mb-2">Submit</button>
                  </form>

                  <div class="modal-footer">
                   <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                  </div>
                 </div>
                </div>
               </div>
              </div>

              <!-- Update Team Modal -->
              <div class="modal fade" id="updateTeamModal" tabindex="-1" aria-hidden="true">
               <div class="modal-dialog">
                <div class="modal-content">
                 <div class="modal-header">
                  <h5 class="modal-title">Update Team</h5>
                  <button type="button" id="closeModalUpdate" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                 </div>
                 <div class="modal-body">
                  <!-- Update Team Form -->
                  <form id="ajaxUpdateTeam">

                   <div class="mb-3">
                    <label class="form-label">Coach Name</label>
                    <input type="text" class="form-control" name="updateCoachName" id="updateCoachName">
                   </div>
                   <div class="mb-3">
                    <label class="form-label">Coach Identity Card</label>
                    <input type="text" class="form-control" name="updateCoachIC" id="updateCoachIC">
                   </div>

                   <div class="mb-3">
                    <!--<label class="form-label">Old Coach Identity Card</label>-->
                    <input hidden type="text" class="form-control" name="oldCoachIC" id="oldCoachIC">
                   </div>

                   <div class="mb-3">
                    <label class="form-label">Coach Place Of Duty</label>
                    <input type="text" class="form-control" name="updateCoachPOD" id="updateCoachPOD">
                   </div>
                   <div class="mb-3">
                    <label class="form-label">Fisio Name</label>
                    <input type="text" class="form-control" name="updateFisioName" id="updateFisioName">
                   </div>

                   <div class="mb-3">
                    <label class="form-label">Fisio Identity Card</label>
                    <input type="text" class="form-control" name="updateFisioIC" id="updateFisioIC">
                   </div>

                   <div class="mb-3">
                    <label class="form-label">Fisio Place Of Duty</label>
                    <input type="text" class="form-control" name="updateFisioPOD" id="updateFisioPOD">
                   </div>

                   <div class="mb-3">
                    <label class="form-label">Team Name</label>
                    <input type="text" class="form-control" name="updateTeamName" id="updateTeamName">
                   </div>
                   <button type="button" onclick="updateTeam()" class="btn btn-sm bg-gradient-dark my-4 mb-2">Submit</button>
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
                    function fetchTeamData() {
                     $.ajax({
                      type: 'GET',
                      url: '../ListTeamServlet',
                      dataType: 'json',
                      success: function (data) {
                       // Clear existing table content
                       $('#teamTableBody').empty();

                       var rowIndex = 1;
                       // Iterate over received data and generate HTML for each clerk
                       $.each(data, function (index, team) {
                        // Create table row for Team data
                        var row = $('<tr>');
                        // Create table cells for Team ID, username, and password
                        //var teamIDCell = $('<td>').text(team.coachIC);
                        var rowNumberCell = $('<td>').text(rowIndex).addClass('align-middle text-center text-sm');
//                        var teamCoachNameCell = $('<td>').text(team.coachName);
//                        var teamICCell = $('<td>').text(team.coachIC);
//                        var teamPODCell = $('<td>').text(team.coachPOD);
//                        var teamFisioNameCell = $('<td>').text(team.fisioName);
//                        var teamFisioICCell = $('<td>').text(team.fisioIC);
//                        var teamFisioPODCell = $('<td>').text(team.fisioPOD);
                        var teamNameCell = $('<td>').text(team.teamName);

                        var coachNameICPOD = $('<td>').html(
                                '<p class="font-weight-bold mb-0">' + team.coachName + '</p>' +
                                '<p class="text-secondary mb-0">' + team.coachIC + '</p>' +
                                '<p class="text-secondary mb-0">' + team.coachPOD + '</p>'
                                );
                        
                        var fisioNameICPOD = $('<td>').html(
                                '<p class="font-weight-bold mb-0">' + team.fisioName + '</p>' +
                                '<p class="text-secondary mb-0">' + team.fisioIC + '</p>' +
                                '<p class="text-secondary mb-0">' + team.fisioPOD + '</p>'
                                );



                        // Create edit and delete buttons
                        var editButton = $('<button>').addClass('btn bg-gradient-dark')
                                .html('<i class="bi bi-file-earmark-check-fill bi-lg"></i>')
                                .attr('data-bs-toggle', 'modal')
                                .attr('data-bs-target', '#updateTeamModal')
                                .css('margin-right', '5px');

                        var deleteButton = $('<button>').addClass('btn bg-gradient-dark')
                                .html('<i class="bi bi-trash2-fill"></i>')
                                .attr('data-bs-toggle', 'modal')
                                .attr('data-bs-target', '#confirmationModal');

                        // Add click event handlers to buttons
                        editButton.click(function () {
                         console.log("Updating Team ID:", team.coachIC);
                         displayTeam(team.coachIC); //Pass Parameter
                        });

                        deleteButton.click(function () {
                         deleteTeam(team.coachIC); // Implement DeleteTeam function
                        });

                        // Append buttons to a cell
                        var actionCell = $('<td>').addClass('align-middle text-center text-sm').append(editButton, deleteButton);

                        // Append cells to the row
                        row.append(rowNumberCell, coachNameICPOD, fisioNameICPOD, teamNameCell, actionCell);

                        // Append row to the table body
                        $('#teamTableBody').append(row);

                        rowIndex++;
                       });
                      },
                      error: function (xhr, status, error) {
                       console.error("Error occurred during AJAX request:", error);
                      }
                     });
                    }
                    $(document).ready(function () {
                     fetchTeamData();
                    });
  </script>


  <script>
   var msg = null;
   function addCoach() {
    var coachName = $("#coachName").val().trim();
    var coachIC = $("#coachIC").val().trim();
    var coachPOD = $("#coachPOD").val().trim();
    var fisioName = $("#fisioName").val().trim();
    var fisioIC = $("#fisioIC").val().trim();
    var teamName = $("#teamName").val().trim();

    // Check if any field is empty
    if (!coachName || !coachIC || !coachPOD || !fisioName || !fisioIC || !teamName) {
     alert("Please fill in all fields.");
     return;
    }

    var data = $("#ajaxAddCoach").serialize();

    $.ajax({
     type: 'POST',
     url: '../AddTeamServlet',
     data: data,
     dataType: 'JSON',

     success: function (data) {
      msg = data[0].msg

      if (msg == 1) {
       alert('Submit Inserted');
       $('#ajaxAddCoach')[0].reset();
       $("#closeModal").trigger('click');
       fetchTeamData();

      } else {
       alert('Data Not Inserted');
      }
     }
    })
   }
  </script>

  <script>
   // Function to handle deletion after confirmation
   function deleteTeam(coachIC) {
    console.log("Deleting Team ID:", coachIC);
    // Show confirmation modal
    $('#confirmationModal').modal('show');
    $('#confirmDeleteBtn').click(function () {
     $.ajax({
      type: 'POST',
      url: '../DeleteTeamServlet',
      data: {coachIC: coachIC},
      success: function (response) {
       console.log("Team deleted successfully");
       fetchTeamData();
      },
      error: function (xhr, status, error) {
       // Handle error
       console.error("Error deleting Team", error);
      }
     });

     $('#confirmationModal').modal('hide');
    });
   }
  </script>

  <script>
   function updateTeam() {
    var formData = $("#ajaxUpdateTeam").serialize();

    $.ajax({
     type: 'POST',
     url: '../UpdateTeamServlet',
     data: formData,
     dataType: 'JSON',
     success: function (response) {
      if (response.success) {
       alert('Team information updated successfully');
       $("#closeModalUpdate").trigger('click');
       fetchTeamData();
      } else {
       alert('Failed to update Team information. Please try again.');
      }
     },
     error: function (xhr, status, error) {
      console.error("Error updating Team information:", error);
      alert('An error occurred while updating Team information. Please try again later.');
     }
    });
   }
  </script>

  <script>
   function displayTeam(coachIC) {

    $.ajax({
     type: 'GET',
     url: '../DisplayTeamServlet',
     data: {coachIC: coachIC},
     dataType: 'JSON',
     success: function (coach) {
      $('#updateCoachName').val(coach.coachName);
      $('#updateCoachIC').val(coach.coachIC);
      $('#updateCoachPOD').val(coach.coachPOD);
      $('#updateFisioName').val(coach.fisioName);
      $('#updateFisioIC').val(coach.fisioIC);
      $('#updateFisioPOD').val(coach.fisioPOD);
      $('#updateTeamName').val(coach.teamName);


      $('#oldCoachIC').val(coach.coachIC);

      $('#updateTeamModal').modal('show');
     },
     error: function (xhr, status, error) {
      console.error("Error retrieving clerk information:", error);
     }
    });
   }
  </script>

 </body>
</html>



