package com.jisu.emp_management.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Set;

import com.jisu.emp_management.utils.PdfGenerator;
import com.lowagie.text.Document;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType0Font;

import com.jisu.emp_management.mail.EmailService;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.server.PathParam;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.image.LosslessFactory;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;
import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.RedirectView;

import com.jisu.emp_management.model.Department;
import com.jisu.emp_management.model.Employee;
import com.jisu.emp_management.model.Image;
import com.jisu.emp_management.model.Message;
import com.jisu.emp_management.model.Task;
import com.jisu.emp_management.repo.ImageRepo;
import com.jisu.emp_management.repo.RoleRepo;
import com.jisu.emp_management.service.EmpService;
import com.jisu.emp_management.service.MassMessage;
import com.jisu.emp_management.utils.MyUtils;

import javax.imageio.ImageIO;

@Controller
public class EmpController {

	@Autowired
	private RoleRepo rolerepo;

	@Autowired
	private EmailService emailService;
	@Autowired
	private EmpService service;

	@Autowired
	private MassMessage msgser;
	@Autowired
	private ImageRepo imgrepo;

	@RequestMapping(path = "/empprocess", method = RequestMethod.POST)
	public String addEmp(@RequestParam("name") String name, @RequestParam("pwd") String pass,
			@RequestParam("gender") String gender, @RequestParam("email") String email,
			@RequestParam("dept") Integer Id, @RequestParam("phonenumber") String cont,
			@RequestParam("location") String loc, @RequestParam("postalcode") String post,
			@RequestParam("file") MultipartFile file, Model model, HttpServletRequest request)
			throws IOException, MessagingException {

		HttpSession session = request.getSession();

		if (session.getAttribute("emp") == null) {
			return "error";
		}

		Department dept = this.rolerepo.findById(Id).orElseThrow(() -> new RuntimeException());

		Employee emp = new Employee();
		emp.setName(name);
		emp.setPassword(pass);
		emp.setGender(gender);
		emp.setEmail(email);
		emp.setDept(dept);
		emp.setContact(cont);
		emp.setAddress(loc);
		emp.setPincode(post);

		Image image = new Image();
		image.setName(file.getName());
		image.setContentType(file.getContentType());
		byte[] imagedata = MyUtils.compressImage(file.getBytes(), "jpg", 0.5f);
		image.setData(imagedata);
		emp.setImage(image);
		this.imgrepo.save(image);
		Employee temp = this.service.addEmployee(emp);

		if (temp != null) {
			List<Employee> list = this.service.getAllEmployee();
			model.addAttribute("list", list);
			model.addAttribute("newemp", temp.getName());

			String tile = "Welcome To HIT IT service";

			String sub = "Credentials";

			String body = "Hi " + name + ",\n\nWelcome to HIT IT service!\n\n" + "Your login Password is " + pass
					+ ".\n\nPlease don't share it with anyone. And Your username "
					+ "is same as the email you provided In case You can't login please contact us on +8956342134";
			String user = emp.getEmail();
			emailService.sendEmail(user, sub, body, PdfGenerator.generatePDF(emp), "emp.pdf");
		}
		
		model.addAttribute("update",false);
		return "employee/empsuccess";
	}

	@RequestMapping(path = "/deleteemp/{id}", method = RequestMethod.GET)
	public String delemployee(@PathVariable int id, Model model) {
		Employee temp = this.service.deleteEmp(id);
		List<Employee> list = this.service.getAllEmployee();
		model.addAttribute("list", list);
		model.addAttribute("newemp", temp.getName());

		return "employee/empdelsuccess";
	}

	@RequestMapping(path = "emplogin", method = RequestMethod.GET)
	public String provideEmpLoginform() {

		return "employee/login";
	}

	@RequestMapping(path = "/emploginprocess", method = RequestMethod.POST)
	public RedirectView empLoginchecker(@RequestParam("username") String username,
			@RequestParam("password") String password, HttpServletRequest request) {

		Employee emp = this.service.findByEmailId(username);

		RedirectView view = new RedirectView();

		boolean arr[] = new boolean[3];

		if (emp == null) {
			view.setUrl(request.getContextPath() + "/empnotfound");
			return view;
		} else {
			arr[0] = true;
		}

		if (emp.getPassword().equals(password)) {
			arr[1] = true;
		} else {
			arr[1] = false;
		}

		if (!emp.getDept().getDeptName().equals("ADMIN")) {
			arr[2] = true;
		} else {
			arr[2] = false;
		}

		int add = 0;
		for (boolean a : arr) {
			if (a) {
				add++;
			}
		}

		System.out.println(Arrays.toString(arr));

		if (!arr[1]) {
			System.out.println(emp.getName());
			view.setUrl(request.getContextPath() + "/empredir");
			return view;
		} else if (add == 3) {
			HttpSession session = request.getSession();
			session.setAttribute("emp", emp);
			view.setUrl(request.getContextPath() + "/empsuc");
		} else if (arr[0] && arr[1] && !arr[2]) {
			view.setUrl(request.getContextPath() + "/notemp");
			return view;
		}

		return view;

	}

