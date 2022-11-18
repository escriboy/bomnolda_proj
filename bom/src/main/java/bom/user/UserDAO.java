package bom.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDAO {
	private DataSource dataFactory;
	private Connection conn;
	private PreparedStatement pstmt;
	
	public UserDAO() {
		try {
			Context ctx=new InitialContext();
			Context envContext=(Context)ctx.lookup("java:/comp/env");
			dataFactory=(DataSource)envContext.lookup("jdbc/oracle");
		} catch (Exception e) {
			System.out.println("DB 연결 오류");
		}
	}
	
	public boolean memExists(UserVO userVO) {
		boolean result=false;
		String id=userVO.getId();
		String pwd=userVO.getPwd();
		String name=userVO.getName();
		try {
			conn=dataFactory.getConnection();
			String query="select decode(count(*), 1, 'true', 'false') as result from usertbl where id=? and pwd=?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			ResultSet rs=pstmt.executeQuery();
			System.out.println(query);
			rs.next();
			result=Boolean.parseBoolean(rs.getString("result"));
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			System.out.println("로그인 회원정보 확인 중 오류" + e.getMessage());
		}
		return result;
	}
	// 회원 이름 확인
		public String getUserName(UserVO userVO) {
			String name = null;
			String id = userVO.getId();
			try {
				conn=dataFactory.getConnection();
				String query="select name from usertbl where id=?";
				pstmt=conn.prepareStatement(query);
				pstmt.setString(1, id);
				ResultSet rs=pstmt.executeQuery();
				rs.next();
				name = rs.getString("name");
				rs.close();
				pstmt.close();
				conn.close();
			} catch (Exception e) {
				System.out.println("회원 이름 확인 중 오류");
			}
			return name;
		}
		
		//ID 중복 여부 확인
		public boolean overlappedID(String id) {
			boolean result=false;
			try {
				conn=dataFactory.getConnection();
				String query="select decode(count(*), 1, 'true', 'false') as result from usertbl where id=?";
				pstmt=conn.prepareStatement(query);
				pstmt.setString(1, id);
				ResultSet rs=pstmt.executeQuery();
				rs.next();
				result=Boolean.parseBoolean(rs.getString("result"));
				rs.close();
				pstmt.close();
				conn.close();
			} catch (Exception e) {
				System.out.println("USERTBL 조회 중 에러 발생" + e.getMessage());
			}
			return result;
		}
		
		// 회원가입
		public void join(UserVO userVO) {
			String id = userVO.getId();
			String pwd = userVO.getPwd();
			String name = userVO.getName();
			try {
				conn = dataFactory.getConnection();
				String query = "insert into usertbl (id, pwd, name) values(?,?,?)";
				pstmt=conn.prepareStatement(query);
				pstmt.setString(1, id);
				pstmt.setString(2, pwd);
				pstmt.setString(3, name);
				pstmt.executeUpdate();
				pstmt.close();
				conn.close();
			} catch (Exception e) {
				System.out.println("회원가입 중 오류" + e.getMessage());
			}
		}
}
