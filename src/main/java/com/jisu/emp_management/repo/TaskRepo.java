package com.jisu.emp_management.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jisu.emp_management.model.Task;

public interface TaskRepo extends JpaRepository<Task, Integer>{
	
	List<Task> findByAdminId(Integer id);
	

}
