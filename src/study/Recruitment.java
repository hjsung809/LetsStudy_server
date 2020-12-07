package study;

import java.sql.Timestamp;

public class Recruitment {
	int recruitment_id;
	int study_group_id;
	String sg_name;
	String sg_description;
	

	String rc_title;
	String rc_description;
	int rc_size;
	Timestamp created_at;

	public int getRecruitment_id() {
		return recruitment_id;
	}

	public void setRecruitment_id(int recruitment_id) {
		this.recruitment_id = recruitment_id;
	}

	public int getStudy_group_id() {
		return study_group_id;
	}

	public void setStudy_group_id(int study_group_id) {
		this.study_group_id = study_group_id;
	}
	
	public String getSg_name() {
		return sg_name;
	}

	public void setSg_name(String sg_name) {
		this.sg_name = sg_name;
	}

	public String getSg_description() {
		return sg_description;
	}

	public void setSg_description(String sg_description) {
		this.sg_description = sg_description;
	}

	public String getRc_title() {
		return rc_title;
	}

	public void setRc_title(String rc_title) {
		this.rc_title = rc_title;
	}

	public String getRc_description() {
		return rc_description;
	}

	public void setRc_description(String rc_description) {
		this.rc_description = rc_description;
	}

	public int getRc_size() {
		return rc_size;
	}

	public void setRc_size(int rc_size) {
		this.rc_size = rc_size;
	}

	public Timestamp getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}
}
