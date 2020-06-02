<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="../common/jquery/jquery-3.5.1.js"></script>
<script type="text/javascript">
/*
 * 아이디 중복체크할때 썼던 방법보다 이방법이 더 간단해보인다.
 */
$(function(){
	$.ajax({
		url :"../member/FindId.do",
		data : {
			findIdName : $('#fName').val(),
			findIdEmail : $('#fEmail').val()
		},
		dataType : "json",
		type : "get",
		success : function(data){
			if(data.findIdResult == "fail"){
				$('#findIdResultDiv').html("일치하는 회원정보가 없습니다.");
			} else {
				$('#findIdResultDiv').html("회원님의 아이디는 " + data.findIdResult + "입니다.");
			}
		},
		error : function(e) {
			alert("실패:" + e.status);
		},
	});
});
</script>
</head>
<body>
<div>
	<input type="hidden" value="${param.findId_Name }" id="fName"/>
	<input type="hidden" value="${param.findId_Email }" id="fEmail"/>
	<br />
	<div id="findIdResultDiv" style="text-align: center;"></div>
	<br />
	<button style="margin-left: 120px" onclick="window.close();" class="btn btn-outline-dark">확인</button>
</div>
</body>
</html>