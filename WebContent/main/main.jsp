<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마포구립장애인 직업재활센터</title>
<style type="text/css" media="screen">
@import url("../css/common.css");
@import url("../css/main.css");
@import url("../css/sub.css");
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	$(function(){
		//메인페이지를 로드 할때 현재월을 출력하는 달력 가져오기
		$('#calendar_view').load('../include/Calendar.jsp');
		//이전달을 콜백받음
		$('#month_prev').click(function(){
			var n_year = parseInt($('#now_year').val());
			var n_month = parseInt($('#now_month').val());

			if(n_month == 0){
				n_year--;
				n_month=11;
			} else {
				n_month--;
			}

			$('#now_year').val(n_year);
			$('#now_month').val(n_month);
			$('#calendar_n_viwe').html(n_year+ "년 " + (n_month+1) + '월');

			$.get('../include/Calendar.jsp',
				{
					y : n_year,
					m : n_month
				},
				function(d){
					$('#calendar_view').html(d);
				}
			);
		});
		//다음달을 콜백받음
		$('#month_next').click(function(){
			var n_year = parseInt($('#now_year').val());
			var n_month = parseInt($('#now_month').val());

			if(n_month == 11){
				n_year++;
				n_month=0;
			} else {
				n_month++;
			}

			$('#now_year').val(n_year);
			$('#now_month').val(n_month);
			$('#calendar_n_viwe').html(n_year+ "년 " + (n_month+1) + '월');

			$.ajax({
				url : "../include/Calendar.jsp",
				dataType : "html",
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				data : {
					y : n_year, m : n_month
				},
				success:function(responseData){
					$('#calendar_view').html(responseData);
				},
				error:function(errorData){
					alert("오류발생:" + errorData.status+":"+errorData.statusText)
				}
			});
		});

		
		
	});
</script>
<%
//켈린더 클래스로 현재 년/월 구하기
Calendar nowDay = Calendar.getInstance();
int now_year = nowDay.get(Calendar.YEAR);
int now_month = nowDay.get(Calendar.MONTH);
%>
<input type="hidden" id="now_year" value="<%=now_year %>" />
<!-- Calendar클래스의 월은 0~11까지 표현된다. -->
<input type="hidden" id="now_month" value="<%=now_month %>" />
<!-- 
	메인화면에서 회원가입 성공시 세션영역에 SUCCESS_SIGNUP이라는 키값으로 경고창을 저장한다.
	세션영역이기때문에 한번 실행하면 지워줘야하니까 SUCCESS_SIGNUP이 빈값이 아닐때 지워준다.
-->
<c:out value="${sessionScope.SUCCESS_SIGNUP }" escapeXml="false" />
<c:if test="${not empty sessionScope.SUCCESS_SIGNUP }">
	<c:remove var="SUCCESS_SIGNUP" scope="session"/>
