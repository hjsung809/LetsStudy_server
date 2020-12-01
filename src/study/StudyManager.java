package study;

import java.sql.*;
import java.util.*;

import study.StudyGroup;
import study.User;

public class StudyManager {
  Connection conn = null;
  PreparedStatement pstmt = null;
  
  	/* MySQL 연결정보 */
	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://122.35.194.46:3306/study?serverTimezone=UTC"; 
  
    	// DB연결 메서드
	void connect() {
		try {
			Class.forName(jdbc_driver);

			conn = DriverManager.getConnection(jdbc_url,"hojun","hojunhojun");
		} catch (Exception e) {
			e.printStackTrace();
		}
  }
  
  void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
  public boolean createStudyGroup(int owner_id, String sg_name, String sg_description, String sg_max_size) {
    connect();
    
    String sql ="insert into study_groups(owner_id, sg_name, sg_description, sg_max_size, sg_meeting_count) values(?,?,?,?,0)";

    try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, owner_id);
			pstmt.setString(2, sg_name);
      pstmt.setString(3, sg_description);
      pstmt.setInt(4, Integer.parseInt(sg_max_size));
      pstmt.executeUpdate();
		} catch (SQLException e) {
      e.printStackTrace();
      return false;
		}
		finally {
			disconnect();
    }

    return true;
  }
	

  public ArrayList<StudyGroup> getStudyGroupList(int user_id) {
    connect();
		ArrayList<StudyGroup> studyGroups = new ArrayList<>();
		// 본인이 오너인 그룹
    String sql = "SELECT study_groups.study_group_id, usr_nickname, sg_name, sg_description, sg_max_size, sg_meeting_count, study_groups.created_at FROM study_groups, users  WHERE study_groups.owner_id = ? && users.user_id = study_groups.owner_id";
		// 본인이 속한 그룹
		String sql2 = "SELECT study_groups.study_group_id, usr_nickname, sg_name, sg_description, sg_max_size, sg_meeting_count, study_groups.created_at FROM user_study_group, study_groups, users  WHERE  user_study_group.user_id = ? && study_groups.study_group_id = user_study_group.study_group_id && users.user_id = study_groups.owner_id";
    
    
    try {
			//첫번째 쿼리
      pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_id);
      ResultSet rs = pstmt.executeQuery();

			while(rs.next()) {
				StudyGroup studyGroup = new StudyGroup();
				
				studyGroup.setStudy_group_id(rs.getInt("study_group_id"));
				studyGroup.setOwner_nickname(rs.getString("usr_nickname"));
				studyGroup.setSg_name(rs.getString("sg_name"));
				studyGroup.setSg_description(rs.getString("sg_description"));
				studyGroup.setSg_max_size(rs.getInt("sg_max_size"));
				studyGroup.setSg_meeting_count(rs.getInt("sg_meeting_count"));
				studyGroup.setCreated_at(rs.getTimestamp("created_at"));
				studyGroups.add(studyGroup);
			}
			rs.close();

			// 두번째 쿼리
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, user_id);
      rs = pstmt.executeQuery();

			while(rs.next()) {
				StudyGroup studyGroup = new StudyGroup();
				
				studyGroup.setStudy_group_id(rs.getInt("study_group_id"));
				studyGroup.setOwner_nickname(rs.getString("usr_nickname"));
				studyGroup.setSg_name(rs.getString("sg_name"));
				studyGroup.setSg_description(rs.getString("sg_description"));
				studyGroup.setSg_max_size(rs.getInt("sg_max_size"));
				studyGroup.setSg_meeting_count(rs.getInt("sg_meeting_count"));
				studyGroup.setCreated_at(rs.getTimestamp("created_at"));
				studyGroups.add(studyGroup);
			}
			rs.close();			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
    }

    return studyGroups;
  }
}
