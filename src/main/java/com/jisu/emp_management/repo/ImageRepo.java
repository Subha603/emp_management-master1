package com.jisu.emp_management.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jisu.emp_management.model.Image;

public interface ImageRepo extends JpaRepository<Image, Integer>{

}
