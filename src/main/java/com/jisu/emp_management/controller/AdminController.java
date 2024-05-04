package com.jisu.emp_management.controller;


import com.jisu.emp_management.model.AdminMsg;
import com.jisu.emp_management.model.Employee;
import com.jisu.emp_management.model.Message;
import com.jisu.emp_management.model.Task;
import com.jisu.emp_management.repo.MessageRepo;
import com.jisu.emp_management.service.AdminMsgService;
import com.jisu.emp_management.service.EmpService;
import com.jisu.emp_management.service.MassMessage;
import com.jisu.emp_management.service.TaskService;

import jakarta.persistence.criteria.CriteriaBuilder.In;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
public class AdminController {

    @Autowired
    private AdminMsgService service;

    @Autowired
    private MessageRepo repo;

    @Autowired
    private MassMessage adminmsgservice;
    
    @Autowired
    private EmpService empservice;
    
    @Autowired
    private TaskService tskService;

    @RequestMapping(path = "/admin", method = RequestMethod.GET)
    public String adminPageProvider(HttpServletRequest request, Model model) {

        return "adminlogin";
    }

    @RequestMapping(path = "/adminloginprocess", method = RequestMethod.POST)
    public RedirectView admiLoginProcess(
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            Model model,
            HttpServletRequest request
    ) {

        Employee emp=this.empservice.findByEmailId(email);

        RedirectView view=new RedirectView();

        boolean arr[]=new boolean[3];

        if (emp==null){
            view.setUrl(request.getContextPath() + "/notfound");
            return view;
        }
        else{
            arr[0]=true;
        }

        if(emp.getPassword().equals(password)){
            arr[1]=true;
        }
        else {
            arr[1]=false;
        }

        if(emp.getDept().getDeptName().equals("ADMIN")){
            arr[2]=true;
        }
        else{
            arr[2]=false;
        }


        int add=0;
        for(boolean a: arr){
            if(a){
                add++;
            }
        }

        System.out.println(Arrays.toString(arr));

        if (!arr[1]) {
            System.out.println(emp.getName());
            view.setUrl(request.getContextPath()+"/redir");
            return view;
        }
        else if(add==3) {
            model.addAttribute("login", true);
            HttpSession session=request.getSession();
            session.setAttribute("emp", emp);
            view.setUrl(request.getContextPath() + "/adminsuccess");
        }
        else if(arr[0] && arr[1] && !arr[2]){
            view.setUrl(request.getContextPath() + "/notadmin");
            return view;
        }



        return view;
    }

    @RequestMapping("/adminsuccess")
    public String adminSuccessPageProvider(Model model,HttpServletRequest request) {

        HttpSession session=request.getSession();

        if(session.getAttribute("emp")==null){
            return "error";
        }

        List<Employee>list=this.empservice.getAllEmployee();

        int total=list.size();
        int hr=0;
        int mgr=0;

        for(Employee e: list){
            if(e.getDept().getDeptName().equals("HR")){
                hr++;
            }
            else if(e.getDept().getDeptName().equals("MANAGER")){
                mgr++;
            }
        }

        Collections.reverse(list);
        model.addAttribute("total",total);
        model.addAttribute("hr",hr);
        model.addAttribute("mgr",mgr);
        model.addAttribute("list",list);

        return "admin/admin";
    }

    @RequestMapping("/redir")
    public String redirLoginPage(Model model){
        model.addAttribute("login",false);
        return "adminredir";
    }

    @RequestMapping(path = "/empactions",method = RequestMethod.GET)
    public String empPageProvider(Model model,HttpServletRequest request){
        HttpSession session=request.getSession();
        if(session.getAttribute("emp")==null){
            return "error";
        }
        List<Employee> list=this.empservice.getAllEmployee();
        model.addAttribute("list",list);

        return "admin/emp";
    }


    @RequestMapping(path = "/sendpublicmsg",method = RequestMethod.POST)
    public RedirectView sendMsg(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("message") String msg,
            HttpServletRequest request,
            Model model
    ){
        AdminMsg message=new AdminMsg();
        message.setMsg(msg);
        message.setName(name);
        message.setEmail(email);

        this.service.saveMsg(message);

        model.addAttribute("send",true);
        RedirectView view=new RedirectView();
        view.setUrl(request.getContextPath()+"/reload");
        return view;
    }

    @RequestMapping(path = "/reload",method = RequestMethod.GET)
    public String getLoadingPage(){
        return "loader";
    }

    @RequestMapping(path = "/showallmsg",method = RequestMethod.GET)
    public String getAllmsg(Model model,HttpServletRequest request){
        HttpSession session=request.getSession();

        if(session.getAttribute("emp")==null){
            return "error";
        }
        List<AdminMsg> messages=this.service.getAllmsg();

        model.addAttribute("messages",messages);
        return "admin/showallmsg";
    }

    @RequestMapping(path = "/msgdel/{id}",method = RequestMethod.GET)
    public RedirectView mgsDel(@PathVariable int id,HttpServletRequest request){
        this.service.deleteMsg(id);
        RedirectView view=new RedirectView();
        view.setUrl(request.getContextPath()+"/showallmsg");
        return view;
    }

    @RequestMapping("/addemployee")
    public String addEmployeeFormProvider(HttpServletRequest request){
        HttpSession session=request.getSession();

        if(session.getAttribute("emp")==null){
            return "error";
        }
        return "admin/addemp";
    }


