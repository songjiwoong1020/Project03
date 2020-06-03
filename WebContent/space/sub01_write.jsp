<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/isLogin.jsp" %>
<%@ include file="../include/isFlag.jsp" %>
<%@ include file="../include/global_head.jsp" %>
<script src="../common/jquery/jquery-3.5.1.js"></script>

<body>
<!-- Smart Editor -->
<script type="text/javascript" src="<%=request.getContextPath()%>/common/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/common/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
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

<form action="WriteProc.jsp" name="writeFrm" method="get"  >
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
			<!-- <textarea rows="10" class="form-control" name="content"></textarea> -->
			<textarea style="width: 100%;" rows="10" name="content" id="content" cols="80"></textarea>
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
	
	<button type="submit" id="submit" class="btn btn-danger" >전송하기</button>
	<button type="reset" class="btn">Reset</button>
	<button type="button" class="btn btn-warning"  onclick="location.href='sub01_list.jsp?bname=<%=bname %>';">리스트보기</button>
</div>
</form>
	<script>
	
	var oEditors = [];
	
	$(function(){
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "content",
	    sSkinURI: "<%=request.getContextPath()%>/common/se2/SmartEditor2Skin.html",
	    fCreator: "createSEditor2"
	});
		
		$("#submit").click(function(){
			console.log($("#content"));
			console.log($("#content").val());
			console.log($("textarea").val());
			console.log($("textarea"));
			
			if($("input[type='text'][name='title']").val()== ""){
				alert('제목을 입력하세요');
				$("input[type='text'][name='title']").focus();
				return false;
			}
			if($("#content").val()== ""){
				alert('내용을 입력하세요');
				$("#content").focus();
				return false;
			}
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		});
	});
	    
	function pasteHTML(filepath){
	    var sHTML = '<img src="<%=request.getContextPath()%>/WebContent/common/se2/upload/'+filepath+'">';
	    oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
	}
	</script>

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>

 </body>
</html>