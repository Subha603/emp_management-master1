package com.jisu.emp_management.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jisu.emp_management.model.Employee;
import com.jisu.emp_management.model.Message;
import com.jisu.emp_management.repo.MassMessageRepo;

@Service
public class MassMessage {
	
	@Autowired
	private MassMessageRepo repo ;
	
	public Message addMsg(Message msg) {
		return this.repo.save(msg);
	}
	
	public Message getMsgById(Integer id) {
		return this.repo.findById(id).orElseThrow(()-> new RuntimeException("Id not found"));
	}
	
	public List<Message> getAllmsg(){
		return this.repo.findAll();
	}
	
	public void deleteMsg(Integer id) {
		this.repo.deleteById(id);
	}

	public List<Message> getAllByEmp(Employee e){
		return this.repo.findByEmp(e);
	}
	
}
