<%@ page import="java.util.List" %>
<%@ page import="com.jisu.emp_management.model.Employee" %>


<!DOCTYPE html>
<!-- Coding By CodingNepal - codingnepalweb.com -->
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!----======== CSS ======== -->
    <link rel="stylesheet" href="style.css">

    <!----===== Iconscout CSS ===== -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <title>Admin Dashboard Panel</title>
</head>
<body>

<style>

    /* ===== Google Font Import - Poppins ===== */
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600&display=swap');
    *{
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
    }

    :root{
        /* ===== Colors ===== */
        --primary-color: #0E4BF1;
        --panel-color: #FFF;
        --text-color: #000;
        --black-light-color: #707070;
        --border-color: #e6e5e5;
        --toggle-color: #DDD;
        --box1-color: #4DA3FF;
        --box2-color: #FFE6AC;
        --box3-color: #E7D1FC;
        --title-icon-color: #fff;

        /* ====== Transition ====== */
        --tran-05: all 0.5s ease;
        --tran-03: all 0.3s ease;
        --tran-03: all 0.2s ease;
    }

    body{
        min-height: 100vh;
        background-color: var(--primary-color);
    }
    body.dark{
        --primary-color: #3A3B3C;
        --panel-color: #242526;
        --text-color: #CCC;
        --black-light-color: #CCC;
        --border-color: #4D4C4C;
        --toggle-color: #FFF;
        --box1-color: #3A3B3C;
        --box2-color: #3A3B3C;
        --box3-color: #3A3B3C;
        --title-icon-color: #CCC;
    }
    /* === Custom Scroll Bar CSS === */
    ::-webkit-scrollbar {
        width: 8px;
    }
    ::-webkit-scrollbar-track {
        background: #f1f1f1;
    }
    ::-webkit-scrollbar-thumb {
        background: var(--primary-color);
        border-radius: 12px;
        transition: all 0.3s ease;
    }

    ::-webkit-scrollbar-thumb:hover {
        background: #0b3cc1;
    }

    body.dark::-webkit-scrollbar-thumb:hover,
    body.dark .activity-data::-webkit-scrollbar-thumb:hover{
        background: #3A3B3C;
    }

    nav{
        position: fixed;
        top: 0;
        left: 0;
        height: 100%;
        width: 250px;
        padding: 10px 14px;
        background-color: var(--panel-color);
        border-right: 1px solid var(--border-color);
        transition: var(--tran-05);
    }
    nav.close{
        width: 73px;
    }
    nav .logo-name{
        display: flex;
        align-items: center;
    }
    nav .logo-image{
        display: flex;
        justify-content: center;
        min-width: 45px;
    }
    nav .logo-image img{
        width: 40px;
        object-fit: cover;
        border-radius: 50%;
    }

    nav .logo-name .logo_name{
        font-size: 22px;
        font-weight: 600;
        color: var(--text-color);
        margin-left: 14px;
        transition: var(--tran-05);
    }
    nav.close .logo_name{
        opacity: 0;
        pointer-events: none;
    }
    nav .menu-items{
        margin-top: 40px;
        height: calc(100% - 90px);
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }
    .menu-items li{
        list-style: none;
    }
    .menu-items li a{
        display: flex;
        align-items: center;
        height: 50px;
        text-decoration: none;
        position: relative;
    }
    .nav-links li a:hover:before{
        content: "";
        position: absolute;
        left: -7px;
        height: 5px;
        width: 5px;
        border-radius: 50%;
        background-color: var(--primary-color);
    }
    body.dark li a:hover:before{
        background-color: var(--text-color);
    }
    .menu-items li a i{
        font-size: 24px;
        min-width: 45px;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--black-light-color);
    }
    .menu-items li a .link-name{
        font-size: 18px;
        font-weight: 400;
        color: var(--black-light-color);
        transition: var(--tran-05);
    }
    nav.close li a .link-name{
        opacity: 0;
        pointer-events: none;
    }
    .nav-links li a:hover i,
    .nav-links li a:hover .link-name{
        color: var(--primary-color);
    }
    body.dark .nav-links li a:hover i,
    body.dark .nav-links li a:hover .link-name{
        color: var(--text-color);
    }
    .menu-items .logout-mode{
        padding-top: 10px;
        border-top: 1px solid var(--border-color);
    }
    .menu-items .mode{
        display: flex;
        align-items: center;
        white-space: nowrap;
    }
    .menu-items .mode-toggle{
        position: absolute;
        right: 14px;
        height: 50px;
        min-width: 45px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
    }
    .mode-toggle .switch{
        position: relative;
        display: inline-block;
        height: 22px;
        width: 40px;
        border-radius: 25px;
        background-color: var(--toggle-color);
    }
    .switch:before{
        content: "";
        position: absolute;
        left: 5px;
        top: 50%;
        transform: translateY(-50%);
        height: 15px;
        width: 15px;
        background-color: var(--panel-color);
        border-radius: 50%;
        transition: var(--tran-03);
    }
    body.dark .switch:before{
        left: 20px;
    }

    .dashboard{
        position: relative;
        left: 250px;
        background-color: var(--panel-color);
        min-height: 100vh;
        width: calc(100% - 250px);
        padding: 10px 14px;
        transition: var(--tran-05);
    }
    nav.close ~ .dashboard{
        left: 73px;
        width: calc(100% - 73px);
    }
    .dashboard .top{
        position: fixed;
        top: 0;
        left: 250px;
        display: flex;
        width: calc(100% - 250px);
        justify-content: space-between;
        align-items: center;
        padding: 10px 14px;
        background-color: var(--panel-color);
        transition: var(--tran-05);
        z-index: 10;
    }
    nav.close ~ .dashboard .top{
        left: 73px;
        width: calc(100% - 73px);
    }
    .dashboard .top .sidebar-toggle{
        font-size: 26px;
        color: var(--text-color);
        cursor: pointer;
    }
    .dashboard .top .search-box{
        position: relative;
        height: 45px;
        max-width: 600px;
        width: 100%;
        margin: 0 30px;
    }
    .top .search-box input{
        position: absolute;
        border: 1px solid var(--border-color);
        background-color: var(--panel-color);
        padding: 0 25px 0 50px;
        border-radius: 5px;
        height: 100%;
        width: 100%;
        color: var(--text-color);
        font-size: 15px;
        font-weight: 400;
        outline: none;
    }
    .top .search-box i{
        position: absolute;
        left: 15px;
        font-size: 22px;
        z-index: 10;
        top: 50%;
        transform: translateY(-50%);
        color: var(--black-light-color);
    }
    .top img{
        width: 40px;
        border-radius: 50%;
    }
    .dashboard .dash-content{
        padding-top: 50px;
    }
    .dash-content .title{
        display: flex;
        align-items: center;
        margin: 60px 0 30px 0;
    }
    .dash-content .title i{
        position: relative;
        height: 35px;
        width: 35px;
        background-color: var(--primary-color);
        border-radius: 6px;
        color: var(--title-icon-color);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
    }
    .dash-content .title .text{
        font-size: 24px;
        font-weight: 500;
        color: var(--text-color);
        margin-left: 10px;
    }
    .dash-content .boxes{
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
    }
    .dash-content .boxes .box{
        display: flex;
        flex-direction: column;
        align-items: center;
        border-radius: 12px;
        width: calc(100% / 3 - 15px);
        padding: 15px 20px;
        background-color: var(--box1-color);
        transition: var(--tran-05);
    }
    .boxes .box i{
        font-size: 35px;
        color: var(--text-color);
    }
    .boxes .box .text{
        white-space: nowrap;
        font-size: 18px;
        font-weight: 500;
        color: var(--text-color);
    }
    .boxes .box .number{
        font-size: 40px;
        font-weight: 500;
        color: var(--text-color);
    }
    .boxes .box.box2{
        background-color: var(--box2-color);
    }
    .boxes .box.box3{
        background-color: var(--box3-color);
    }
    .dash-content .activity .activity-data{
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
    }
    .activity .activity-data{
        display: flex;
    }
    .activity-data .data{
        display: flex;
        flex-direction: column;
        margin: 0 15px;
    }
    .activity-data .data-title{
        font-size: 20px;
        font-weight: 500;
        color: var(--text-color);
    }
    .activity-data .data .data-list{
        font-size: 18px;
        font-weight: 400;
        margin-top: 20px;
        white-space: nowrap;
        color: var(--text-color);
    }

    @media (max-width: 1000px) {
        nav{
            width: 73px;
        }
        nav.close{
            width: 250px;
        }
        nav .logo_name{
            opacity: 0;
            pointer-events: none;
        }
        nav.close .logo_name{
            opacity: 1;
            pointer-events: auto;
        }
        nav li a .link-name{
            opacity: 0;
            pointer-events: none;
        }
        nav.close li a .link-name{
            opacity: 1;
            pointer-events: auto;
        }
        nav ~ .dashboard{
            left: 73px;
            width: calc(100% - 73px);
        }
        nav.close ~ .dashboard{
            left: 250px;
            width: calc(100% - 250px);
        }
        nav ~ .dashboard .top{
            left: 73px;
            width: calc(100% - 73px);
        }
        nav.close ~ .dashboard .top{
            left: 250px;
            width: calc(100% - 250px);
        }
        .activity .activity-data{
            overflow-X: scroll;
        }
    }

    @media (max-width: 780px) {
        .dash-content .boxes .box{
            width: calc(100% / 2 - 15px);
            margin-top: 15px;
        }
    }
    @media (max-width: 560px) {
        .dash-content .boxes .box{
            width: 100% ;
        }
    }
    @media (max-width: 400px) {
        nav{
            width: 0px;
        }
        nav.close{
            width: 73px;
        }
        nav .logo_name{
            opacity: 0;
            pointer-events: none;
        }
        nav.close .logo_name{
            opacity: 0;
            pointer-events: none;
        }
        nav li a .link-name{
            opacity: 0;
            pointer-events: none;
        }
        nav.close li a .link-name{
            opacity: 0;
            pointer-events: none;
        }
        nav ~ .dashboard{
            left: 0;
            width: 100%;
        }
        nav.close ~ .dashboard{
            left: 73px;
            width: calc(100% - 73px);
        }
        nav ~ .dashboard .top{
            left: 0;
            width: 100%;
        }
        nav.close ~ .dashboard .top{
            left: 0;
            width: 100%;
        }
    }



