<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? '로그인' : '로그아웃'}"/>
<c:set var="addAndModify" value="${loginId=='' ? '/register/add' : '/register/modify'}"/>
<c:set var="register" value="${loginId=='' ? '회원가입' : '정보수정'}"/>
<html>
<head>
    <title>마이페이지</title>
    <link rel="stylesheet" href="<c:url value='/css/myPage.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/myPageSideBar.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/footer.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/header.css'/>">
</head>
<body>
<!-- 전체 div -->

<jsp:include page="header.jsp"/>
<div class="frame-full head-mypage">
    <h2 class="blind">마이페이지</h2>
    <div class="user-info-box">
        <div class="inner">
            <dl class="column order">
                <dt>주문/배송</dt>
                <dd><a href="/mypage/orderlist"><strong class="num" id="orderCountText">0</strong>건</a></dd>
            </dl><!--// order -->
            <dl class="column coupon">
                <dt>쿠폰</dt>
                <dd><a href="/mypage/myCoupon"><strong class="num" id="couponCountText">0</strong>개</a></dd>
            </dl><!--// coupon -->
            <dl class="column point">
                <dt>포인트</dt>
                <dd class="text-primary"><a href="/mypage/myPoint"><strong class="num" id="totalUnusedPointText">${pointResult}</strong>P</a></dd>
            </dl><!--// point -->
        </div><!--// inner -->
    </div><!--// user-info-box -->
</div>

<%--스타일248 제거대상 mhs--%>
<div id="" class="content">
    <!-- 그다음 div -->
    <jsp:include page="myPageSideBar.jsp"/>

    <div class="right-content">
        <!-- 박스 아래에 붙일 포인트 -->
        <div class="point-list">
            <div class="point-item">
                <ul>
                </ul>
            </div>
        </div>
        <!-- 그 아래에 붙일 div -->
        <div class="order-status">
            <div class="status-header">
                <h3>나의 주문처리 현황
                    <span class="time-frame">(최근 <em class="months">3개월</em> 기준)</span>
                </h3>
            </div>
            <!-- 이 div 는 box처리할거임 -->
            <div class="status-content">
                <ul class="status-list">
                    <li class="status-item">
                        <strong class="status-name">입금전</strong>
                        <a href="" class="status-link"><span id="prepayment-count">0</span>건</a>
                    </li>
                    <li class="status-item">
                        <strong class="status-name">배송준비중</strong>
                        <a href="" class="status-link"><span id="preparing-count">0</span>건</a>
                    </li>
                    <li class="status-item">
                        <strong class="status-name">배송중</strong>
                        <a href="" class="status-link"><span id="shipping-count">0</span>건</a>
                    </li>
                    <li class="status-item">
                        <strong class="status-name">배송완료</strong>
                        <a href="" class="status-link"><span id="delivered-count">0</span>건</a>
                    </li>
                </ul>
                <!-- 박스 안의 오른쪽에 붙일 내용 -->
                <ul class="status-list">
                    <li class="status-item">
                        <strong class="status-name">취소</strong>
                        <a href="" class="status-link"><span id="canceled-count">0</span>건</a>
                    </li>
                    <li class="status-item">
                        <strong class="status-name">교환</strong>
                        <a href="" class="status-link"><span id="exchanged-count">0</span>건</a>
                    </li>
                    <li class="status-item">
                        <strong class="status-name">반품</strong>
                        <a href="" class="status-link"><span id="returned-count">0</span>건</a>
                    </li>
                </ul>
            </div>
        </div>
        <!-- 맨 아래에 배치시킬 div -->
        <div class="recently-viewed">
            <div class="recently-header">
                <h3>최근본상품</h3>
            </div>
            <div class="recently-content">
                <div class="recently-item">
                </div>
                <p class="no-item">최근본 상품 내역이 없습니다.</p>
            </div>
        </div>

    </div>
</div>

<jsp:include page="footer.jsp"/>
<script type="text/javascript" src="<c:url value='/js/myPage.js'/>"></script>
<%--자스 파일 분리했음--%>
</body>

</html>
