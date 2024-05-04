package com.jisu.emp_management.model;

import jakarta.persistence.*;

@Entity
public class Image {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	 private Integer id;
	    private String name;
	    private String contentType;

	@Lob
	@Column(columnDefinition = "LONGBLOB")
	    private byte[] data;

		public Image() {
			super();
			// TODO Auto-generated constructor stub
		}

		public Image(Integer id, String name, String contentType, byte[] data, Integer empId) {
			super();
			this.id = id;
			this.name = name;
			this.contentType = contentType;
			this.data = data;
		}

		public Integer getId() {
			return id;
		}

		public void setId(Integer id) {
			this.id = id;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getContentType() {
			return contentType;
		}

		public void setContentType(String contentType) {
			this.contentType = contentType;
		}

		public byte[] getData() {
			return data;
		}

		public void setData(byte[] data) {
			this.data = data;
		}

		
	    
	    

}