</style>

<%
    Employee emp=(Employee) session.getAttribute("emp");
%>
<nav>
    <div class="logo-name">
        <div class="logo-image">
            <img src="images/logo.png" alt="">
        </div>
        <span class="logo_name"><%=emp.getName()%> </span>
    </div>
    <div class="menu-items">
        <ul class="nav-links">
            <li><a href="#">
                <i class="uil uil-estate"></i>
                <span class="link-name">Dahsboard</span>
            </a></li>
            <li><a href="empactions">
                <i class="uil uil-files-landscapes"></i>
                <span class="link-name">Manage Employee</span>
            </a></li>
            <li><a href="showallmsg">
                <i class="uil uil-message"></i>
                <span class="link-name">Show All Message </span>
            </a></li>
            <li><a href="getmsgdashboard">
                <i class="uil uil-message"></i>
                <span class="link-name">Mass message</span>
            </a></li>
            
              <li><a href="alltask">
                <i class="uil uil-message"></i>
                <span class="link-name">Tasks</span>
            </a></li>

        </ul>

        <ul class="logout-mode">
            <li><a href="logout">
                <i class="uil uil-signout"></i>
                <span class="link-name">Logout</span>
            </a></li>
            <li class="mode">
                <a href="#">
                    <i class="uil uil-moon"></i>
                    <span class="link-name">Dark Mode</span>
                </a>
                <div class="mode-toggle">
                    <span class="switch"></span>
                </div>
            </li>
        </ul>
    </div>