    @RequestMapping(path = "/viewemp/{id}",method = RequestMethod.GET)
    public String viewEmp(@PathVariable Integer id,Model model,HttpServletRequest request){
        HttpSession session=request.getSession();

        if(session.getAttribute("emp")==null){
            return "error";
        }
        Employee emp=this.empservice.getEmpById(id);
        System.out.println(emp);
        model.addAttribute("emp",emp);
        return "employee/view";
    }



    @RequestMapping(path = "/notadmin",method = RequestMethod.GET)
    public String unAuthorise(){
        return "unauthorise";
    }

    @RequestMapping(path = "/notfound",method = RequestMethod.GET)
    public String notfound(){
        return "notfound";
    }

    @RequestMapping(path = "/logout",method = RequestMethod.GET)
    public RedirectView logout(HttpServletRequest request){
        HttpSession session =request.getSession();
        RedirectView view=new RedirectView();
        Employee emp= (Employee) session.getAttribute("emp");
        session.invalidate();

        if(!emp.getDept().getDeptName().equals("ADMIN")) {
        	view.setUrl(request.getContextPath()+"/emplogin");
        }
      
        else {
        view.setUrl(request.getContextPath()+"/admin");
        }
        return view;
    }
    
    
    @RequestMapping(path = "/getmsgdashboard",method = RequestMethod.GET)
    public String msgDashBoard(Model model) {
    	
    	List<Message> messages=this.adminmsgservice.getAllmsg();
    	model.addAttribute("msgs",messages);
    	
    	return "admin/msgdashboard";
    	
    }

    @RequestMapping(path = "/sendmsg",method = RequestMethod.GET)
    public String addmsg() {
    	return "admin/sendmsg";
    }
    
    @RequestMapping(path = "/msgsubmit",method = RequestMethod.POST)
    public RedirectView msgProcess(
    		@RequestParam("text") String cont,
    		@RequestParam("sub") String sub,
    		HttpServletRequest req
    		) {
    	
    	HttpSession session=req.getSession();
    	Message msg=new Message();
    	Employee emp=(Employee)session.getAttribute("emp");
    	msg.setEmp(emp);
    	msg.setSubject(sub);
    	msg.setBody(cont);
    	
    	LocalDate dt = java.time.LocalDate.now();
		String d = dt.toString();
    	msg.setDate(d);
    	
    	this.adminmsgservice.addMsg(msg);
    	
    	RedirectView view=new RedirectView();
    	view.setUrl(req.getContextPath()+"/getmsgdashboard");
    	
    	return view;
    	
    }
    
    @RequestMapping (path = "admindelmsg/{id}",method = RequestMethod.GET)
    public RedirectView deletemsg (@PathVariable Integer id,HttpServletRequest request) {
    	
    	this.adminmsgservice.deleteMsg(id);
    	
    	RedirectView view=new RedirectView();
    	
    	view.setUrl(request.getContextPath()+"/getmsgdashboard");
    	
    	return view;
    	
    }
    
    @GetMapping("/alltask")
    public String getJobPage(Model model) {
    	List<Task> list=this.tskService.getAllTask();
    	model.addAttribute("tasks",list);
    	return "admin/alltask";
    }
    
    @GetMapping("/addnewtask")
    public String addTask(Model model) {
    	
    	List<Employee> list=this.empservice.getAllEmployee();
    	List<Employee> res=new ArrayList<Employee>();
    	
    	for(Employee e: list) {
    		if(e.getDepartment().getDeptId()!=1) {
    			res.add(e);
    		}
    	}
    	
    	model.addAttribute("emps", res);
    	
    	return "admin/addtask";
    }
    
    @PostMapping("/addtaskprocess")
    public RedirectView addTaskProcess(
    		@RequestParam("sub") String subject,
    		@RequestParam("emps") List<Integer> list,
    		@RequestParam("desc") String desc,
    		HttpServletRequest req
    		) {
    		
    	HttpSession session=req.getSession();
    	
    	Employee admin= (Employee)session.getAttribute("emp");
    	LocalDate dt = java.time.LocalDate.now();
		String d = dt.toString();
		Set<Employee> employees =new HashSet<Employee>();
		for(int id: list ) {
			Employee e=this.empservice.getEmpById(id);
			employees.add(e);
		}
    	Task task=new Task();
    	task.setDate(d);
    	task.setSub(subject);
    	task.setDesc(desc);
    	task.setEmployees(employees);
    	task.setAdminId(admin.getEmpId());
    
    	this.tskService.addTask(task);
    	
    	RedirectView view =new RedirectView();
    	view.setUrl(req.getContextPath()+"/alltask");
    
    	return view;
    }
    
    @PostMapping("/empsearch")
	public String empSearch(
			@RequestParam("search") String name,
			Model model
			) {
		
    	 List<Employee> list=this.empservice.findAllEmpByName(name);
         model.addAttribute("list",list);

         return "admin/emp";	}
    

    
    @GetMapping("/deltask/{id}")
    public RedirectView deleteTask(@PathVariable Integer id,HttpServletRequest request) {
    	
    	this.tskService.deleteTask(id);
    	RedirectView view=new RedirectView();
    	view.setUrl(request.getContextPath()+"/alltask");
    	
    	return view;
    }
}





