<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.connection.DBConnect" %>
<%@ page import="com.registration.bean.Team" %>
<%@ page import="com.registration.bean.Apparatus" %>

<%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    List<Team> teams = new ArrayList<>(); // Assuming you have a Team class
    List<Apparatus> apparatusList = new ArrayList<>(); // Assuming you have an Apparatus class

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
        
        // Fetching data from APPARATUS table
        rs = stmt.executeQuery("SELECT * FROM APPARATUS");
        while (rs.next()) {
            Apparatus apparatus = new Apparatus();
            apparatus.setApparatusID(rs.getInt("apparatusID"));
            apparatus.setApparatusName(rs.getString("apparatusName"));
            apparatusList.add(apparatus);
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

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/bbbootstrap/libraries@main/choices.min.css">
  <script src="https://cdn.jsdelivr.net/gh/bbbootstrap/libraries@main/choices.min.js"></script>

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

   .choices__list--multiple .choices__item {
    display: inline-block;
    vertical-align: middle;
    border-radius: 20px;
    padding: 4px 10px;
    font-size: 12px;
    font-weight: 500;
    margin-right: 3.75px;
    margin-bottom: 3.75px;
    background-color: #344767;
    border: 1px solid #00a5bb;
    color: #fff;
    word-break: break-all;
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
                <th scope="col"> Name</th>
                <th scope="col"> Identity Card</th>
                <th scope="col"> School</th>
                <th scope="col"> Category</th>
                <th scope="col"> Apparatus</th>
                <th scope="col"> Gymnast Team</th>
                <th scope="col"> Action</th>
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
                    <label for="icPic" class="form-label">Please Select Your I/C Picture</label>
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
                     <option value="U12">U12</option>
                     <option value="U9">U9</option>
                    </select>
                   </div>

                   <div class="mb-3">
                    <label class="form-label">Gymnast Apparatus</label>
                    <select name="select2" id="select2" class="form-control" style="color: black" multiple>
                     <% for (Apparatus apparatus : apparatusList) { %>
                     <option value="<%= apparatus.getApparatusID() %>"><%= apparatus.getApparatusName() %></option>
                     <% } %>
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

                     <option value="U12">U12</option>
                     <option value="U9">U9</option>
                    </select>
                   </div>

                   <div id="apparatusValuesContainer"></div>


                   <div class="mb-3">
                    <label class="form-label">Gymnast Apparatus</label>
                    <select name="select3" id="select3" class="form-control" style="color: black" multiple>
                     <% for (Apparatus apparatus : apparatusList) { %>
                     <option value="<%= apparatus.getApparatusID() %>"><%= apparatus.getApparatusName() %></option>
                     <% } %>
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
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js'></script>
<script src="https://cdn.lordicon.com/qjzruarw.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


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
                       // Check if data is empty
                       if (data.length === 0) {
                        // If data is empty, display image and message
                        $('#gymnastTableBody').html('<tr><td colspan="8" class="text-center"><div style="margin: 0 auto;"><img src="sleepingcat.gif" alt="Cat Image" class="centered-image" style="max-width: 400px; max-height: 150px; width: 150px; height: auto;"><p style="font-family: Comic Sans MS, cursive; text-transform: uppercase;">CURRENTLY NO DATA</p></div></td></tr>');
                       } else {
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
                         var gymnastApparatusCell = $('<td>').text(gymnast.apparatusList);
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
                         row.append(rowNumberCell, gymnastNameCell, gymnastICCell, gymnastSchoolCell, gymnastCategoryCell, gymnastApparatusCell, gymnastTeamCell, actionCell);

                         // Append row to the table body
                         $('#gymnastTableBody').append(row);

                         rowIndex++;
                        });
                       }
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
 $(document).ready(function () {
  var selectElement = document.getElementById('select2');
  var multipleCancelButton = new Choices('#select2', {
   removeItemButton: true,
   maxItemCount: 5,
   searchResultLimit: 5,
   renderChoiceLimit: 5,
   itemSelectText: 'Can Select More Than One',
  });

 });
</script>
<script>
 $(document).ready(function () {
  var selectElement = document.getElementById('select3');
  var multipleCancelButton = new Choices('#select3', {
   removeItemButton: true,
   maxItemCount: 5,
   searchResultLimit: 5,
   renderChoiceLimit: 5,
   itemSelectText: 'Can Select More Than One',
  });

 });
</script>

<script>
 var selectedValues; // Define selectedValues outside the event handler

 // Listen for change event on select element
 $('#select2').change(function () {
  selectedValues = $(this).val(); // Update selectedValues
  console.log("Selected Values:", selectedValues);
 });
</script>

<script>
 var selectedValues; // Define selectedValues outside the event handler

 // Listen for change event on select element
 $('#select3').change(function () {
  selectedValues = $(this).val(); // Update selectedValues
  console.log("Selected Values:", selectedValues);
 });
</script>

