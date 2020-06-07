package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

public class BoardDAO {
	
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	//생성자. DB연동함.
	public BoardDAO(ServletContext ctx){
		try {
			Class.forName(ctx.getInitParameter("MariaJDBCDriver"));
			String id = "suamil_user";
			String pw = "1234";
			con = DriverManager.getConnection(ctx.getInitParameter("MariaConnectURL"), id, pw);
			//System.out.println("MariaDB연결 성공");
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
			//System.out.println("DB자원반납");
		}
		catch (Exception e) {
			System.out.println("자원반납시 예외발생");
		}
	}
	
	//admin에서 모든 게시판 글 리스트
	public List<BoardDTO> List(){
		
		List<BoardDTO> bbs = new Vector<BoardDTO>();
		String query = "SELECT * FROM multi_board ";
		
		query += " ORDER BY postdate DESC";
		
		try {
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setIdx(rs.getString("idx"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getString("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setBname(rs.getString("bname"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				
				bbs.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("BoardDAO List함수에서 예외발생");
			e.printStackTrace();
		}
		
		return bbs;
		
	}
	
	//게시판 별 게시물 갯수 파악
	public int getTotalRecordCount(Map<String, Object> map) {
		int totalCount = 0;
		
		String query = "SELECT COUNT(*) FROM multi_board"
				+ " WHERE bname = '" + map.get("bname") + "'";
		if(map.get("Word") != null) {
			query += " AND " + map.get("Column") + " "
					+ " LIKE '%" + map.get("Word") + "%'";
		}
		try {
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch(Exception e) {
			System.out.println("BoardDAO getTotalRecordCount함수에서 예외발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	public List<BoardDTO> selectListPage(Map<String, Object> map){
		
		List<BoardDTO> bbs = new Vector<BoardDTO>();
		
		String query = "SELECT * FROM multi_board "
				+ " WHERE bname ='" + map.get("bname") + "'";//where에 bname 필수
				if(map.get("Word") != null) {
					query += " AND " + map.get("Column") + " LIKE '%" + map.get("Word") + "%' ";
				}
				query += "ORDER BY idx DESC LIMIT ?, ?";
				//System.out.println(query);
		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, Integer.parseInt(map.get("start").toString()));
			psmt.setInt(2, Integer.parseInt(map.get("end").toString()));
			rs = psmt.executeQuery();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setIdx(rs.getString("idx"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getString("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setBname(rs.getString("bname"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setThumbnail(rs.getString("thumbnail"));
				
				bbs.add(dto);
			}
		}
		
		catch(Exception e) {
			System.out.println("BoardDAO selectListPage 함수에서 예외발생");
			e.printStackTrace();
		}
		
		return bbs;
		
	}
	//게시물 상세보기를 위해 필요
	public BoardDTO selectView(String idx){
		BoardDTO dto = new BoardDTO();
		String query = "SELECT B.*, M.email FROM membership M "
				+ " INNER JOIN multi_board B ON M.id = B.id WHERE idx = ?"; 
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			while(rs.next()) {
				dto.setIdx(rs.getString("idx"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getString("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setBname(rs.getString("bname"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				
				dto.setEmail(rs.getString("email"));
				
			}
		}
		catch(Exception e) {
			System.out.println("BoardDAO selectView 함수에서 예외발생");
			e.printStackTrace();
		}
		
		return dto;
		
	}
	
	//게시물 삭제처리
	public int delete(BoardDTO dto) {
		int affected = 0;
		try {
			String query = "DELETE FROM multi_board WHERE idx = ?";
					
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getIdx());
			
			affected = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("BoardDAO delete함수에서 예외발생");
			e.printStackTrace();
		}
		return affected;
	}
	
	//글쓰기 처리 메소드
	public int insertWrite(BoardDTO dto) {
		int affected = 0;
		
		try {
			String query = "INSERT INTO multi_board (title, content, id, visitcount, bname, ofile, sfile, thumbnail)"
					+ "VALUES(?, ?, ?, 0, ?, ?, ?, ?)";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			psmt.setString(4, dto.getBname());
			psmt.setString(5, dto.getOfile());
			psmt.setString(6, dto.getSfile());
			psmt.setString(7, dto.getThumbnail());
			
			affected = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("BoardDAO insertWrite함수에서 예외발생");
			e.printStackTrace();
		}
		
		return affected;
	}
	
	//일련번호 num에 해당하는 게시물의 조회수 증가
	public void updateVisitCount(String idx) {
		
		String query = "UPDATE multi_board SET visitcount = visitcount + 1 WHERE idx = ?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			psmt.executeQuery();
		}
		catch (Exception e) {
			System.out.println("BoardDAO updateVisitCount함수에서 예외발생");
			e.printStackTrace();
		}
	}
	
	public int updateEdit(BoardDTO dto) {
		System.out.println("updateEdit함수 진입");
		int affected = 0;
		try {
			String query = "UPDATE multi_board SET title = ?, content = ?, Sfile = ?, Ofile = ? WHERE idx = ?";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getSfile());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getIdx());
			
			affected = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("BoardDAO updateEdit함수에서 예외발생");
			e.printStackTrace();
		}
		System.out.println("dao안에서 affected:" + affected);
		return affected;
	}
	
	public int updateEditNoFile(BoardDTO dto) {
		System.out.println("updateEditNoFile함수 진입");
		int affected = 0;
		try {
			String query = "UPDATE multi_board SET title = ?, content = ? WHERE idx = ?";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getIdx());
			
			affected = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("BoardDAO updateEdit함수에서 예외발생");
			e.printStackTrace();
		}
		
		System.out.println("dao안에서 affected:" + affected);
		return affected;
	}

}
