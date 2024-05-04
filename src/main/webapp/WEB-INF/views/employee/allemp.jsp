<!doctype html>
<%@page import="com.jisu.emp_management.model.Employee"%>
<%@page import="java.util.List"%>
<html lang="en">

<head>
  
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
        integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
        crossorigin="anonymous">

    <style>
        body {
            background-color: #3a506b; 
            color: #a2a8d3;
        }

        .navbar {
            background-color: #113f67; 
            color: #ffffff; 
        }

        .navbar-brand,
        .navbar-nav .nav-link {
            color: white; 
        }

        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease-in-out;
            margin-bottom: 20px;
            background-color: rgba(255, 255, 255, 0.9);
        }

        .card:hover {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .card-img-top {
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            height: 200px;
            object-fit: cover;
        }

        .card-text {
            color: #171515;
        }

        footer {
            background-color: #38598b;
            color: #fff;
            padding: 20px 0;
            position: absolute;
            bottom: 0;
            width: 100%;
            text-align: center;
        }
    </style>

    <title>My Department</title>
</head>

<body>

    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container">
            <a class="navbar-brand" href="#">ALL EMPLOYEES</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

           
        </div>
    </nav>

<%

List<Employee> res= (List<Employee>) request.getAttribute("res");
Employee emp=(Employee)session.getAttribute("emp");
%>



    <div class="container mt-4">
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                 
                 <%
                 
                 for(Employee e: res)
                 {
                 
                	 String imageUrl="http://localhost:8000/images/"+e.getImage().getId();
                	 String username="";
                	 if(e.getEmpId().equals(emp.getEmpId())){
                		 username=e.getName()+"(You)";
                    	 

                	 }
                	 else{
                		 username=e.getName();
                	 }
                 %>
                 
                 
                 
                    <div class="col-md-3 mb-4">
                        <div class="card">
                            <img class="card-img-top"
                                src="<%=imageUrl %>"
                                alt="Card image cap">
                            <div class="card-body">
                                <h5 class="card-title"><%=username %></h5>
                                <p class="card-text"> <%=e.getEmail() %> </p>
                            </div>
                        </div>
                    </div>
                  
                  <%
                 }
                  %>


                  
                
                </div>
            </div>
        </div>
    </div>

   
 

  
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
        integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>
</body>

</html>