<%@page import="util.PagingUtil"%>
<%@page import="model.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/global_head.jsp" %>
<%@ include file="isFlag.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

BoardDAO dao = new BoardDAO(application);

Map<String, Object> param = new HashMap<String, Object>();

param.put("bname", bname);

String queryStr = "bname=" + bname + "&"; 

String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
if(searchWord != null){
	param.put("Column", searchColumn);
	param.put("Word", searchWord);
	
	queryStr += "searchColumn=" + searchColumn + "&searchWord=" + searchWord + "&";
}

int totalRecordCount = dao.getTotalRecordCount(param);
System.out.println("totalRecordCount=" + totalRecordCount);

//일단 이렇게 하고 나중에 ajax로 유동적으로 처리 해보자
int pageSize = 10;
int blockPage = 5;

int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
int nowPage = (request.getParameter("nowPage") == null || request.getParameter("nowPage").equals("")) 
	? 1 : Integer.parseInt(request.getParameter("nowPage"));

int start = (nowPage-1)*pageSize;
int end = pageSize;

param.put("start", start);
param.put("end", end);

List<BoardDTO> bbs = dao.selectListPage(param);


dao.close();
%>
<body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="<%=imgSrc %>" alt="<%=boardTitle %>" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;<%=boardTitle %><p>
				</div>
				<div>

<div class="row text-right" style="margin-bottom:20px;
		padding-right:50px;">
<!-- 검색부분 -->
<form class="form-inline" name="searchFrm" >	
<input type="hidden" name="bname" value=<%=bname %> />
	<div class="form-group">
		<select name="searchColumn" class="form-control">
			<option value="title">제목</option>
			<option value="id">작성자</option>
			<option value="content">내용</option>
		</select>
	</div>
	<div class="input-group">
		<input type="text" name="searchWord"  class="form-control"/>
		<div class="input-group-btn">
			<button type="submit" class="btn btn-success">검색
			</button>
		</div>
	</div>
</form>	
</div>
<div class="row">
	<!-- 게시판리스트부분 -->
	<table class="table table-bordered table-hover">
	<colgroup>
		<col width="80px"/>
		<col width="*"/>
		<col width="120px"/>
		<col width="120px"/>
		<col width="80px"/>
		<col width="50px"/>
	</colgroup>
	
	<thead>
	<tr class="success">
		<th class="text-center">번호</th>
		<th class="text-left">제목</th>
		<th class="text-center">작성자</th>
		<th class="text-center">작성일</th>
		<th class="text-center">조회수</th>
	</tr>
	</thead>
	
	<tbody>
	<!-- 리스트반복 -->
	<%
	if(bbs.isEmpty()){
	%>
			<tr>
				<td colspan="5" align="center" height="100">
					등록된 게시물이 없습니다.
				</td>
			</tr>
	<%
	} else {
		int vNum = 0;
		int countNum = 0;
		
		for(BoardDTO dto : bbs){
			vNum = totalRecordCount - (((nowPage-1) * pageSize) + countNum++);
	%>
			<tr>
				<td class="text-center"><%=vNum %></td>
				<td class="text-left">
					<a href="sub01_view.jsp?idx=<%=dto.getIdx()%>
					&nowPage=<%=nowPage%>&<%=queryStr%>">
					<%=dto.getTitle() %>
					</a>
				</td>
				<td class="text-center"><%=dto.getId() %></td>
				<td class="text-center"><%=dto.getPostdate().substring(0, 10)%></td>
				<td class="text-center"><%=dto.getVisitcount() %></td>
			</tr>
	<%
		}
	}
	%>
	</tbody>
	</table>
</div>
<div class="row text-right" style="margin-left: 700px;">
	<!-- 각종 버튼 부분 -->
	<!-- <button type="reset" class="btn">Reset</button> -->
		
	<button type="button" class="btn btn-primary" 
		onclick="location.href='sub01_write.jsp';">글쓰기</button>
				
	<!-- <button type="button" class="btn btn-primary">수정하기</button>
	<button type="button" class="btn btn-success">삭제하기</button>
	<button type="button" class="btn btn-info">답글쓰기</button>
	<button type="button" class="btn btn-warning">리스트보기</button>
	<button type="submit" class="btn btn-danger">전송하기</button> -->
</div>
<div class="row mt-3">
	<div class="col">
	<!-- 페이지번호 부분 -->
	<%=PagingUtil.pagingBS4(totalRecordCount, pageSize, blockPage, nowPage, "sub01_list.jsp?" + queryStr) %>
	</div>
</div>

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
<script type="text/javascript">


</script>
</html>