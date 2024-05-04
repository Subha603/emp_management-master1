package com.jisu.emp_management.config;

import java.util.List;

import org.springframework.context.annotation.Configuration;

import com.jisu.emp_management.model.Department;
import com.jisu.emp_management.repo.RoleRepo;

import jakarta.annotation.PostConstruct;

@Configuration
public class AppConfig {

	private final RoleRepo repo;


    public AppConfig(RoleRepo repo) {
        this.repo = repo;
    }

    @PostConstruct
    private void insert(){

        List<Department>depts=this.repo.findAll();

        if(depts.size()<3) {
           this.repo.deleteAll();
           Department admin=new Department(1,"ADMIN");
           Department mg=new Department(3,"MANAGER");
           Department hr=new Department(2,"HR");

           this.repo.save(admin);
           this.repo.save(mg);
           this.repo.save(hr);
        }
    }
}
