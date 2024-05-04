<!DOCTYPE html>
<%@page import="com.jisu.emp_management.model.Employee"%>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
  </head>
  <body style="background-color: #013747">
	<%
	Employee emp=(Employee)session.getAttribute("emp");
	%>
    <form action="msgsubmit" method="post">
    <div class="container text-center" style="margin-left:30rem;">
      <div class="form-container">
        <div class="form">
          <span class="heading">Send Massage</span>
          <input placeholder="Name" type="text" class="input" value="<%=emp.getName() %>" disabled/>
          <!-- <input placeholder="Email" id="mail" type="email" class="input" /> -->
          <input placeholder="Subject" id="Subject" type="Subject" class="input" name="sub"/>
          <textarea name="text" 
            placeholder="Say Hello"
            rows="10"
            cols="30"
            id="message"
            name="message"
            class="textarea"
          ></textarea>
          <div class="button-container d-flex justify-content-center">
            <button type="submit" class="send-button mr-2">Submit</button>
            <button type="reset" class="reset-button">Reset</button>
          </div>
        </div>
      </div>
      
</div>

    </form>
    <style>
      .orange {
        color: #ff7a01;
      }

      .form-container {
        max-width: 550px;
        margin: 55px;
        background-color: #001925;
        padding: 20px;
        border-left: 5px solid #ff7a01;
        clip-path: polygon(
          0 0,
          100% 0,
          100% calc(100% - 20px),
          calc(100% - 20px) 100%,
          0 100%
        );
      }

      .heading {
        display: block;
        color: white;
        font-size: 1.5rem;
        font-weight: 800;
        margin-bottom: 20px;
      }

      .form-container .form .input {
        color: #87a4b6;
        width: 100%;
        background-color: #002733;
        border: none;
        outline: none;
        padding: 10px;
        margin-bottom: 20px;
        font-weight: bold;
        transition: all 0.2s ease-in-out;
        border-left: 1px solid transparent;
      }

      .form-container .form .input:focus {
        border-left: 5px solid #ff7a01;
      }

      .form-container .form .textarea {
        width: 100%;
        padding: 10px;
        border: none;
        outline: none;
        background-color: #013747;
        color: #ff7a01;
        font-weight: bold;
        resize: none;
        max-height: 150px;
        margin-bottom: 20px;
        border-left: 1px solid transparent;
        transition: all 0.2s ease-in-out;
      }

      .form-container .form .textarea:focus {
        border-left: 5px solid #ff7a01;
      }

      .form-container .form .button-container {
        display: flex;
        gap: 10px;
      }

      .form-container .form .button-container .send-button {
        flex-basis: 70%;
        background: #ff7a01;
        padding: 10px;
        color: #001925;
        text-align: center;
        font-weight: bold;
        border: 1px solid transparent;
        transition: all 0.2s ease-in-out;
      }

      .form-container .form .button-container .send-button:hover  {
        background: transparent;
        border: 1px solid #ff7a01;
        color: #ff7a01;
      }

      .form-container .form .button-container .reset-button-container {
        filter: drop-shadow(1px 1px 0px #ff7a01);
        flex-basis: 30%;
      }
      .form-container
      .form
      .button-container
      .reset-button-container
      .reset-button {
      position: relative;
      text-align: center;
      padding: 10px;
      color: #ff7a01;
      font-weight: bold;
      background: #001925;
      clip-path: polygon(
        0 0,
        100% 0,
        100% calc(100% - 10px),
        calc(100% - 10px) 100%,
        0 100%
      );
      transition: all 0.2s ease-in-out;
      }
      
      

      .form-container
        .form
        .button-container
        .reset-button-container
        .reset-button:hover {
        background: #ff7a01;
        color: #001925;
      }
      .send-button {
        background-color: #ff7a01;
        color: #001925;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        font-weight: bold;
      }
      
      .reset-button {
        background-color: transparent;
        color: #ff7a01;
        border: 1px solid #ff7a01;
        padding: 10px 20px;
        border-radius: 5px;
        font-weight: bold;
      }
      
      .reset-button:hover {
        background-color: #ff7a01;
        color: #001925;
      }
      
      .button-container {
        margin-top: 20px;
      }
      
      .flex-grow-1 {
        flex-grow: 1;
      }
      
      
    </style>
  </body>
</html>