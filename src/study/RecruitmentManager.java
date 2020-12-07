package study;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class RecruitmentManager {
	public static final int QUERY_BY_RC_TITLE = 1;
	public static final int QUERY_BY_RC_DESCRIPTION = 2;
	
	
	Connection conn = null;
	PreparedStatement pstmt = null;

	/* MySQL 연결정보 */
	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://122.35.194.46:3306/study?serverTimezone=UTC";

	// DB연결 메서드
	void connect() {
		try {
			Class.forName(jdbc_driver);

			conn = DriverManager.getConnection(jdbc_url, "hojun", "hojunhojun");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	void disconnect() {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	

	public boolean createRecruitment(int study_group_id, String rc_title, String rc_description, int rc_size) {
		connect();

		String sql = "insert into recruitments(study_group_id, rc_title, rc_description, rc_size) values(?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, study_group_id);
			pstmt.setString(2, rc_title);
			pstmt.setString(3, rc_description);
			pstmt.setInt(4, rc_size);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}
	
	public Recruitment getRecruitment(int study_group_id) {
		connect();
		Recruitment recruitment = null;

		String sql = "SELECT recruitments.*, study_groups.sg_name, study_groups.sg_description FROM recruitments, study_groups  WHERE recruitments.study_group_id = ? && recruitments.study_group_id = study_groups.study_group_id";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, study_group_id);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				recruitment = new Recruitment();
				
				recruitment.setRecruitment_id(rs.getInt("recruitment_id"));
				recruitment.setStudy_group_id(rs.getInt("study_group_id"));
				
				recruitment.setSg_name(rs.getString("sg_name"));
				recruitment.setSg_description(rs.getString("sg_description"));
				
				recruitment.setRc_title(rs.getString("rc_title"));
				recruitment.setRc_description(rs.getString("rc_description"));
				recruitment.setRc_size(rs.getInt("rc_size"));
				
				recruitment.setCreated_at(rs.getTimestamp("created_at"));
			}
			rs.close();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}

		return recruitment;
	}
	
	
	public int countApplicant(int recruitment_id) {
		connect();
		int count = 0;
		String sql = "select count(*) as number from user_recruitment WHERE recruitment_id = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, recruitment_id);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt("number");		
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return count;
	}
	

	public boolean deleteRecruitment(int recruitment_id) {
		connect();

		String sql = "delete from recruitments where recruitment_id = ?";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, recruitment_id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}
	
	public ArrayList<Recruitment> getRecentRecruitment() {
		connect();
		ArrayList<Recruitment> recruitments = new ArrayList<>();

		// 최근 10
		String sql = "SELECT recruitments.*, study_groups.sg_name, study_groups.sg_description FROM recruitments, study_groups  WHERE recruitments.study_group_id = study_groups.study_group_id ORDER BY recruitments.created_at LIMIT 10";
		

		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				Recruitment recruitment = new Recruitment();
				
				recruitment.setRecruitment_id(rs.getInt("recruitment_id"));
				recruitment.setStudy_group_id(rs.getInt("study_group_id"));
				
				recruitment.setSg_name(rs.getString("sg_name"));
				recruitment.setSg_description(rs.getString("sg_description"));
				
				recruitment.setRc_title(rs.getString("rc_title"));
				recruitment.setRc_description(rs.getString("rc_description"));
				recruitment.setRc_size(rs.getInt("rc_size"));
				
				recruitment.setCreated_at(rs.getTimestamp("created_at"));
				
				recruitments.add(recruitment);
			}
			
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}

		return recruitments;
	}
	
	public ArrayList<Recruitment> searchRecruitment(int queryType, String query) {
		connect();
		ArrayList<Recruitment> recruitments = new ArrayList<>();
		// 이름 기
		String sql;
		
		if (queryType == QUERY_BY_RC_TITLE) {
			sql = "SELECT recruitments.*, study_groups.sg_name, study_groups.sg_description FROM recruitments, study_groups  WHERE recruitments.rc_title LIKE '%?%' && recruitments.study_group_id = study_groups.study_group_id ORDER BY recruitments.created_at";
		} else {
			sql = "SELECT recruitments.*, study_groups.sg_name, study_groups.sg_description FROM recruitments, study_groups  WHERE recruitments.rc_description LIKE '%?%' &&  recruitments.study_group_id = study_groups.study_group_id ORDER BY recruitments.created_at";
		}

		try {
			// 첫번째 쿼리
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				Recruitment recruitment = new Recruitment();
				
				recruitment.setRecruitment_id(rs.getInt("recruitment_id"));
				recruitment.setStudy_group_id(rs.getInt("study_group_id"));
				
				recruitment.setSg_name(rs.getString("sg_name"));
				recruitment.setSg_description(rs.getString("sg_description"));
				
				recruitment.setRc_title(rs.getString("rc_title"));
				recruitment.setRc_description(rs.getString("rc_description"));
				recruitment.setRc_size(rs.getInt("rc_size"));
				
				recruitment.setCreated_at(rs.getTimestamp("created_at"));
				
				recruitments.add(recruitment);
			}
			
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}

		return recruitments;
	}
	
	public boolean applyRecruitment(int user_id, int recruitment_id, String ur_apply_title, String ur_apply_description) {
		connect();

		String sql = "insert into user_recruitment(user_id, recruitment_id, ur_apply_title, ur_apply_description) values(?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, user_id);
			pstmt.setInt(2, recruitment_id);
			pstmt.setString(3, ur_apply_title);
			pstmt.setString(4, ur_apply_description);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}
	
	public boolean deleteApplicant(int user_id, int recruitment_id) {
		connect();

		String sql = "delete from user_recruitment where user_id = ? && recruitment_id = ?";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, user_id);
			pstmt.setInt(2, recruitment_id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}
	
	
	//새 클래스 만들기.지원자 클래스.
	public ArrayList<Applicant> geApplicant(String recruitment_id) {
		connect();
		ArrayList<Applicant> applicants = new ArrayList<>();

		// 최근 10
		String sql = "SELECT user_recruitment.ur_apply_title, user_recruitment.ur_apply_description, users.* FROM user_recruitment, users WHERE user_recruitment.recruitment_id = ? && user_recruitment.user_id = users.user_id";
		

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, recruitment_id);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				Applicant applicant = new Applicant();
				User user = new User();

				user.setUser_id(rs.getInt("user_id"));
				user.setUsr_email(rs.getString("usr_email"));
				user.setUsr_nickname(rs.getString("usr_nickname"));
				user.setUsr_phone_number(rs.getString("usr_phone_number"));
				user.setUsr_description(rs.getString("usr_description"));
				user.setCreated_at(rs.getTimestamp("created_at"));
				applicant.setUser(user);
				
				applicant.setUr_apply_title(rs.getString("ur_apply_title"));
				applicant.setUr_apply_description(rs.getString("ur_apply_description"));
				applicants.add(applicant);
			}
			
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}

		return applicants;
	}
	
}
