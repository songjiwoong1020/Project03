
	
/*
    
$(document).ready(function(){
	키코드확인
    $("#input1").keyup(function(event){
        if(event.keyCode !=8){
            var result = "keycode="+ event.keyCode + " value="+ String.fromCharCode(event.keyCode);
            var preHtml = $("#result").html();
            $("#result").html(preHtml+ "<br />" +result);
        }
        if($(this).val() ==""){
            $("#result").empty();
        }

    });
    숫자만입력
    $("#onlyNumber").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9]/gi,''));
        }
    });
    영문만 입력
    $("#onlyAlphabet").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^a-z]/gi,''));    
        }
    });
    영문 숫자
    $("#notHangul").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
        }
    });
    한글만
    $("#onlyHangul").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[a-z0-9]/gi,''));
        }
	}); 
});
	*/

var doubleCheckResult = false;
var idLengthCheck = false;
var passLengthCheck = false;
var passCheck = false;
$(function(){
	//ID중복, 길이 처리
	$("input[name=id]").keyup(function(event){
		//id의 길이가 4보다 작으면 아이디 길이 제한
		if($('input[name=id]').val().length < 4){
        	$('#idCheck').html('<span>* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span>');
        	idLengthCheck = false;
        	//doubleCheckResult = false;
		}
		//영문과 숫자만 입력받게함. 단, 방향키는 제외
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
            //console.log($(this).val());
        }
        //id길이가 4이상이면 DB연동해서 ajax로 중복 체크
        if($('input[name=id]').val().length >= 4 ){
        	idLengthCheck = true;
        	$.ajax({
        		url :"../member/idDoubleCheck.do",
        		data : {
        			idDoubleCheckVal : $(this).val()
        		},
        		dataType : "json",
        		type : "get",
        		success : function(data){
					$('#idCheck').html(data.message);
					doubleCheckResult = data.doubleCheckResult;
					console.log("4자리 넘었을때 바뀌나 안바뀌나" + doubleCheckResult);//비동기라그런가;아..
        		},
        		error : function(e) {
        			alert("실패:" + e.status);
        		},
			});
		}
    });
	
	//비밀번호 길이, 일치 확인
    $('input[name=pass]').keyup(function(){
        $('input[name=passCheck]').val('');
        $('#passMsg2').html('');
        if($('input[name=pass]').val().length < 4){
        	$('#passMsg1').html('<span>* 4자 이상 12자 이내의 영문/숫자 조합</span>');
        	passLengthCheck = false;
        }
        if($('input[name=pass]').val().length >= 4){
        	$('#passMsg1').html('<span></span>');
        	passLengthCheck = true;
        }
    });

    $('input[name=passCheck]').keyup(function(){
        if($('input[name=pass]').val() == $('input[name=passCheck]').val()){//pwd2는 this로 써도 된다.
            $('#passMsg2').html('<b style="color:black;">암호가 일치합니다.</b>');
            passCheck = true;
        } else {
            $('#passMsg2').html("<b>암호가 틀립니다.</b>").css('color', 'red');
            passCheck = false;
        }
    });
	
    //이메일 select선택시 도메인 부분 채워주기
    $('#selectEmail').change(function(){
        
        //$('#email2').val($('#selectEmail').val()); 내가한거

        var text = $('#selectEmail option:selected').text();

        var value = $('#selectEmail option:selected').val();// option:selected는 디폴트인듯?

        if(value == ''){
            $('input[name=email2]').val('');
            $('input[name=email2]').attr("readonly", true); 
        }
         else if(value == '1'){
            $('input[name=email2]').val('');
            //$('input[text][name=email2]').removeAttr("readonly"); 
            $('input[name=email2]').attr("readonly", false); 
        } else {
            $('input[name=email2]').attr("readonly", true); 
            $('input[name=email2]').val(value);
        }
        
    });
	
	//빈값 체크랑 나머지 조건 체크
	$('input[type="image"]').click(function(){
		if($("input[type='text'][name='name']").val() == ""){
			alert("이름을 입력하세요");
			$("input[type='text'][name='name']").focus();
			return false;
		}

		if($("input[type='text'][name='id']").val() == ""){
            alert("아이디를 입력하세요");
            $("input[type='text'][name='id']").focus();
            return false;
        }

        if($("input[type='password'][name='pass']").val().length == 0){
            alert("패스워드를 입력하세요");
            $("input[type='password'][name='pass']").focus();
            return false;
        }

        if($("input[type='text'][name='mobile1']").val().length == 0 ||
        	$("input[type='text'][name='mobile2']").val().length == 0 ||
        	$("input[type='text'][name='mobile3']").val().length == 0){
        	alert("전화번호를 입력하세요");
        	$("input[type='text'][name='mobile1']").focus();
        	return false;
        }
        
        if($("input[type='text'][name='email1']").val().length == 0 ||
        		$("input[type='text'][name='email2']").val().length == 0){
        	alert("이메일을 입력하세요");
        	$("input[type='text'][name='email1']").focus();
        	return false;
        }

        if($("input[type='text'][name='zip1']").val().length == 0 ||
        	$("input[type='text'][name='addr1']").val().length == 0 ||
        	$("input[type='text'][name='addr2']").val().length == 0){
            alert("주소를 입력하세요");
            $("input[type='text'][name='addr2']").focus();
            return false;
        }
        
        if(!idLengthCheck){
        	alert("ID를 확인해주세요");
        	$("input[type='text'][name='id']").focus();
        	return false;
        }

        if(!doubleCheckResult){
        	alert("ID중복체크를 해주세요");
        	$("input[type='text'][name='id']").focus();
        	return false;
        }
        
        if(!passLengthCheck){
        	alert("패스워드를 확인해주세요");
        	$("input[type='password'][name='pass']").focus();
        	return false;
        }
        
        if(!passCheck){
        	alert("비밀번호가 일치하지 않습니다.");
        	$("input[type='password'][name='pass']").focus();
        	return false;
        }
        
    });
	
	$(':input').keyup(function(){
		console.log("id중복체크(doubleCheckResult):"+doubleCheckResult);
		console.log("id길이체크(idLengthCheck):"+idLengthCheck);
		console.log("비번길이체크(passLengthCheck):"+passLengthCheck);
		console.log("비번 일치체크(passCheck):"+passCheck);
	});
});



//우편번호 API
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
            /*
             *  여기 원래 있던 도로명주소 참고사항은 안쓰니까 지워줬다.
             */

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}

