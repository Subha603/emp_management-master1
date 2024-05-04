package com.jisu.emp_management.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jisu.emp_management.model.Employee;

public interface EmpRepo extends JpaRepository<Employee, Integer>{
    Employee findByEmail(String email);
    
    List<Employee> findByNameContaining(String name);

}
