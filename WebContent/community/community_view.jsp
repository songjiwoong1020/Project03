<%@page import="util.FileUtil"%>
<%@page import="com.sun.corba.se.impl.javax.rmi.CORBA.Util"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="model.BoardDAO"%>
<%@page import="model.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ include file="../include/isFlag.jsp" %>

<%
String queryStr = "bname=" + bname + "&";
String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
if(searchWord != null){
	queryStr += "searchColumn=" + searchColumn + "&searchWord=" + searchWord + "&";
}
String nowPage = request.getParameter("nowPage");
if(nowPage == null || nowPage.equals("")){
	nowPage = "1";
}
queryStr += "&nowPage=" + nowPage;

String idx = request.getParameter("idx");
BoardDAO dao = new BoardDAO(application);

dao.updateVisitCount(idx);

BoardDTO dto = dao.selectView(idx);

dao.close();
%>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/community/sub_image.jpg" id="main_visual" />

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

<form enctype="multipart/form-data">
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="30%"/>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">작성자</th>
		<td>
			<%=dto.getId() %>
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">작성일</th>
		<td>
			<%=dto.getPostdate() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			<%=dto.getEmail() %>
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">조회수</th>
		<td>
			<%=dto.getVisitcount() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td colspan="3">
			<%=dto.getTitle() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td colspan="3">
			<%=dto.getContent().replace("\r\n", "<br/>") %>
			
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td colspan="3">
		<%if(!(dto.getOfile() == null && dto.getSfile() == null)){ %>
			<a href="Download.jsp?ofilename=<%=dto.getOfile()%>&sfilename=<%=dto.getSfile()%>"><%=dto.getOfile() %> [다운로드]</a>
		<%} %>
		</td>
	</tr>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	<%
	if(session.getAttribute("USER_ID") != null &&
	session.getAttribute("USER_ID").toString().equals(dto.getId())){
	%>
	<button type="button" class="btn btn-primary"
		onclick="location.href='sub01_edit.jsp?idx=<%=dto.getIdx()%>&bname=<%=bname %>';">수정하기</button>
	<button type="button" class="btn btn-success" onclick="isDelete();">삭제하기</button>	
	<%
	}
	%>
	<button type="button" class="btn btn-warning" 
		onclick="location.href='./community.do?bname=${param.bname }&nowPage=${param.nowPage}&searchColumn=${param.searchColumn}&searchWord=${param.searchWord}';">리스트보기</button>
</div>
</form> 

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>

		<form name="deleteFrm">
			<input type="hidden" name="idx" value="<%=dto.getIdx() %>" />
			<input type="hidden" name="bname" value="<%=bname %>" />
		</form>
		<script>
			function isDelete(){
				var c = confirm("삭제할까요?");
				if(c){
					var f = document.deleteFrm;
					f.method = "post";
					f.action = "DeleteProc.jsp";
					f.submit();
				}
				
			}
		</script>
	<%@ include file="../include/footer.jsp" %>
	<!-- </center> -->
 </body>
</html>