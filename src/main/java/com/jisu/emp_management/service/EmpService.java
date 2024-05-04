package com.jisu.emp_management.service;

import java.util.List;

import com.jisu.emp_management.model.Employee;


public interface EmpService {
	
	Employee addEmployee(Employee emp);
	
	List<Employee> getAllEmployee();
	
	Employee getEmpById(Integer Id);
	
	Employee deleteEmp(Integer Id);
	
	List<Employee> getByEmail();
	
	Employee updateEmployee(Employee emp,Integer id);

	Employee findByEmailId(String email);
	
	List<Employee> findAllEmpByName(String name);
	
	
}
