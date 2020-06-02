package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

public class MembershipDAO {
	
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	//생성자. DB연동함.
	public MembershipDAO(ServletContext ctx){
		try {
			Class.forName(ctx.getInitParameter("MariaJDBCDriver"));
			String id = "suamil_user";
			String pw = "1234";
			con = DriverManager.getConnection(ctx.getInitParameter("MariaConnectURL"), id, pw);
			System.out.println("MariaDB연결 성공");
		}
		catch(Exception e) {
			System.out.println("MariaDB연결 실패");
			e.printStackTrace();
		}
	}
	//자원반납
	public void close() {
		try {
			if(rs != null) rs.close();
			if(psmt != null) psmt.close();
			if(con != null) con.close();
			System.out.println("DB자원반납");
		}
		catch (Exception e) {
			System.out.println("자원반납시 예외발생");
		}
	}
	//admin에서 회원 리스트
	public List<MembershipDTO> List(){
		
		List<MembershipDTO> bbs = new Vector<MembershipDTO>();
		String query = "SELECT * FROM membership ";
		
		query += " ORDER BY regdate DESC";
		
		try {
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
			while(rs.next()) {
				MembershipDTO dto = new MembershipDTO();
				dto.setMemberlv(rs.getString("memberlv"));
				dto.setName(rs.getString("name"));
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setPhone(rs.getString("phone"));
				dto.setCellphone(rs.getString("cellphone"));
				dto.setEmail(rs.getString("email"));
				dto.setAddress(rs.getString("address"));
				dto.setRegdate(rs.getString("regdate"));
				
				bbs.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("Select시 예외발생");
			e.printStackTrace();
		}
		
		return bbs;
		
	}
	//로그인
	public Map<String, String> login(String id, String pwd){
		
		Map<String, String> maps = new HashMap<String, String>();
		
		String query = "SELECT * FROM membership WHERE id=? AND pass=?";
		//System.out.println("id="+id+"pass="+pwd);
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			rs = psmt.executeQuery();
			if(rs.next()) {
				maps.put("memberlv", rs.getString("memberlv"));
				maps.put("name", rs.getString("name"));
				maps.put("id", rs.getString("id"));
				maps.put("pass", rs.getString("pass"));
				maps.put("phone", rs.getString("phone"));
				maps.put("cellphone", rs.getString("cellphone"));
				maps.put("email", rs.getString("email"));
				maps.put("address", rs.getString("address"));
				maps.put("regdate", rs.getString("regdate"));
			} else {
				System.out.println("결과셋이 없습니다.");
			}
		}
		catch(Exception e) {
			System.out.println("login처리시 쿼리오류");
			e.printStackTrace();
		}
		
		return maps;
	}
	//아이디 중복체크
	public boolean idDoubleCheck(String id) {
		
		String query = "SELECT id FROM membership WHERE id=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			if(rs.next()) {
				System.out.println("중복되는 아이디 있음(여긴 MembershipDAO)");
				return false;
			} else {
				System.out.println("중복되는 아이디 없음(여긴 MembershipDAO)");
				return true;
			}
		}
		catch(Exception e) {
			System.out.println("login중복 처리시 쿼리오류");
			e.printStackTrace();
		}
		return false;
		
	}
	//회원가입
	/*
	 *  이메일 수선동의 여부는 기존에 있던 회원 등급 컬럼을 쓰기로 했다.
	 *  1 => 수신거부
	 *  2 => 수신동의
	 *  5 => 관리자
	 */
	public int signUp(MembershipDTO dto, String openEmail) {
		
		int affected = 0;
		String emailNum;
		try {
			if(openEmail.equals("on")) {//이메일 수신 동의
				emailNum = "2";
			} else {//이메일 수신 거부
				emailNum = "1";
			}
			String query = "INSERT INTO Membership (memberlv, name, id, pass, phone, cellphone, email, address)"
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, emailNum);
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getId());
			psmt.setString(4, dto.getPass());
			psmt.setString(5, dto.getPhone());
			psmt.setString(6, dto.getCellphone());
			psmt.setString(7, dto.getEmail());
			psmt.setString(8, dto.getAddress());
			
			affected = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("insert중 에러발생");
			e.printStackTrace();
		}
		
		return affected;
	}	

	//아이디 찾기
	public String findId(String name, String email) {
		String query = "SELECT id FROM membership WHERE NAME=? AND email=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, name);
			psmt.setString(2, email);
			rs = psmt.executeQuery();
			if(rs.next()) {
				System.out.println("찾으려는 아이디 있음(여긴 MembershipDAO)");
				String id = rs.getString(1);
				
				return id;
			} else {
				System.out.println("찾으려는 아이디 없음(여긴 MembershipDAO)");
				String msg = "fail";
				return msg;
			}
		}
		catch(Exception e) {
			System.out.println("아이디 찾기 처리시 쿼리오류");
			e.printStackTrace();
		}
		return "";
	}
	
	//비밀번호 찾기
	public String findPass(String id, String name, String email) {
		String query = "SELECT pass FROM membership WHERE id=? AND NAME=? AND email=?;";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			psmt.setString(2, name);
			psmt.setString(3, email);
			rs = psmt.executeQuery();
			if(rs.next()) {
				System.out.println("찾으려는 비밀번호 있음(여긴 MembershipDAO)");
				String pass = rs.getString(1);
				
				return pass;
			} else {
				System.out.println("찾으려는 비밀번호 없음(여긴 MembershipDAO)");
				String msg = "fail";
				return msg;
			}
		}
		catch(Exception e) {
			System.out.println("아이디 찾기 처리시 쿼리오류");
			e.printStackTrace();
		}
		return "";
	}
}
