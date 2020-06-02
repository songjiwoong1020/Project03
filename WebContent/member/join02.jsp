<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script src="../common/jquery/jquery-3.5.1.js"></script><!--  -->
<script src="join02.js"></script><!-- 스크립트는 보기 편하려고 따로 뺐습니다. -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script><!-- 우편번호API -->

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
					<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>
				</div>

				<!-- 폼태그 시작 -->
				<form action="../member/signUp.do" name="SignUpFrm" method="post">
				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<!-- 이름 부분 : name -->
						<td><input type="text" name="name" value="" class="join_input" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<!-- 아이디 부분 : id -->
						<td><input type="text" name="id"  value="" class="join_input" maxlength="12"/>
						<!-- 중복확인 부분 -->
						<!-- <a onclick="id_check_person();" style="cursor:hand;"><img src="../images/btn_idcheck.gif" alt="중복확인"/></a> -->&nbsp;<span id="idCheck" >* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span></td>
					</tr>
					<tr>
						<!-- 비밀번호 부분 : pass -->
						<th><img src="../images/join_tit003.gif"/></th>
						<td><input type="password" name="pass" value="" class="join_input" maxlength="12"/>&nbsp;&nbsp;<span id="passMsg1">* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					<tr>
						<!-- 비밀번호 확인 부분 : passCheck -->
						<th><img src="../images/join_tit04.gif" /></th>
						<td><input type="password" name="passCheck" value="" class="join_input" maxlength="12"/><span id="passMsg2"></span></td>
					</tr>
					

					<tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
						<!-- 전화번호 부분 : tel1 tel2 tel3 => 하나로바꿀까? -->
							<input type="text" name="tel1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="" maxlength="4" class="join_input" style="width:50px;" />
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
						<!-- 핸드폰번호 부분 : mobile1 mobile2 mobile3 => 하나로바꿀까? -->
							<input type="text" name="mobile1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile3" value="" maxlength="4" class="join_input" style="width:50px;" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
 
						<!-- 이메일 부분 : email1 email2 => 하나로바꿀까? -->
							<input type="text" name="email1" style="width:100px;height:20px;border:solid 1px #dadada;"/> @ 
							<input type="text" name="email2" style="width:150px;height:20px;border:solid 1px #dadada;" readonly />
							<select id="selectEmail" class="pass">
								<option value="">선택해주세요</option>
								<option value="1" >직접입력</option>
								<option value="naver.com" >naver.com</option>
								<option value="gmail.com" >gmail.com</option>
							</select>
	 					
						<!-- 이메일 수신동의 부분 : openEmail-->
						<input type="checkbox" name="openEmail">
						<span>이메일 수신동의</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
						<input type="text" id="postcode" name="zip1" value=""  class="join_input" style="width:100px;" readonly/>
						<!-- 우편번호 검색 부분 -->
						<a href="javascript:;" title="새 창으로 열림" onclick="sample6_execDaumPostcode()" onkeypress="">[우편번호검색]</a>
						<br/>
						<!-- 주소 부분 : addr1 addr2-->
						<input type="text" id="address" name="addr1" value=""  class="join_input" style="width:550px; margin-top:5px;" readonly/><br>
						<input type="text" id="detailAddress" name="addr2" value=""  class="join_input" style="width:550px; margin-top:5px;"/>
						
						</td>
					</tr>
				</table>
																			<!-- 확인 --> 														<!-- 취소 -->
				<p style="text-align:center; margin-bottom:20px"><input type="image" src="../images/btn01.gif"></input>&nbsp;&nbsp;<a onclick='history.go(-2);'><img src="../images/btn02.gif" /></a></p>
				</form>
				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
