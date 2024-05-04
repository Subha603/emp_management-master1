package com.jisu.emp_management.service.impl;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jisu.emp_management.model.Employee;
import com.jisu.emp_management.repo.EmpRepo;
import com.jisu.emp_management.repo.RoleRepo;
import com.jisu.emp_management.service.EmpService;



@Service
public class EmpIMPL implements EmpService{

	@Autowired
	private EmpRepo emprepo;

	@Override
	public Employee addEmployee(Employee emp) {
		// TODO Auto-generated method stub

		LocalDate dt = java.time.LocalDate.now();
		String d = dt.toString();
		emp.setDate(d);
		return this.emprepo.save(emp);
	}

	@Override
	public List<Employee> getAllEmployee() {
		// TODO Auto-generated method stub
		return this.emprepo.findAll();
	}

	@Override
	public Employee getEmpById(Integer Id) {

		return this.emprepo.findById(Id).orElseThrow(()-> new RuntimeException("Employee not found"));
	}

	@Override
	public Employee deleteEmp(Integer Id) {
		// TODO Auto-generated method stub
		Employee temp=getEmpById(Id);
		this.emprepo.delete(temp);
		return temp;
	}

	@Override
	public List<Employee> getByEmail() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Employee updateEmployee(Employee emp, Integer id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Employee findByEmailId(String email) {
		return this.emprepo.findByEmail(email);
	}

	@Override
	public List<Employee> findAllEmpByName(String name) {
		// TODO Auto-generated method stub
		return this.emprepo.findByNameContaining(name);
	}

}