</nav>
<section class="dashboard">
    <div class="top">
        <i class="uil uil-bars sidebar-toggle"></i>


        <form class="form-inline my-2 my-lg-0" method="post" action="empsearch">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search"
                       name="search">
                <button class="btn btn-outline-info my-2 my-sm-0" type="submit">Search</button>
        </form>
    </div>


    <%

        Integer total= (Integer)(request.getAttribute("total"));
        Integer hr= (Integer)(request.getAttribute("hr"));
       Integer mgr= (Integer)(request.getAttribute("mgr"));

        List<Employee> list=(List<Employee>)request.getAttribute("list");


        int length=5;
        if(list.size()<5){
            length=list.size();
        }

        int i=0;
    %>
    <!--<img src="images/profile.jpg" alt="">-->
    </div>
    <div class="dash-content">
        <div class="overview">
            <div class="title">
                <i class="uil uil-tachometer-fast-alt"></i>
                <span class="text">Dashboard</span>
            </div>
            <div class="boxes">
                <div class="box box1">
                    <i class="uil uil-estate"></i>
                    <span class="text">Total Employee</span>
                    <span class="number"><%=total%></span>
                </div>
                <div class="box box2">
                    <i class="uil uil-estate"></i>
                    <span class="text">HR</span>
                    <span class="number"><%=hr%></span>
                </div>
                <div class="box box3">
                    <i class="uil uil-estate"></i>
                    <span class="text">Manager</span>
                    <span class="number"><%=mgr%></span>
                </div>
            </div>
        </div>
        <div class="activity">
            <div class="title">
                <i class="uil uil-clock-three"></i>
                <span class="text">Recent Activity</span>
            </div>
            <div class="activity-data">
                <div class="data names">
                    <span class="data-title">Name</span>
                    <%
                    while(i<length){
                    %>
                    <span class="data-list"><%=list.get(i++).getName()%></span>
                    <%
                        }
                        if(i==length){
                            i=0;
                        }
                    %>

                </div>
                <div class="data email">
                    <span class="data-title">Email</span>

                    <%
                        while(i<length){
                    %>
                    <span class="data-list"><%=list.get(i++).getEmail()%></span>
                    <%
                        }
                        if(i==length){
                            i=0;
                        }
                    %>
                </div>
                <div class="data joined">
                    <span class="data-title">Joined Date</span>

                    <%
                        while(i<length){
                    %>
                    <span class="data-list"><%=list.get(i++).getDate()%></span>
                    <%
                        }
                        if(i==length){
                            i=0;
                        }
                    %>
                </div>
                <div class="data type">
                    <span class="data-title">Department</span>


                    <%
                        while(i<length){
                    %>
                    <span class="data-list"><%=list.get(i++).getDept().getDeptName()%></span>
                    <%
                        }
                        if(i==length){
                            i=0;
                        }
                    %>
                </div>

            </div>
        </div>
    </div>
</section>
<script>

    const body = document.querySelector("body"),
        modeToggle = body.querySelector(".mode-toggle");
    sidebar = body.querySelector("nav");
    sidebarToggle = body.querySelector(".sidebar-toggle");

    let getMode = localStorage.getItem("mode");
    if(getMode && getMode ==="dark"){
        body.classList.toggle("dark");
    }

    let getStatus = localStorage.getItem("status");
    if(getStatus && getStatus ==="close"){
        sidebar.classList.toggle("close");
    }

    modeToggle.addEventListener("click", () =>{
        body.classList.toggle("dark");
        if(body.classList.contains("dark")){
            localStorage.setItem("mode", "dark");
        }else{
            localStorage.setItem("mode", "light");
        }
    });

    sidebarToggle.addEventListener("click", () => {
        sidebar.classList.toggle("close");
        if(sidebar.classList.contains("close")){
            localStorage.setItem("status", "close");
        }else{
            localStorage.setItem("status", "open");
        }
    })



</script>
</body>
</html>