<!doctype html>
<%@page import="com.jisu.emp_management.model.Employee"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
          crossorigin="anonymous">

    <style>
        /* Custom CSS for glow effect */
        .glow-container {
            display: inline-block;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5); /* Adjust the values for the glow effect */
            border-radius: 10px;
            width: 80%; /* Adjust the width as needed */
            padding: 20px;
        }
    </style>

    <title>add Task</title>
</head>
<body>
<div class="container text-center">
    <h2>Allocate Task</h2>
</div>

<%
    List<Employee> list = (List<Employee>) request.getAttribute("emps");
%>

<div class="container text-center">
    <div class="glow-container">
        
  <form action="addtaskprocess" method="post">
                <div class="form-group">
                    <label for="exampleFormControlInput1">Subject</label>
                    <input type="text" class="form-control" id="exampleFormControlInput1"
                           placeholder="Enter Job Title" name="sub">
                </div>

                <div class="form-group">
                    <label for="exampleFormControlSelect2">Select Employees</label>
                    <select multiple class="form-control" id="exampleFormControlSelect2" name="emps">
                        <%
                            for (Employee e : list) {
                        %>
                        <option value="<%=e.getEmpId()%>"><%=e.getName() %></option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="exampleFormControlTextarea1">Task Description</label>
                    <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="desc"></textarea>
                </div>

                <button type="submit" class="btn btn-success">Add Task</button>
            </form>
    </div>
</div>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
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