	@RequestMapping(path = "/empredir", method = RequestMethod.GET)
	public String empRedir() {
		return "employee/empredir";
	}

	@RequestMapping(path = "/empnotfound", method = RequestMethod.GET)
	public String empNtFound() {
		return "employee/empnotfound";
	}

	@RequestMapping(path = "/notemp", method = RequestMethod.GET)
	public String notEmp() {
		return "employee/notemp";
	}

	@RequestMapping(path = "/empsuc", method = RequestMethod.GET)
	public String getEmpdashBoard() {
		return "employee/empdashboard";
	}

	@RequestMapping(path = "/alldept/{id}",method = RequestMethod.GET)
	public String getAlldept(Model model,  @PathVariable int id) {

	
		Employee employee = this.service.getEmpById(id);

		List<Employee> list = this.service.getAllEmployee();
		List<Employee> res = new ArrayList<Employee>();

		for (Employee e : list) {
			if (e.getDept().getDeptId() == employee.getDept().getDeptId()) {
				res.add(e);
			}

		}
		
		
		model.addAttribute("res",res);
		return "employee/allemp";
	}
	
	
	@RequestMapping(path = "/viewms",method = RequestMethod.GET)
	public String viewAllmsg(Model model) {
		
		List<Message> lt=this.msgser.getAllmsg();
		
		model.addAttribute("msgs",lt );
		return "employee/msgs";
	}
	
	
	@RequestMapping(path = "/editemp/{id}",method = RequestMethod.GET)
	public String getEditform(@PathVariable Integer id,Model model) {
		
		Employee emp=this.service.getEmpById(id);
		model.addAttribute("emp", emp);
		
		
		return "employee/updateform";
	}
	
	
	@RequestMapping(path = "/empupdate",method = RequestMethod.POST)
	public String empUpdate(
			@RequestParam("id") Integer id,
			@RequestParam("name") String name,
			@RequestParam("email") String email,
			@RequestParam("dept") Integer deptno,
			@RequestParam("phonenumber") String phone,
			@RequestParam("location") String location,
			@RequestParam("postalcode") String pin,
			@RequestParam("file") MultipartFile file,
			Model model
			) throws IOException {
		
		Employee emp=this.service.getEmpById(id);
		
		Employee temp=new Employee();
		temp.setName(name);
		temp.setEmail(email);
		temp.setContact(phone);
		temp.setAddress(location);
		temp.setDate(emp.getDate());
		temp.setPincode(pin);
		temp.setGender(emp.getGender());
		temp.setPassword(emp.getPassword());
	
			temp.setDepartment(this.rolerepo.findById(deptno).orElseThrow(()-> new RuntimeException()));
		
		
		if(file==null) {
			temp.setImage(emp.getImage());
		}
		else {
			
			Image image = new Image();
			image.setName(file.getName());
			image.setContentType(file.getContentType());
			byte[] imagedata = MyUtils.compressImage(file.getBytes(), "jpg", 0.5f);
			image.setData(imagedata);
			emp.setImage(image);
			this.imgrepo.save(image);
			temp.setImage(image);
		}
		
//		this.service.deleteEmp(id);
		temp.setEmpId(id);
		this.service.addEmployee(temp);
		
		List<Employee> list = this.service.getAllEmployee();
		model.addAttribute("list", list);
		model.addAttribute("newemp", temp.getName());
		model.addAttribute("update",true);
		
		return "employee/empsuccess";
	}
	
	@GetMapping("alltask/{id}")
	public String allTasks(@PathVariable Integer id,Model model) {
		
		List<Employee> admins=new ArrayList<Employee>();
		Set<Task> tasks=this.service.getEmpById(id).getTasks();
		List<Task> tks=new ArrayList<Task>(tasks);
		
		for(Task t: tks) {
			admins.add(this.service.getEmpById(t.getAdminId()));
		}
		model.addAttribute("tasks", tasks);
		
		model.addAttribute("admins", admins);
		
		return "employee/alltask";
	}

}
