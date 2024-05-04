<%@page import="java.util.List"%>
<%@page import="com.jisu.emp_management.model.Employee"%>
<%@page import="com.jisu.emp_management.model.Task"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- Required meta tags -->
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" />
  <!-- Bootstrap Font Icon CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" />

  <title>All Tasks</title>

  <style>
    /* Your existing CSS styles */
    
       body {
      background-color: whitesmoke;
      background-size: cover;
      background-repeat: no-repeat;
      height: 100vh;
      padding-top: 70px; /* Adjust top padding to accommodate sticky navbar */
    }

    .navbar {
      background-color: #4976d1;
      color: white;
    }

    .card {
      margin-bottom: 20px;
      border-radius: 15px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      transition: box-shadow 0.3s ease-in-out; /* Adding transition effect */
    }

    .card:hover {
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.3); /* Glow effect on hover */
    }

    .delete-button {
      position: absolute;
      bottom: 10px;
      right: 10px;
    }

    /* Additional styles for spacing between navbar and first card */
    .mt-navbar {
      margin-top: 20px;
    }
  </style>
</head>
<body>
  <nav class="navbar navbar-light fixed-top">
    <div class="container">
      <h2 class="navbar-brand">
        All Tasks <i class="bi-calendar2-plus-fill" style="margin-top: 5rem"></i>
      </h2>
      <a href="addnewtask" class="btn btn-light" style="margin-right: 120px;"> Add New Task <i class="bi-plus-lg"></i></a>
    </div>
  </nav>
  
  <%
  // Assuming tasks is the list of tasks retrieved from the request attribute
  List<Task> tasks = (List<Task>) request.getAttribute("tasks");
  %>

  <div class="container mt-navbar">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <% for (int i = 0; i < tasks.size(); i++) {
            Task t = tasks.get(i);
        %>
        <!-- Card for each task -->
        <div class="card">
            <div class="card-header"><%= t.getDate() %></div>
            <div class="card-body">
                <h5 class="card-title"><%= t.getSub()+"("+t.getEmployees().size()+")" %></h5>
                <p class="card-text"><%= t.getDesc() %></p>

                <!-- Button to trigger modal for each task -->
                <button
                    type="button"
                    class="btn btn-primary mt-3"
                    data-bs-toggle="modal"
                    data-bs-target="#exampleModal<%= i + 1 %>"
                >
                    <i class="bi bi-people-fill"></i> Show Assigned Employees
                </button>
                <a href="deltask/<%=t.getId() %>" class="btn btn-danger delete-button">
                <i class="bi-trash"></i> Delete
              </a>
            </div>

            <!-- Modal for each task -->
            <div
                class="modal fade"
                id="exampleModal<%= i + 1 %>"
                tabindex="-1"
                aria-labelledby="exampleModalLabel<%= i + 1 %>"
                aria-hidden="true"
            >
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                        <div class="container text-center">
                            <h5 class="modal-title" id="exampleModalLabel<%= i + 1 %>" style="color: green">
                                All Employees for Task <%= t.getId() %>
                            </h5>
                        </div>
                            <button
                                type="button"
                                class="btn-close"
                                data-bs-dismiss="modal"
                                aria-label="Close"
                            ></button>
                        </div>
                        <div class="modal-body">
                            <!-- Table inside the modal for each task -->
                            <table class="table table-bordered">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <!-- Add more table headers as needed -->
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for(Employee e: t.getEmployees()) { %>
                                    <tr class="table-info">
                                        <td><%= e.getName() %></td>
                                        <td><%= e.getEmail() %></td>
                                        <!-- Add more table rows as needed -->
                                    </tr>
                                    <% } %>
                                    <!-- You can add more rows here -->
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button
                                type="button"
                                class="btn btn-secondary"
                                data-bs-dismiss="modal"
                            >
                                Close
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Card for each task -->
        <% } %>
      </div>
    </div>
  </div>

  <!-- Bootstrap JS, Popper.js, and jQuery -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</body>
</html>
