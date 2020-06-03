<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/isLogin.jsp" %>
<%@ include file="../include/isFlag.jsp" %>
<%@ include file="../include/global_head.jsp" %>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<body>
	<!-- <center> -->
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

<form action="WriteProc.jsp" name="writeFrm" method="post"  >
	<input type="hidden" name="bname" value="<%=bname%>"/>
<table class="table table-bordered">
<colgroup>
	<col width="15%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td>
			<input type="text" class="form-control" name="title" />
		</td>
	</tr> 
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td>
			<textarea id="summernote" name="content">Hello Summernote</textarea>
			<!-- <textarea rows="10" class="form-control" name="content"></textarea> -->
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td>
			<input type="file" class="form-control" />
		</td>
	</tr>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	
	<button type="submit" class="btn btn-danger" >전송하기</button>
	<button type="reset" class="btn">Reset</button>
	<button type="button" class="btn btn-warning"  onclick="location.href='sub01_list.jsp?bname=<%=bname %>';">리스트보기</button>
</div>
</form>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
<script>
$(function(){
	  $('#summernote').summernote({
		  height: 300,
		  minHeight: null,
		  maxHeight: null,
		  lang : 'ko-KR'
	  });
	  $("button[type='submit']").click(function(){
		  if($('input[name=title]').val() == ""){
			  alert('제목을 작성해주세요');
			  $('input[name=title]').focus();
			  return false;
		  }
		  if($('textarea').val() == ""){
			  alert('내용을 작성해주세요');
			  $('textarea').focus();
			  return false;
		  }
	  });
});
</script>
</html>