</c:if>
</head>
<body>
<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp"%>
		
		<div id="main_visual">
		<a href="../product/sub01.jsp"><img src="../images/main_image_01.jpg" /></a><a href="../product/sub01_02.jsp"><img src="../images/main_image_02.jpg" /></a><a href="../product/sub01_03.jsp"><img src="../images/main_image_03.jpg" /></a><a href="../product/sub02.jsp"><img src="../images/main_image_04.jpg" /></a>
		</div>

		<div class="main_contents">
			<!-- jstl choose문을 이용해서 세션영역에 값이 있는지 없는지를 체크해준다. -->
			<c:choose>
				<c:when test="${empty sessionScope.USER_ID}">
					<!-- 로그인 전 -->
					<div class="main_con_left">
						<p class="main_title" style="border:0px; margin-bottom:0px;"><img src="../images/main_title01.gif" alt="로그인 LOGIN" /></p>
						<div class="login_box">
							<form action="../main/Login.do">
								<table cellpadding="0" cellspacing="0" border="0">
									<colgroup>
										<col width="45px" />
										<col width="120px" />
										<col width="55px" />
									</colgroup>
									<tr>
										<th><img src="../images/login_tit01.gif" alt="아이디" /></th>
										<td><input type="text" name="inputId" value="" class="login_input" /></td>
										<td rowspan="2"><input type="image" src="../images/login_btn01.gif" alt="로그인" /></td>
									</tr>
									<tr>
										<th><img src="../images/login_tit02.gif" alt="패스워드" /></th>
										<td><input type="password" name="inputPassword" value="" class="login_input" /></td>
									</tr>
								</table>
							</form>
							<p>
								<input type="checkbox" name="" value="" /><img src="../images/login_tit03.gif" alt="저장" />
								<a href="../member/id_pw.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>
								<a href="../member/join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a>
							</p>
							
						</div>
					</div>
				</c:when>  	
				<c:when test="${not empty sessionScope.USER_ID}">   
					<!-- 로그인 후 -->
					<div class="main_con_left">
						<p class="main_title" style="border:0px; margin-bottom:0px;">Kosmo61기</p>
						<div class="login_box">
							<p style="padding:10px 0px 10px 10px"><span style="font-weight:bold; color:#333;"><c:out value="${sessionScope.USER_NAME }"/>님 </span> 반갑습니다.<br />로그인 하셨습니다.</p>
							<p style="text-align:right; padding-right:10px;">
								<a href=""><img src="../images/login_btn04.gif" /></a>
								<a href="../member/logout.jsp"><img src="../images/login_btn05.gif" /></a>
							</p>
						</div>
					</div>
				</c:when>
			</c:choose>
			<div class="main_con_center">
				<p class="main_title"><img src="../images/main_title02.gif" alt="공지사항 NOTICE" /><a href="../space/sub01_list.jsp?bname=notice"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_board_list">
					<c:choose>
						<c:when test="${empty noticeList}">
							<li>입력된 게시글이 없습니다.</li>
						</c:when>
						<c:otherwise>
							<c:forEach items="${noticeList }" var="row">
									<li><a href="../space/sub01_view.jsp?idx=${row.idx }&nowpage=1&bname=notice">${row.title}</a> <span>${row.postdate}</span></li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="../images/main_title03.gif" alt="자유게시판 FREE BOARD" /><a href="../space/sub01_list.jsp?bname=freeboard"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_board_list">
					<c:choose>
						<c:when test="${empty freeboardList}">
							<li>입력된 게시글이 없습니다.</li>
						</c:when>
						<c:otherwise>
							<c:forEach items="${freeboardList }" var="row">
									<li><a href="../space/sub01_view.jsp?idx=${row.idx }&nowpage=1&bname=freeboard">${row.title}</a> <span>${row.postdate}</span></li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>

		<div class="main_contents">
			<div class="main_con_left">
				<p class="main_title"><img src="../images/main_title04.gif" alt="월간일정 CALENDAR" /></p>
				<img src="../images/main_tel.gif" />
			</div>
			<div class="main_con_center">
				<p class="main_title" style="border:0px; margin-bottom:0px;"><img src="../images/main_title05.gif" alt="월간일정 CALENDAR" /></p>
				<div class="cal_top">
					<table cellpadding="0" cellspacing="0" border="0">
						<colgroup>
							<col width="13px;" />
							<col width="*" />
							<col width="13px;" />
						</colgroup>
						<tr>
							<!-- 이전달 보기 -->
							<td>
								<img src="../images/cal_a01.gif" style="margin-top:3px; cursor:pointer;" id="month_prev"/>
							</td>
							<!-- 년/월 표시 -->
							<td style="font-weight: bold; font-size: 15px;" id="calendar_n_viwe">
								2020년 06월
							</td>
							<!-- 다음달 보기 -->
							<td><img src="../images/cal_a02.gif" style="margin-top:3px; cursor:pointer;" id="month_next"/></td>
						</tr>
					</table>
				</div>
				<div class="cal_bottom" id="calendar_view">
					<!-- 실제 달력이 출력되는 영역 -->
					<%-- <table cellpadding="0" cellspacing="0" border="0" class="calendar">
						<colgroup>
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="*" />
						</colgroup>
						<tr>
							<th><img src="../images/day01.gif" alt="S" /></th>
							<th><img src="../images/day02.gif" alt="M" /></th>
							<th><img src="../images/day03.gif" alt="T" /></th>
							<th><img src="../images/day04.gif" alt="W" /></th>
							<th><img src="../images/day05.gif" alt="T" /></th>
							<th><img src="../images/day06.gif" alt="F" /></th>
							<th><img src="../images/day07.gif" alt="S" /></th>
						</tr>
						<tr>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">1</a></td>
							<td><a href="">2</a></td>
							<td><a href="">3</a></td>
						</tr>
						<tr>
							<td><a href="">4</a></td>
							<td><a href="">5</a></td>
							<td><a href="">6</a></td>
							<td><a href="">7</a></td>
							<td><a href="">8</a></td>
							<td><a href="">9</a></td>
							<td><a href="">10</a></td>
						</tr>
						<tr>
							<td><a href="">11</a></td>
							<td><a href="">12</a></td>
							<td><a href="">13</a></td>
							<td><a href="">14</a></td>
							<td><a href="">15</a></td>
							<td><a href="">16</a></td>
							<td><a href="">17</a></td>
						</tr>
						<tr>
							<td><a href="">18</a></td>
							<td><a href="">19</a></td>
							<td><a href="">20</a></td>
							<td><a href="">21</a></td>
							<td><a href="">22</a></td>
							<td><a href="">23</a></td>
							<td><a href="">24</a></td>
						</tr>
						<tr>
							<td><a href="">25</a></td>
							<td><a href="">26</a></td>
							<td><a href="">27</a></td>
							<td><a href="">28</a></td>
							<td><a href="">29</a></td>
							<td><a href="">30</a></td>
							<td><a href="">31</a></td>
						</tr>
						<tr>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
						</tr>
					</table> --%>
				</div>
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="../images/main_title06.gif" alt="사진게시판 PHOTO BOARD" /><a href="../space/sub01_list.jsp?bname=photo"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_photo_list">
					<c:choose>
						<c:when test="${empty photoList}">
							<li>입력된 게시글이 없습니다.</li>
						</c:when>
						<c:otherwise>
							<c:forEach items="${photoList }" var="row">
								<li>
									<dt><a href="../space/sub01_view.jsp?idx=${row.idx }&nowpage=1&bname=photo"><img style="width: 95px; height: 63px;" src="${row.thumbnail }" alt="미리보기가 없습니다." /></a></dt>
									<dd><a href="../space/sub01_view.jsp?idx=${row.idx }&nowpage=1&bname=photo">${row.title}</a></dd>
								</li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					<li>
					<!-- <dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li> -->
				</ul>
			</div>
		</div>
		<%@ include file="../include/quick.jsp"%>
	</div>

	<%@ include file="../include/footer.jsp"%>
	
</center>
</body>
</html>