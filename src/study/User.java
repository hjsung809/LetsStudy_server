package study;

import java.sql.Timestamp;

public class User {
  int user_id;
  String usr_email;
  String usr_nickname;
  // String usr_password;
  String usr_phone_number;
  String usr_description;
  Timestamp created_at;

  public int getUser_id() {
    return user_id;
  }
  public void setUser_id(int user_id) {
    this.user_id = user_id;
  }

  public String getUsr_email() {
    return usr_email;
  }
  public void setUsr_email(String usr_email) {
    this.usr_email = usr_email;
  }

  public String getUsr_nickname() {
    return usr_nickname;
  }
  public void setUsr_nickname(String usr_nickname) {
    this.usr_nickname = usr_nickname;
  }

  // public String getUsr_password() {
  //   return usr_password;
  // }
  // public void setUsr_password(String usr_password) {
  //   this.usr_password = usr_password;
  // }

  public String getUsr_phone_number() {
    return usr_phone_number;
  }
  public void setUsr_phone_number(String usr_phone_number) {
    this.usr_phone_number = usr_phone_number;
  }

  public String getUsr_description() {
    return usr_description;
  }
  public void setUsr_description(String usr_description) {
    this.usr_description = usr_description;
  }

  public Timestamp getCreated_at() {
    return created_at;
  }
  public void setCreated_at(Timestamp created_at) {
    this.created_at = created_at;
  }
}
