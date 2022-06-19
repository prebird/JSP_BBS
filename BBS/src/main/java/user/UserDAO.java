package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// �����ڿ� Ŀ�ؼ�
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbId = "root";
			String dbPw = "root";
			
			java.lang.Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbId, dbPw);
		} catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String sql = "select userPassword from user where userId = ?";
		try {
			pstmt = conn.prepareStatement(sql); // sql injection ����
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); // ��������
			if(rs.next()) { //����� �մٸ�
				if(rs.getString(1).equals(userPassword)) {
					return 1; //�α��μ���
				}
				else {
					return 0; //��й�ȣ�� Ʋ��
				}
			}
			return -1;//���̵𰡾���
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -2;//db����
		
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; //DB����
	}

}
