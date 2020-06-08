<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/isLogin.jsp" %>
<%@ include file="../include/isFlag.jsp" %>
<%
if(bname.equals("staffDataroom")){
	JavascriptUtil.jsAlertBack("해당 게시판은 글쓰기를 할 수 없습니다.", out);
	return;
}
%>
<%@ include file="../include/global_head.jsp" %>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
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
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;<%=boardTitle %><p>
				</div>
				<div>

<form action="../community/communityWrite.do?bname=<%=bname %>';" name="writeFrm" method="post" enctype="multipart/form-data" >
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
			<textarea id="summernote" name="content"></textarea>
			<input type="hidden" name="thumbnail"/>
			<!-- <textarea rows="10" class="form-control" name="content"></textarea> -->
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td>
			<input type="file" class="form-control" name="attachedfile"/>
		</td>
	</tr>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	
	<button type="submit" class="btn btn-danger" >전송하기</button>
	<button type="reset" class="btn">Reset</button>
	<button type="button" class="btn btn-warning"  onclick="location.href='community.do?bname=<%=bname %>';">리스트보기</button>
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
		lang : 'ko-KR',
 		callbacks: {
			onImageUpload: function(files, editor, $editable) {
               	sendFile(files[0], editor, $editable);
			
	        }
	    }
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


	function sendFile(file, editor, welEditable){
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "./summernote_imageUpload.jsp",
			dataType : "json",
			cache : false,
			contentType : false,
			processData : false,
			enctype: 'multipart/form-data',
			success : function(data){
				//alert(data.url);
				$("input[type='hidden'][name='thumbnail']").val(data.url);
				$('#summernote').summernote('insertImage', data.url);
			},
			error : function(data){
				alert('실패');
				console.log(data);
			}
		});
	}
});
</script>
</html>










