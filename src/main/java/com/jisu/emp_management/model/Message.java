package com.jisu.emp_management.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;

@Entity
public class Message {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer msgId;
	private String date;
	private String subject;
	private String body;
	
	@ManyToOne
	private Employee emp;

	public Message() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Message(Integer msgId, String date, String subject, String body, Employee emp) {
		super();
		this.msgId = msgId;
		this.date = date;
		this.subject = subject;
		this.body = body;
		this.emp = emp;
	}

	public Integer getMsgId() {
		return msgId;
	}

	public void setMsgId(Integer msgId) {
		this.msgId = msgId;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public Employee getEmp() {
		return emp;
	}

	public void setEmp(Employee emp) {
		this.emp = emp;
	}

	
	
}
