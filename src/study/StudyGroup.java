package study;

import java.sql.Timestamp;

public class StudyGroup {
 int study_group_id;
 String owner_nickname;
 String sg_name;
 String sg_description;
 int sg_max_size;
 int sg_meeting_count;
 Timestamp created_at;

  public int getStudy_group_id() {
    return study_group_id;
  }
  public void setStudy_group_id(int study_group_id) {
    this.study_group_id = study_group_id;
  }

  public String getOwner_nickname() {
    return owner_nickname;
  }
  public void setOwner_nickname(String owner_nickname) {
    this.owner_nickname = owner_nickname;
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

  public int getSg_max_size() {
    return sg_max_size;
  }
  public void setSg_max_size(int sg_max_size) {
    this.sg_max_size = sg_max_size;
  }

  public int getSg_meeting_count() {
    return sg_meeting_count;
  }
  public void setSg_meeting_count(int sg_meeting_count) {
    this.sg_meeting_count = sg_meeting_count;
  }

  public Timestamp getCreated_at() {
    return created_at;
  }
  public void setCreated_at(Timestamp created_at) {
    this.created_at = created_at;
  }
}
