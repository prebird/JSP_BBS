package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn;
	// private PreparedStatement pstmt; // 마찰이 일어날 수 잇음
	private ResultSet rs;
	
	// 생성자에 커넥션
	public BbsDAO() {
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
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";	//DB오류
	}
	
	public int getNext() {
		String SQL = "SELECT id FROM BBS ORDER BY id DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫번째 게시물인 경우
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; //DB오류
	}
	
	public int write(String bbsTitle, String bbsContent, String userID) {
		String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 0);
			pstmt.setInt(7, 1);
			return pstmt.executeUpdate(); //성공이면 0이상 값반환
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; //DB오류
	}
	
	
	public ArrayList<Bbs> getList(int pageNumber){
		String SQL = "select * from bbs where id < ? and available = 1 order by id desc limit 10";
		ArrayList<Bbs> list =  new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1)* 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setId(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setUserId(rs.getString(3));
				bbs.setRegDate(rs.getString(4));
				bbs.setContent(rs.getString(5));
				bbs.setVisitCnt(rs.getInt(6));
				bbs.setAvailable(rs.getInt(7));
				list.add(bbs);	
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return list; 
	}
	
	// 페이징 처리
	public boolean nextPage(int pageNumber) {
		String SQL = "select * from bbs where id < ? and available =1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1)*10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return false; 
	}
	
	public Bbs getBbs(int bbsId) {
		String SQL = "SELECT * FROM BBS WHERE ID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setId(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setUserId(rs.getString(3));
				bbs.setRegDate(rs.getString(4));
				bbs.setContent(rs.getString(5));
				bbs.setVisitCnt(rs.getInt(6));
				bbs.setAvailable(rs.getInt(7));
				return bbs;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null; //DB오류
	}
}
