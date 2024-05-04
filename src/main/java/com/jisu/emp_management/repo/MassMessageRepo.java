package com.jisu.emp_management.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jisu.emp_management.model.Employee;
import com.jisu.emp_management.model.Message;

public interface MassMessageRepo extends JpaRepository<Message, Integer>{
	
	List<Message> findByEmp(Employee e);
}
