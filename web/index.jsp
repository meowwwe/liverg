

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

  <title>Login</title>
  <style>

   @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');

   *{
    font-family: 'Poppins', sans-serif;
   }
   .wrapper{
    background: #ececec;
    padding: 0 20px 0 20px;
   }
   .main{
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
   }
   .side-image{
    background-image: url("registration/assets/img/curved-images/sport10.jpg");
    background-position: center;
    background-size: cover;
    background-repeat: no-repeat;
    border-radius: 10px 0 0 10px;
    position: relative;
   }
   .row{
    width:4000px;
    height:700px;
    border-radius: 10px;
    background: #fff;
    padding: 0px;
    box-shadow: 5px 5px 10px 1px rgba(0,0,0,0.2);
   }
   .text{
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
   }
   .text p{
    color: #fff;
    font-size: 20px;
   }
   i{
    font-weight: 400;
    font-size: 15px;
   }
   .right{
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
   }
   .input-box{
    width: 330px;
    box-sizing: border-box;
   }
   img{
    width: 35px;
    position: absolute;
    top: 30px;
    left: 30px;
   }
   .input-box header{
    font-weight: 700;
    text-align: center;
    margin-bottom: 45px;
   }
   .input-field{
    display: flex;
    flex-direction: column;
    position: relative;
    padding: 0 10px 0 10px;
   }
   .input{
    height: 45px;
    width: 100%;
    background: transparent;
    border: none;
    border-bottom: 1px solid rgba(0, 0, 0, 0.2);
    outline: none;
    margin-bottom: 20px;
    color: #40414a;
   }
   .input-box .input-field label{
    position: absolute;
    top: 10px;
    left: 10px;
    pointer-events: none;
    transition: .5s;
   }
   .input-field input:focus ~ label
   {
    top: -10px;
    font-size: 13px;
   }
   .input-field input:valid ~ label
   {
    top: -10px;
    font-size: 13px;
    color: #5d5076;
   }
   .input-field .input:focus, .input-field .input:valid{
    border-bottom: 1px solid #743ae1;
   }
   .submit{
    border: none;
    outline: none;
    height: 45px;
    background: #ececec;
    border-radius: 5px;
    transition: .4s;
   }
   .submit:hover{
    background: rgba(37, 95, 156, 0.937);
    color: #fff;
   }
   .signin{
    text-align: center;
    font-size: small;
    margin-top: 25px;
   }
   span a{
    text-decoration: none;
    font-weight: 700;
    color: #000;
    transition: .5s;
   }
   span a:hover{
    text-decoration: underline;
    color: #000;
   }

   @media only screen and (max-width: 768px){
    .side-image{
     border-radius: 10px 10px 0 0;
    }
    img{
     width: 35px;
     position: absolute;
     top: 20px;
     left: 47%;
    }
    .text{
     position: absolute;
     top: 70%;
     text-align: center;
    }
    .text p, i{
     font-size: 16px;
    }
    .row{
     max-width:420px;
     width: 100%;
    }
   }

   input::-webkit-outer-spin-button,
   input::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
   }

   /* input[type=number] {
     -moz-appearance: textfield;
   } */

   .swal-wide {
    display: flex !important;
    width: 100%;
   }

   input::-webkit-outer-spin-button,
   input::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
   }

   /* input[type=number] {
     -moz-appearance: textfield;
   } */

   .swal-wide {
    display: flex !important;
    width: 100%;
   }
  </style>

 </style>
</head>
<body>
 <div class="wrapper">
  <div class="container main">
   <div class="row">
    <div class="col-md-6 side-image"> 
     <div class="text">
      <h1 class="text-white mb-2 mt-5">Rythmic Gymnastic Scoring System</h1>
      <p class="text-lead text-white style=font-size: 20px;">THE PLATFORM WHERE YOU CAN SHOW THE WORLD YOUR TALENTS</p>
     </div>

    </div>

    <div class="col-md-6 right">
     <div class="input-box border rounded p-5">
      <header style="font-size: 24px;"> LOGIN </header>
      <form name="ajaxLogin" id="ajaxLogin">
       <div class="input-field">
        <input type="text" class="input form-control" name="username" required autocomplete="off">
        <label for="username">Username</label>
       </div>
       <div class="input-field">
        <input type="password" class="input form-control" name="password" required>
        <label for="password">Password</label>
       </div>
       <div class="input-field">
        <input type="button" onclick="login()" class="submit btn btn-primary" value="Sign In">
       </div>
      </form>
     </div>
    </div>
   </div>
  </div>


  <!-- Bootstrap Modal for Error Message -->
  <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
     <div class="modal-header">
      <h5 class="modal-title" id="errorModalLabel">Error</h5>
      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
     </div>
     <div class="modal-body">
      <p id="errorMessage"></p>
     </div>
     <div class="modal-footer">
      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
     </div>
    </div>
   </div>
  </div>
</body>
</html>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js'></script>
<script src="https://cdn.lordicon.com/qjzruarw.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script>
         var msg = null;

         function login() {
          var data = $("#ajaxLogin").serialize();

          $.ajax({
           type: 'POST',
           url: 'LoginServlet',
           data: data,
           dataType: 'JSON',

           success: function (data) {
            msg = data[0].msg;

            if (msg == 1) {
             alert('STAFF');
             window.location.href = "registration/dashboard.jsp";
            } else if (msg == 2) {
             alert('CLERK');
            } else if (msg == 3) {
             alert('HEADJUDGE');
            } else {
             alert('Username/Password Incorrect');
            }
           }
          });
         }
</script>
