<!DOCTYPE html>
<%@page import="com.jisu.emp_management.model.Employee"%>
<%@page import="com.jisu.emp_management.model.Message"%>
<%@page import="java.util.List"%>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />

    <!-- Bootstrap CSS -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
    />
    <!-- Bootstrap Font Icon CSS -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
    />

    <title>Sent Messages</title>

    <style>
      body {
        background-color: rgb(176, 236, 176);
        background-size: cover;
        background-repeat: no-repeat;
        height: 100vh;
      }

      .navbar {
        background-color: #10a87d;
        color: white;
      }

      .card {
        margin-bottom: 20px;
        border-radius: 15px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }

      .delete-button {
        position: absolute;
        bottom: 10px;
        right: 10px;
      }

      body {
    padding-top: 35px; /* Adjust this value as needed */
    /* Other existing styles */
  }
    </style>
  </head>
  <body>
    <nav class="navbar navbar-light fixed-top">
      <div class="container">
        <h2 class="navbar-brand">
          All Messages <i class="bi-envelope-fill" style="margin-top: 5rem"></i>
        </h2>
        <a href="sendmsg" class="btn btn-light" style="margin-right: 120px;"> Add New Message <i class="bi-plus-lg"></i></a>
      </div>
    </nav>
    
    <%
    
    List<Message> allmsg= (List<Message>)request.getAttribute("msgs");
    
    Employee emp=(Employee)session.getAttribute("emp");
    
    %>

    <div class="container mt-5">
      <div class="row justify-content-center">
        <div class="col-md-8">


		<%
		
		for(Message msg: allmsg)
		{
		String username="";
		String deleteUrl="";
		
		if(msg.getEmp().getEmpId().equals(emp.getEmpId())){
			username="You";
			deleteUrl="http://localhost:8000/admindelmsg/"+msg.getMsgId();
		}
		else{
			deleteUrl="#";
			username=msg.getEmp().getName();
		}
		%>

		  <div class="card">
            <div class="card-header"><%=msg.getDate()+" "+"("+username+")" %></div>
            <div class="card-body">
              <h5 class="card-title"><%=msg.getSubject() %></h5>
              <p class="card-text">
               <%=msg.getBody()%>
              </p>
              <a href="<%=deleteUrl %>" class="btn btn-danger delete-button"
                ><i class="bi-trash"></i> Delete</a
              >
            </div>
          </div>
		
		
		<%
		
		}
		
		%>

        

          <!-- Form with Add Button -->
        </div>
      </div>
    </div>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  </body>
</html>
