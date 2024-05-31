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
        rs = stmt.executeQuery("SELECT * FROM TEAM");

        // Fetch data from ResultSet and store it in the teams list
        while (rs.next()) {
            Team team = new Team();
            team.setTeamID(rs.getInt("teamID"));
            team.setTeamName(rs.getString("teamName"));
            teams.add(team);
        }
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
   Gymnast Personal Information
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
   /* Style for the image container */
   #imageContainer {
    max-width: 100%; /* Limit the width to fit the modal */
    max-height: 100%; /* Limit the height to 400 pixels */
    overflow: hidden;
   }

   /* Style for the image itself */
   #imageContainer img {
    max-width: 100%; /* Ensure the image doesn't exceed the container width */
    max-height: 100%; /* Ensure the image doesn't exceed the container height */
    display: block; /* Ensure the image is displayed as a block element */
    margin: auto; /* Center the image horizontally */
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
            <h6>Gymnast Personal Information</h6>
            <a href="#" class="btn btn-sm bg-gradient-dark my-4 mb-2" data-bs-toggle="modal" data-bs-target="#AddGymnastModal">Add</a>
           </div>
           <div class="card-body px-0 pt-0 pb-2">
            <div class="table-responsive p-0">
             <table class="table">
              <thead class="thead-light">
               <tr>
                <th scope="col">#</th>
                <th scope="col">Gymnast Name</th>
                <th scope="col">Gymnast Identity Card</th>
                <th scope="col">Gymnast School</th>
                <th scope="col">Gymnast Category</th>
                <th scope="col">Gymnast Team</th>
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
              <tbody id="gymnastTableBody">

               <!-- Modal Add Gymnast -->
              <div class="modal fade" id="AddGymnastModal" tabindex="-1" aria-hidden="true">
               <div class="modal-dialog">
                <div class="modal-content">
                 <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">Add Gymnast</h5>
                  <button type="button" id="closeModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                 </div>

                 <div class="modal-body">
                  <!-- Your form content goes here -->
                  <form id="ajaxAddGymnast" enctype="multipart/form-data">
                   <div class="mb-3">
                    <label class="form-label">Gymnast Name</label>
                    <input type="text" name="gymnastName" id="gymnastName" class="form-control">
                   </div>
                   <div class="mb-3">
                    <label class="form-label">Gymnast Identity Card</label>
                    <input type="text" name="gymnastIC" id="gymnastIC" class="form-control">
                   </div>
                   <div class="mb-3">
                    <label for="icPic" class="form-label">Please Select Your I/C Pitcure</label>
                    <input type="file" class="form-control" name="gymnastPic" id="gymnastPic">
                   </div>
                   <div class="mb-3">
                    <label class="form-label">Gymnast School</label>
                    <input type="text" name="gymnastSchool" id="gymnastSchool" class="form-control">
                   </div>
                   <div class="mb-3">
                    <label class="form-label">Gymnast Category</label>
                    <select name="gymnastCategory" id="gymnastCategory" class="form-control" style="color: black">
                     <option value="" hidden>Select a Category</option>
                     <option value="Pre-Junior">Pre-Junior</option>
                     <option value="Junior">Junior</option>
                     <option value="Senior">Senior</option>
                    </select>
                   </div>
                   <div class="mb-3">
                    <label class="form-label">Gymnast Team</label>
                    <select name="gymnastTeam" id="gymnastTeam" class="form-control" style="color: black">
                     <option value="" hidden>Select a Team</option>
                     <% for (Team team : teams) { %>
                     <option value="<%= team.getTeamID() %>"><%= team.getTeamName() %></option>
                     <% } %>
                    </select>
                   </div>

                   <button type="button" onclick="addGymnast()" class="btn btn-sm bg-gradient-dark my-4 mb-2">Submit</button>
                  </form>
                 </div>
                 <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                 </div>
                </div>
               </div>
              </div>


              <!-- Update Gymnast Modal -->
              <div class="modal fade" id="updateGymnastModal" tabindex="-1" aria-hidden="true">
               <div class="modal-dialog">
                <div class="modal-content">
                 <div class="modal-header">
                  <h5 class="modal-title">Update Gymnast Information</h5>
                  <button type="button" id="closeModalUpdate" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                 </div>
                 <div class="modal-body">
                  <!-- Update Gymnast Form -->
                  <form id="ajaxUpdateGymnast" enctype="multipart/form-data">
                   <div class="mb-3">
                    <label class="form-label">Gymnast Name</label>
                    <input type="text" name="updateGymnastName" id="updateGymnastName" class="form-control">
                   </div>
                   <div class="mb-3">
                    <label class="form-label">Gymnast Identity Card</label>
                    <input type="text" name="updateGymnastIC" id="updateGymnastIC" class="form-control">
                   </div>


                   <div class="mb-3">
                    <label for="icPic" class="form-label">Please Select Your I/C Picture</label>
                    <input type="file" class="form-control" name="updateGymnastPic" id="updateGymnastPic">
                   </div>

                   <div class="mb-3">
                    <label class="form-label">Gymnast School</label>
                    <input type="text" name="updateGymnastSchool" id="updateGymnastSchool" class="form-control">
                   </div>

                   <div class="mb-3">
                    <label class="form-label">Gymnast Category</label>
                    <select name="updateGymnastCategory" id="updateGymnastCategory" class="form-control">
                     <option value="Pre-Junior">Pre-Junior</option>
                     <option value="Junior">Junior</option>
                     <option value="Senior">Senior</option>
                    </select>
                   </div>

                   <div class="mb-3">
                    <label class="form-label">Gymnast Team</label>
                    <select name="updateGymnastTeam" id="updateGymnastTeam" class="form-control" style="color: black">
                     <option value="" hidden>Select a Team</option>
                     <% for (Team team : teams) { %>
                     <option value="<%= team.getTeamID() %>"><%= team.getTeamName() %></option>
                     <% } %>
                    </select>
                   </div>
                   <div class="mb-3">
                    <input type="text" hidden name="updateGymnastID" id="updateGymnastID" class="form-control">
                   </div>

                   <button type="button" onclick="updateGymnast()" class="btn btn-sm bg-gradient-dark my-4 mb-2">Submit</button>
                  </form>
                 </div>
                 <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                 </div>
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

              <!-- Modal Display Image Identity -->
              <div class="modal fade" id="imageModal" tabindex="-1" aria-hidden="true">
               <div class="modal-dialog modal-xl">
                <div class="modal-content">
                 <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">Identity Card Image</h5>
                 </div>
                 <div class="modal-body">
                  <div id="imageContainer">Image Here</div>
                  <div class="mb-3">
                   <!--<label class="form-label">Gymnast ID</label>-->
                   <input hidden type="text" name="imageGymnastID" id="imageGymnastID" class="form-control">
                  </div>
                  <div class="mb-3">
                   <!--<label class="form-label">Gymnast PIC Name</label>-->
                   <input hidden type="text" name="imageGymnastPIC" id="imageGymnastPIC" class="form-control">
                  </div>
                 </div>
                 <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
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

       <footer class="footer">
        <div class="d-sm-flex justify-content-center justify-content-sm-between">
         <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright � 2024<a href="" target="_blank"></a> Gymnastic Scoring System. All rights reserved.</span>
         <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="ti-heart text-danger ml-1"></i></span>
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
                    function fetchGymnastData() {
                     $.ajax({
                      type: 'GET',
                      url: '../ListGymnastServlet',
                      dataType: 'JSON',
                      success: function (data) {
                       // Clear existing table content
                       $('#gymnastTableBody').empty();

                       var rowIndex = 1;
                       // Iterate over received data and generate HTML for each Gymnast
                       $.each(data, function (index, gymnast) {
                        // Create table row for Gymnast data
                        var row = $('<tr>');
                        // Create table cells for Gymnast ID, username, and password
                        //var gymnastID = $('<td>').text(gymnast.gymnastID);
                        var rowNumberCell = $('<td>').text(rowIndex).addClass('align-middle text-center text-sm');
                        var gymnastNameCell = $('<td>').text(gymnast.gymnastName);
                        var gymnastICCell = $('<td>').text(gymnast.gymnastIC);
                        var gymnastSchoolCell = $('<td>').text(gymnast.gymnastSchool);
                        var gymnastCategoryCell = $('<td>').text(gymnast.gymnastCategory);
                        var gymnastTeamCell = $('<td>').text(gymnast.teamName);

                        // Create edit and delete buttons
                        var editButton = $('<button>').addClass('btn bg-gradient-dark')
                                .html('<i class="bi bi-file-earmark-check-fill bi-lg"></i>')
                                .attr('data-bs-toggle', 'modal')
                                .attr('data-bs-target', '#updateGymnastModal')
                                .css('margin-right', '5px');

                        var deleteButton = $('<button>').addClass('btn bg-gradient-dark')
                                .html('<i class="bi bi-trash2-fill"></i>')
                                .attr('data-bs-toggle', 'modal')
                                .attr('data-bs-target', '#confirmationModal');

                        // Create the button element
                        var viewImageButton = $('<button>').addClass('btn bg-gradient-dark')
                                .attr('data-bs-toggle', 'modal')
                                .attr('data-bs-target', '#imageModal')
                                .css('margin-left', '5px')
                                .text('View');



                        // Add click event handlers to buttons
                        editButton.click(function () {
                         console.log("Updating Gymnast ID:", gymnast.gymnastID);
                         displayGymnast(gymnast.gymnastID); //Pass Parameter
                        });

                        viewImageButton.click(function () {
                         console.log("View Image Gymnast ID:", gymnast.gymnastID);
                         viewImage(gymnast.gymnastID); //Pass Parameter
                        });

                        deleteButton.click(function () {
                         deleteGymnast(gymnast.gymnastID); // Implement deleteGymnast function
                        });

                        // Append the button to the cell
                        gymnastICCell.append(viewImageButton);

                        // Append buttons to a cell
                        var actionCell = $('<td>').addClass('align-middle text-center text-sm').append(editButton, deleteButton);

                        // Append cells to the row
                        row.append(rowNumberCell, gymnastNameCell, gymnastICCell, gymnastSchoolCell, gymnastCategoryCell, gymnastTeamCell, actionCell);

                        // Append row to the table body
                        $('#gymnastTableBody').append(row);

                        rowIndex++;
                       });
                      },
                      error: function (xhr, status, error) {
                       console.error("Error occurred during AJAX request:", error);
                      }
                     });
                    }
                    $(document).ready(function () {
                     fetchGymnastData();
                    });
       </script>

       <script>
        function addGymnast() {
         var formData = new FormData($('#ajaxAddGymnast')[0]);

         $.ajax({
          type: 'POST',
          url: '../AddGymnastServlet',
          data: formData,
          processData: false,
          contentType: false,
          success: function (data) {
           try {
            var response = JSON.parse(data);
            var msg = response[0].msg;

            if (msg == 1) {
             alert('Submit Inserted');
             $('#ajaxAddGymnast')[0].reset();
             $("#closeModal").trigger('click');
             fetchGymnastData();  // Assuming this function is defined elsewhere
            } else {
             alert('Data Not Inserted, error code: ' + msg);
            }
           } catch (e) {
            console.error('Error parsing JSON response:', e);
            alert('Error parsing JSON response.');
           }
          },
          error: function (xhr, status, error) {
           console.error('AJAX error:', status, error);
           alert('An error occurred while processing your request.');
          }
         });
        }
       </script>

       <script>
        // Function to handle deletion after confirmation
        function deleteGymnast(gymnastID) {
         console.log("Deleting Gymnast ID:", gymnastID);
         // Show confirmation modal
         $('#confirmationModal').modal('show');
         $('#confirmDeleteBtn').click(function () {
          $.ajax({
           type: 'POST',
           url: '../DeleteGymnastServlet',
           data: {gymnastID: gymnastID},
           success: function (response) {
            console.log("Gymnast deleted successfully");
            fetchGymnastData();
           },
           error: function (xhr, status, error) {
            // Handle error
            console.error("Error deleting Gymnast", error);
           }
          });

          $('#confirmationModal').modal('hide');
         });
        }
       </script>

       <script>
        function updateGymnast() {
         var formData = new FormData($('#ajaxUpdateGymnast')[0]);

         $.ajax({
          type: 'POST',
          url: '../UpdateGymnastServlet',
          data: formData,
          processData: false,
          contentType: false,
          success: function (response) {
           if (response.success) {
            $('#ajaxUpdateGymnast')[0].reset();
            alert('Gymnast information updated successfully');
            $("#closeModalUpdate").trigger('click');
            fetchGymnastData();
           } else {
            alert('Failed to update Gymnast information. Please try again.');
           }
          },
          error: function (xhr, status, error) {
           console.error("Error updating Gymnast information:", error);
           alert('An error occurred while updating Gymnast information. Please try again later.');
          }
         });
        }
       </script>

       <script>
        function displayGymnast(gymnastID) {
         $.ajax({
          type: 'GET',
          url: '../DisplayGymnastServlet',
          data: {gymnastID: gymnastID},
          dataType: 'JSON',
          success: function (gymnast) {
           $('#updateGymnastName').val(gymnast.gymnastName);
           $('#updateGymnastIC').val(gymnast.gymnastIC);
           $('#updateGymnastSchool').val(gymnast.gymnastSchool);
           $('#updateGymnastCategory').val(gymnast.gymnastCategory);
           $('#updateGymnastID').val(gymnast.gymnastID);
           $('#updateGymnastTeam').val(gymnast.teamID);

           //$('#updateGymnastModal').modal('show');
          },
          error: function (xhr, status, error) {
           console.error("Error retrieving gymnast information:", error);
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

       <script>
        function viewImage(gymnastID) {
         $.ajax({
          type: 'GET',
          url: '../DisplayGymnastServlet',
          data: {gymnastID: gymnastID},
          dataType: 'JSON',
          success: function (gymnast) {
           $('#imageGymnastID').val(gymnast.gymnastID);
           $('#imageGymnastPIC').val(gymnast.gymnastICPic);

           // Construct the full image URL using the imagePath attribute
           var imagePath = '/liverg/registration/uploads/' + gymnast.gymnastICPic;
           console.log("Image Path:", imagePath); // Add this line for debugging
           var img = $('<img>').attr('src', imagePath);
           $('#imageContainer').empty().append(img);

          },
          error: function (xhr, status, error) {
           console.error("Error retrieving gymnast information:", error);
          }
         });
        }
       </script>





