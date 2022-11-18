package bom.user;

import java.sql.Date;

public class UserVO {

	private String id;
	private String pwd;
	private String name;
	private Date joinDate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getJoindate() {
		return joinDate;
	}
	public void setJoindate(Date joindate) {
		this.joinDate = joindate;
	}
	
	
	

}
