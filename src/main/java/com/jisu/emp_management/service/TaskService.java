package com.jisu.emp_management.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jisu.emp_management.model.Task;
import com.jisu.emp_management.repo.TaskRepo;

@Service
public class TaskService {
	
	@Autowired
	private TaskRepo repo;
	
	
	public Task addTask(Task t) {
		return this.repo.save(t);
	}
	
	public List<Task> getAllTask(){
		return this.repo.findAll();
	}
	
	public void deleteTask(Integer id) {
		this.repo.deleteById(id);
	}

}
