package com.jisu.emp_management.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jisu.emp_management.model.Department;

public interface RoleRepo extends JpaRepository<Department, Integer>{

}
