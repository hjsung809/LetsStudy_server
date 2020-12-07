package study;

import java.sql.*;
import java.util.*;

import study.User;

public class Passport {
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

	public User signIn(String email, String password) {
		connect();
		User user = null;
		String sql = "SELECT user_id, usr_email, usr_nickname, usr_phone_number, usr_description, created_at FROM users WHERE usr_email = ? && usr_password = ? limit 1";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				user = new User();
				user.setUser_id(rs.getInt("user_id"));
				user.setUsr_email(rs.getString("usr_email"));
				user.setUsr_nickname(rs.getString("usr_nickname"));
				user.setUsr_phone_number(rs.getString("usr_phone_number"));
				user.setUsr_description(rs.getString("usr_description"));
				user.setCreated_at(rs.getTimestamp("created_at"));
			}
			rs.close();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}

		return user;
	}

	public boolean signUp(String email, String nickname, String password, String phone_number, String description) {
		connect();

		String sql = "insert into users(usr_email, usr_nickname, usr_password, usr_phone_number,usr_description) values(?,?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, email);
			pstmt.setString(2, nickname);
			pstmt.setString(3, password);
			pstmt.setString(4, phone_number);
			pstmt.setString(5, description);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}

		return true;
	}

}