<script>
 function addGymnast() {
  var gymnastName = $("#gymnastName").val().trim();
  var gymnastIC = $("#gymnastIC").val().trim();
  var gymnastPic = $("#gymnastPic").val().trim();
  var gymnastSchool = $("#gymnastSchool").val().trim();
  var gymnastCategory = $("#gymnastCategory").val().trim();
  var gymnastTeam = $("#gymnastTeam").val().trim();

  // Retrieve selected values from #select2
  var selectedValues = $('#select2').val();

  // Check if selectedValues is not empty or undefined
//  if (selectedValues && selectedValues.length > 0) {
//
//  }

  // Check if any of the fields are empty
  if (!gymnastName || !gymnastIC || !gymnastPic || !gymnastSchool || !gymnastCategory || !gymnastTeam || !(selectedValues && selectedValues.length > 0)) {
   const Toast = Swal.mixin({
    toast: true,
    position: "top-end",
    showConfirmButton: false,
    timer: 3000,
    timerProgressBar: true,
    customClass: 'swal-wide'
   });

   let message = '<small style="color:red">';
   if (!gymnastName)
    message += '<li>Gymnast Name</li>';
   if (!gymnastIC)
    message += '<li>Gymnast Identity Card</li>';
   if (!gymnastPic)
    message += '<li>Gymnast IC Picture</li>';
   if (!gymnastSchool)
    message += '<li>Gymnast School</li>';
   if (!gymnastCategory)
    message += '<li>Gymnast Category</li>';
   if (!(selectedValues && selectedValues.length > 0))
    message += '<li>Apparatus</li>';
   if (!gymnastTeam)
    message += '<li>Team Name</li></small>';

   Toast.fire({
    icon: 'warning',
    title: '<b>Please Fill All Required Fields</b>',
    html: message
   });
   return;
  }



  var formData = new FormData($('#ajaxAddGymnast')[0]);
  formData.append('#select2', selectedValues.join(','));

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
      const Toast = Swal.mixin({
       toast: true,
       position: "top-end",
       showConfirmButton: false,
       timer: 3000,
       timerProgressBar: false,
       iconColor: 'green',
       customClass: 'swal-wide',
      });
      Toast.fire({
       icon: 'success',
       title: '<b>Gymnast <span style="color: green;"> Added</span> Successfully!</b>'
      });
      $('#ajaxAddGymnast')[0].reset();
      $("#closeModal").trigger('click');
      fetchGymnastData();  // Assuming this function is defined elsewhere
     } else if (msg == 3) {
      const Toast = Swal.mixin({
       toast: true,
       position: "top-end",
       showConfirmButton: false,
       timer: 3000,
       heightAuto: true,
       timerProgressBar: false,
       customClass: 'swal-wide',
      });
      Toast.fire({
       icon: 'warning',
       title: '<b>Only <span style="color: red;"> Image Type</span> Allowed!</b>'
      });

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
     const Toast = Swal.mixin({
      toast: true,
      position: "top-end",
      showConfirmButton: false,
      timer: 3000,
      timerProgressBar: false,
      iconColor: 'green',
      customClass: 'swal-wide',
     });
     Toast.fire({
      icon: 'success',
      title: '<b>Gymnast <span style="color: red;"> Deleted</span> Successfully!</b>'
     });
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
  // Retrieve selected values from #select3
  var selectedValues = $('#select3').val();
  // Create a FormData object
  var formData = new FormData($('#ajaxUpdateGymnast')[0]);

  // Append selectedValues to formData
  formData.append('select3', selectedValues.join(','));

  // Perform AJAX request with the FormData
  $.ajax({
   type: 'POST',
   url: '../UpdateGymnastServlet',
   data: formData,
   processData: false,
   contentType: false,
   success: function (response) {
    console.log(response); // Log the response for debugging
    if (response.success) {
     const Toast = Swal.mixin({
      toast: true,
      position: "top-end",
      showConfirmButton: false,
      timer: 3000,
      timerProgressBar: false,
      iconColor: 'green',
      customClass: 'swal-wide'
     });
     Toast.fire({
      icon: 'success',
      title: '<small><b>Gymnast<span style="color: green;"> Updated</span> Successfully!</b></small>'
     });
     $("#closeModalUpdate").trigger('click');
     fetchGymnastData();
    } else {
     if (response.msg === 2) {
      const Toast = Swal.mixin({
       toast: true,
       position: "top-end",
       showConfirmButton: false,
       timer: 3000,
       heightAuto: true,
       timerProgressBar: false,
       customClass: 'swal-wide'
      });
      Toast.fire({
       icon: 'warning',
       title: '<b>Only <span style="color: red;"> Image Type</span> Allowed!</b>'
      });
     } else {
      alert('Failed to update Gymnast information. Please try again.');
     }
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

    // Split the comma-separated apparatus list into an array
    var apparatusArray = gymnast.apparatusList;
    console.log("Apparatus List: " + apparatusArray);

    var selectedValues = $('#select3').val();
    $('#apparatusValuesContainer').html(apparatusArray);

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





