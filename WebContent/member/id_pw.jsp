<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>


 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>
				<div class="idpw_box">
					<div class="id_box">
						<form action="" name="findIdFrm">
							<ul>
								<li><input type="text" name="findId_Name" value="" class="login_input01" /></li>
								<li><input type="text" name="findId_Email" value="" class="login_input01" /></li>
							</ul>
							<a href="#" onclick="findIdFunc();"><img  src="../images/member/id_btn01.gif" class="id_btn"  /></a>
						</form>
						<a href="join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" /></a>
					</div>
					<div class="pw_box">
						<!-- <form action="" name="findPassFrm"> -->
							<ul>
								<li><input type="text" name="findPass_Id" value="" class="login_input01" /></li>
								<li><input type="text" name="findPass_Name" value="" class="login_input01" /></li>
								<li><input type="text" name="findPass_Email" value="" class="login_input01" /></li>
							</ul>
							<!-- <input type="image" src="../images/member/id_btn01.gif" class="pw_btn" /> -->
							<button type="button" ><img src="../images/member/id_btn01.gif" class="pw_btn"" alt="" /></button>
						<!-- </form> -->
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>

  
</div>
</body>
<script src="../common/jquery/jquery-3.5.1.js"></script>
<script>
	function findIdFunc(){
	var frm = document.findIdFrm;
	
	if(frm.findId_Name.value == ""){
		alert('이름을 입력해주세요');
		frm.findId_Name.focus();
		return false;
	}
	if(frm.findId_Email.value == ""){
		alert('이메일을 입력해주세요');
		frm.findId_Email.focus();
		return false;
	}
    var s_width = window.screen.width;
    var s_height = window.screen.height;
    var topVar = (s_height/2) - (300/2);
    var leftVar = (s_width/2) - (300/2);

    var gsWin = window.open("about:blank", "winName", "width=300,height=150,left="+leftVar+",top="+
            topVar);
	frm.action = "findId.jsp";
	frm.method = "get";
	frm.target = "winName";
	frm.submit();
	
	}
	/*
	 * 아이디 찾기 할때 쓴 방법보다 이 방법이 더 나아보인다. 
	 */
	$(function(){
		$('button[type="button"]').click(function(){
			if($("input[type='text'][name='findPass_Id']").val() == ""){
				alert("아이디를 입력하세요");
				$("input[type='text'][name='findPass_Id']").focus();
				return false;
			}
			if($("input[type='text'][name='findPass_Name']").val() == ""){
				alert("이름을 입력하세요");
				$("input[type='text'][name='findPass_Name']").focus();
				return false;
			}
			if($("input[type='text'][name='findPass_Email']").val() == ""){
				alert("이메일을 입력하세요");
				$("input[type='text'][name='findPass_Email']").focus();
				return false;
			}
			
        	$.ajax({
        		url :"../member/FindPass.do",
        		data : {
        			findPassId : $("input[type='text'][name='findPass_Id']").val(),
        			findPassName : $("input[type='text'][name='findPass_Name']").val(),
        			findPassEmail : $("input[type='text'][name='findPass_Email']").val()
        		},
        		dataType : "json",
        		type : "get",
        		success : function(data){
        			if(data.findPassResult == "fail"){
        				alert('일치하는 회원정보가 없습니다.');
        			} else {
        				alert('등록하신 이메일로 비밀번호를 전송해드렸습니다.');
        				$("input[type='text'][name='findPass_Id']").val('');
        				$("input[type='text'][name='findPass_Name']").val('');
        				$("input[type='text'][name='findPass_Email']").val('');
        			}
        		},
        		error : function(e) {
        			alert("실패:" + e.status);
        		},
			});
			
		});
		
	});
	
</script>
</html>




