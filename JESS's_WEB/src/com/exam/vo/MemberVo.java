package com.exam.vo;

import java.sql.Timestamp;

public class MemberVo {
	
	private String id;
	private String passwd;
	private String name;
	private Integer age;    // ����
	private String gender;  // ����
	private String email;   // �̸��� �ּ�
	private Timestamp regDate;
	private String cname;
	private String tel;
	
	public MemberVo() {
	}
	
	public String getId() {
		return id;
	}
	public String getPasswd() {
		return passwd;
	}
	public String getName() {
		return name;
	}
	public Integer getAge() {
		return age;
	}
	public String getGender() {
		return gender;
	}
	public String getEmail() {
		return email;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public String getCname() {
		return cname;
	}
	public String getTel() {
		return tel;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	
	@Override
	public String toString() {
		return "MemberVo [id=" + id + ", passwd=" + passwd + ", name=" + name + ", age=" + age + ", gender=" + gender
				+ ", email=" + email + ", regDate=" + regDate + ", cname=" + cname + ", tel=" + tel + "]";
	}
	
}




