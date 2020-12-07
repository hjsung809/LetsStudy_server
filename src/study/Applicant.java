package study;

public class Applicant {
	User user;
	int recruitment_id;
	String ur_apply_title;
	String ur_apply_description;
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public int getRecruitment_id() {
		return recruitment_id;
	}
	public void setRecruitment_id(int recruitment_id) {
		this.recruitment_id = recruitment_id;
	}
	public String getUr_apply_title() {
		return ur_apply_title;
	}
	public void setUr_apply_title(String ur_apply_title) {
		this.ur_apply_title = ur_apply_title;
	}
	public String getUr_apply_description() {
		return ur_apply_description;
	}
	public void setUr_apply_description(String ur_apply_description) {
		this.ur_apply_description = ur_apply_description;
	}
}
