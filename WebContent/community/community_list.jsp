<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ include file="../include/isFlag.jsp" %>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/community/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/community_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="<%=imgSrc %>" alt="<%=boardTitle %>" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;<%=boardTitle %><p>
				</div>
				<div>

<div class="row text-right" style="margin-bottom:20px;
		padding-right:50px;">
<!-- 검색부분 -->
<form class="form-inline" name="searchFrm">	
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
		<th class="text-center">첨부</th>
	</tr>
	</thead>
	
	<tbody>
	<!-- 리스트반복 -->
<c:choose>	
	<c:when test="${empty lists }">
 				<tr>
 					<td colspan="6" align="center" height="100">
 						등록된 게시물이 없습니다. 
 					</td>
 				</tr>
	</c:when>
	<c:otherwise>
		<c:forEach items="${lists }" var="row" varStatus="loop">				
				<tr>
					<td class="text-center">
						${map.totalCount - (((map.nowPage-1) * map.pageSize) + loop.index)}   
					</td>
					<td class="text-left">
<a href="../community/communityview.do?bname=${param.bname }&idx=${row.idx }&nowPage=${param.nowPage }&searchColumn=${param.searchColumn }&searchWord=${param.searchWord }">${row.title }</a>
					</td>
					<td class="text-center">${row.id }</td>
					<td class="text-center">${row.postdate }</td>
					<td class="text-center">${row.visitcount }</td>
					<td class="text-center">
						<c:if test="${not empty row.ofile }">
							<a href="./Download?filename=${row.ofile }&idx=${row.idx }">
								<i class="material-icons" style="font-size:20px">attach_file</i>
							</a>
						</c:if>
					</td>
				</tr>
		</c:forEach>		
	</c:otherwise>	
</c:choose>
	</tbody>
	</table>
</div>
<div class="row text-right" style="margin-left:700px;">
	<!-- 각종 버튼 부분 -->
	<!-- <button type="reset" class="btn">Reset</button> -->
		
	<button type="button" class="btn btn-primary" 
		onclick="location.href='../community/communityWrite.do?bname=${param.bname}';">글쓰기</button>
				
</div>
<div class="row text-center">
	<!-- 페이지번호 부분 -->
	<div class="col">
	${map.pagingImg }
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
</html>