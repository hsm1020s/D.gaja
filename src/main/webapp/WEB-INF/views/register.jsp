<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? '로그인' : '로그아웃'}"/>
<c:set var="addAndModify" value="${loginId=='' ? '/register/add' : '/register/modify'}"/>
<c:set var="register" value="${loginId=='' ? '회원가입' : '정보수정'}"/>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<c:url value='/css/register.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/footer.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/header.css'/>">
</head>
<body>
<jsp:include page="header.jsp"/>
<br><br><br><br>
<!-- 폼 시작 -->
<form id="user" action="/register/add" method="post" onsubmit="return check(this)">
    <h1>회원가입</h1>
    <br>

    <!-- 이름 입력 시작 -->
    <div class="login-input">
        <label for="loginJoinCustName" class="login_input_label">이름 입력 </label>

        <input type="text" id="loginJoinCustName" name="name" placeholder="이름" maxlength="8" class="">
        <br>
        <p class="login-Space"></p>  <!-- 공백 -->
    </div>
    <br>
    <!-- 이름 입력 종료 -->

    <!-- 아이디 입력 시작-->
    <div class="login-input">
        <label for="loginJoinCustId" class="login_input_label">아이디</label>

        <input type="text" id="loginJoinCustId" name="custId" placeholder="영문, 숫자 5-12자리" maxlength="12" class="">
        <br>
        <p class="login-Space"></p>  <!-- 공백 -->
    </div>
    <br>
    <!-- 아이디 입력 종료-->

    <!-- 비밀번호 입력1 시작-->
    <div class="login-input">
        <label for="loginJoinCustPwd1" class="login_input_label">비밀번호</label>

        <input id="loginJoinCustPwd1" name="pwd" placeholder="숫자, 영문, 특수문자 조합 최소 8자리" maxlength="20" type="password" class="" onblur="checkPasswordLength(this)">
        <br>
        <p class="login-Space"></p> <!-- 공백 -->
        <p id="passwordError" style="color:red; display:none;">비밀번호는 최소 8자리 이상이어야 합니다.</p>
    </div>
    <br>
    <!-- 비밀번호 입력1 종료-->

    <!-- 비밀번호 입력 2 시작-->
    <div class="login-input">
        <label for="loginJoinCustPwd2" class="login_input_label">비밀번호 확인</label>
        <input id="loginJoinCustPwd2" name="pwd2" placeholder="비밀번호 재입력" maxlength="20" type="password" class="" onblur="validatePassword()">
        <br>
        <p class="login-Space"></p> <!-- 공백 -->
        <p id="confirmError" style="color:red; display:none;">입력한 비밀번호와 일치하지 않습니다.</p>
        <p id="confirmSuccess" style="color:green; display:none;">입력한 비밀번호가 일치합니다.</p>
    </div>
    <br>
    <!-- 비밀번호 입력 2 종료-->

    <!-- 핸드폰번호 시작 (어떻게 처리할지) -->
    <div class="login-input">
        <label for="loginJoinCustPhone" class="login_input_label">휴대전화번호</label>

        <input type="text" id="loginJoinCustPhone" name="mpNo" placeholder="'-'은 제외하고 입력해주세요." maxlength="11" class="">
        <br>
        <p class="login-Space"></p>  <!-- 공백 -->
    </div>
    <br>
    <!-- 핸드폰번호 종료-->

    <!-- 이메일 입력 시작-->
    <div class="login-input">
        <label for="loginJoinCustEmail" class="login-input_label">이메일</label>
        <div class="login-input_wrap">
            <input type="email" name="email" placeholder="이메일 입력" id="loginJoinCustEmail" class="login-input_input">
            <!-- 여기 수정필요  클래스 굳이? -->
            <div>
                <p class="login-Space"></p> <!-- 공백 -->
                <ul class="login-input__layer-list"></ul>
            </div>
        </div>
    </div>
    <br>
    <!-- 이메일 입력 종료-->


    <div>

    </div>
    <!-- 가입하기 버튼 시작 -->
    <button type="submit" class="login-button">가입하기</button>

    <!-- disabled="disabled" 를 하면 버튼의 상태가 블락처리됨(작동안함) -->
    <!-- 가입하기 버튼 종료 -->
    <input type="hidden" name="toURL" value="${param.toURL}">
    <!-- 화면에 안보이는거 -->
    <!-- 회원유형은 무조건 1로 들어가게 관리자는 따로 -->
    <!-- 회원등급코드 -->
    <!-- 회원상태 -->

</form>
<script>
<%--    자스 파일 분리함--%>
        //레지스터폼에서는 이런방식으로한다.
        <%--function setMessage(msg, element){--%>
        <%--    document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> \${msg}</i>`;--%>
        <%--    document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;--%>

        <%--    if(element) {--%>
        <%--        element.select();--%>
        <%--    }--%>
        <%--}--%>
</script>
<footer>
    <jsp:include page="footer.jsp"/>
</footer>
<script type="text/javascript" src="<c:url value='/js/register.js'/>"></script>
</body>
</html>
