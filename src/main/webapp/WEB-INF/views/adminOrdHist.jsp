<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? '로그인' : '로그아웃'}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문관리</title>

    <!-- Custom fonts for this template -->
    <link rel="stylesheet" type="text/css" href="<c:url value='/vendor/fontawesome-free/css/all.min.css'/>">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="<c:url value='/css/sb-admin-2.min.css'/>" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="<c:url value='/vendor/datatables/dataTables.bootstrap4.min.css'/>" rel="stylesheet">

</head>

<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <!-- Sidebar -->
    <jsp:include page="adminSideBar.jsp"/>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <!-- Topbar -->
            <jsp:include page="adminHeader.jsp"/>
            <!-- End of Topbar -->

            <!-- Begin Page Content -->
            <div class="container-fluid">

                <!-- Page Heading -->
                <h1 class="h3 mb-2 text-gray-800">주문관리</h1>

                <!-- DataTales Example -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">주문 통합검색</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                <tr>
                                    <th>선택</th>
                                    <th>번호</th>
                                    <th>구매자명</th>
                                    <th>구매자ID</th>
                                    <th>주문번호</th>
                                    <th>주문일시</th>
                                    <th>주문상태</th>
                                    <th>상품번호</th>
                                    <th>상품명</th>
                                    <th>수량</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="list" items="${list}">
                                    <tr>
                                        <td><input type="checkbox" class="CBox${list.seq}"></td>
                                        <td>${list.seq}</td>
                                        <td>${list.custName}</td>
                                        <td>${list.custId}</td>
                                        <td class="none-center">${list.ordCd}</td>
                                        <td class="td-weak"><fmt:formatDate value="${list.ordDttm}"
                                                                            pattern="yyyy-MM-dd"/></td>
                                        <td class="td-weak">${list.ordStus}</td>
                                        <td class="td-weak">${list.mainProdCd}</td>
                                        <td class="td-weak">${list.prodName}</td>
                                        <td class="td-weak">${list.totProdCnt}개</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <br>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-5">
                                <div class="dataTables_info" id="dataTable_info" role="status" aria-live="polite">
                                    최근 10건의 주문내역입니다.
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-7">
                                <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
                                    <ul class="pagination">
                                        <c:if test="${totalCnt==null || totalCnt==0}">
                                            <div> 주문 이력이 없습니다.</div>
                                        </c:if>
                                        <c:if test="${totalCnt!=null && totalCnt!=0}">
                                            <c:if test="${ph.showPrev}">
                                                <li class="paginate_button page-item previous disabled"
                                                    id="dataTable_previous">
                                                    <a href="<c:url value='/order/adminOrdHist?page=${ph.beginPage-1}&pageSize=${ph.pageSize}'/>"
                                                       aria-controls="dataTable" data-dt-idx="0" tabindex="0"
                                                       class="page-link">Previous</a>
                                                </li>
                                            </c:if>
                                            <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">

                                                <li class="paginate_button page-item ">
                                                    <a href="<c:url
                                                   value='/order/adminOrdHist?page=${i}&pageSize=${ph.pageSize}'/>"
                                                       aria-controls="dataTable" data-dt-idx="1" tabindex="0"
                                                       class="page-link">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <c:if test="${hist_ph.showNext}">
                                                <li class="paginate_button page-item next" id="dataTable_next"><a
                                                        href="<c:url value='/order/adminOrdHist?page=${ph.endPage+1}&pageSize=${ph.pageSize}'/>"
                                                        aria-controls="dataTable"
                                                        data-dt-idx="7"
                                                        tabindex="0"
                                                        class="page-link">Next</a>
                                                </li>
                                            </c:if>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                            <div class="npay_board_area">
                                <table class="npay_board_table">
                                    <colgroup>
                                        <col class="label_width">
                                        <col>
                                    </colgroup>
                                    <tbody>
                                    <tr>
                                        <th scope="row">주문확인
                                            <div class="_bbDqXY6I5b _1RHctT4n_N"><i
                                                    class="_3X_sdNq6-c _341mNgaIJm _3wYrf841wa"></i>
                                            </div>
                                        </th>
                                        <td colspan="1">
                                            <a href="#" class="btn btn-light btn-icon-split">
                                                <span class="text">발주확인</span>
                                            </a>
                                            <a href="#" class="btn btn-light btn-icon-split">
                                                <span class="text">발송지연 처리</span>
                                            </a>
                                            <a href="#" class="btn btn-light btn-icon-split">
                                                <span class="text">고객 배송지 정보수정</span>
                                            </a>
                                            <a href="#" class="btn btn-light btn-icon-split">
                                                <span class="text">배송희망일 변경</span>
                                            </a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">발송처리
                                            <div class="_bbDqXY6I5b _1RHctT4n_N"><i
                                                    class="_3X_sdNq6-c _341mNgaIJm _3wYrf841wa"></i>
                                            </div>
                                        </th>
                                        <td colspan="1">
                                            <a href="#" class="btn btn-light btn-icon-split">
                                                <span class="text">발송처리</span>
                                            </a>
                                            <a href="#" class="btn btn-light btn-icon-split">
                                                <span class="text">엑셀 일괄 발송처리</span>
                                            </a>
                                            <a href="#" class="btn btn-light btn-icon-split">
                                                <span class="text">합포장 일괄 발송처리</span>
                                            </a>
                                            <a href="#" class="btn btn-light btn-icon-split">
                                                <span class="text">송장수정</span>
                                            </a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">취소처리
                                            <div class="_bbDqXY6I5b _1RHctT4n_N"><i
                                                    class="_3X_sdNq6-c _341mNgaIJm _3wYrf841wa"></i>
                                            </div>
                                        </th>
                                        <td colspan="1">
                                            <a href="#" class="btn btn-light btn-icon-split">
                                                <span class="text">판매자 직접취소 처리</span>
                                            </a>
                                            <a href="#" class="btn btn-light btn-icon-split">
                                                <span class="text">취소 승인처리</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- End of Main Content -->

        <!-- Footer -->
        <footer class="sticky-footer bg-white">
            <div class="container my-auto">
                <div class="copyright text-center my-auto">
                    <span>Copyright &copy; Your Website 2020</span>
                </div>
            </div>
        </footer>
        <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->
<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">현재 세션을 종료하고 싶으시면 "로그아웃"을 눌러주세요.</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                <a class="btn btn-primary" href="<c:url value='${loginOutLink}'/>">로그아웃</a>
            </div>
        </div>
    </div>
</div>


</body>

</html>