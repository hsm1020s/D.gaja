<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="labels" value="" scope="page"/>
<c:set var="data" value="" scope="page"/>

<c:forEach var="stat" items="${loginstats}" varStatus="status">
    <c:set var="labels" value="${labels}'${stat.time}', " scope="page"/>
    <c:set var="data" value="${data}${stat.cnt}, " scope="page"/>
</c:forEach>

<!-- Remove the trailing comma -->
<c:set var="labels" value="${fn:substring(labels, 0, fn:length(labels)-2)}" scope="page"/>
<c:set var="data" value="${fn:substring(data, 0, fn:length(data)-2)}" scope="page"/>

<html>
<head>
    <title>통계</title>
<%--    <link rel="stylesheet" href="<c:url value='/css/stats.css'/>">--%>
    <%--    <link rel="stylesheet" href="<c:url value='/css/adminHeader.css'/>">--%>
    <%--    <link rel="stylesheet" href="<c:url value='/css/admin.css'/>">--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
</head>
<body>
<div class="dashboardArea">
    <div class="mDashboard">
        <div class="mDashboard gTabMerge eTabs ui-tabs ui-widget ui-widget-content ui-corner-all">
            <div class="title">
                <span class="advertise">
                    <span id="admngDebug"><script id="admngEffectScript" type="text/javascript" charset="utf-8" src="http://ad.cafe24.com/adManager/util/javascript/adMngEffect.js?ver=1.0.0"></script><script id="cookieScript" type="text/javascript" charset="utf-8" src="http://ad.cafe24.com/adManager/util/javascript/adMngCookie.js?ver=1.0.0"></script><script id="admngLayerScript" type="text/javascript" charset="utf-8" src="http://ad.cafe24.com/adManager/util/javascript/adMngLayer.js?ver=1.0.0"></script><link id="admngCSS" type="text/css" rel="stylesheet" href="http://ad.cafe24.com/adManager/util/javascript/admngCSS.css?ver=1.0.0"><script id="admngURLLog" type="text/javascript" src="http://ad.cafe24.com/adManager/controller/ConclusionURLAD.php?siteType=malladmin&amp;url=http%3A%2F%2Flocalhost%2Fadmin"></script><script type="text/javascript" src="http://ad.cafe24.com/adManager/controller/ConclusionAD.php?siteType_ADParam=malladmin&amp;userID_ADParam=khw4465&amp;ckStr=&amp;ckAllStr=&amp;ckByMulti=false&amp;ssl=false&amp;admngAreaView=false&amp;charset=euc-kr&amp;admngValue=0&amp;dummy=1691562058965&amp;groupIdx_ADParam=73"></script></span>
                    <span id="admngSide_2"></span>
                    <script id="admng" type="text/javascript" src="//ad.cafe24.com/adManager/logic/WebAnalysis.js?siteType=malladmin&amp;userID=khw4465&amp;groupIdx=73" charset="utf-8"></script>
                </span>
            </div>

            <div class="chart-board">
                <div class="mTab typeNav mallStauts">
                    <ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
                        <li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active">
                            <a href="#tabMallStatus1" id="tabMallStatus1Button" data-gtm="DATA_daily_sales_status">시간별 로그인 이력</a>
                        </li>
                        <li class="ui-state-default ui-corner-top">
                            <a href="#tabMallStatus2" data-gtm="DATA_order_processing_status">지역별 회원</a>
                        </li>
                        <li class="ui-state-default ui-corner-top">
                            <a href="#tabMallStatus3" data-gtm="DATA_membership_point_status">나이대별 회원</a>
                        </li>
                        <li class="ui-state-default ui-corner-top">
                            <a href="#tabMallStatus4" data-gtm="DATA_deposit_status">휴면회원 이력통계</a>
                        </li>
                    </ul>
                </div>

                <div id="tabMallStatus1" class="ui-tabs-panel ui-widget-content ui-corner-bottom">
                    <div class="mallArea">
                        <div class="eFlow graph"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                            <div style="width: 310px; height: 155px;">
                                <canvas id="myChart" style="margin: 30px 70px"></canvas>
                            </div>
                            <div class="gSingleSide">
                                <ul class="mList">
                                    <li>최종 업데이트일시 : <span id="eMainSalesDailyChartRefleshTime">08월 14일 11:00:00</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var labels = [${labels}];
    var data = [${data}];

    var context = document
        .getElementById('myChart')
        .getContext('2d');

    var myChart = new Chart(context, {
        type: 'doughnut',
        data: {
            labels: labels,
            datasets: [
                {
                    label: 'test1',
                    data: data,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1,
                    hoverBackgroundColor: [
                        'rgba(255, 99, 132, 0.4)',
                        'rgba(54, 162, 235, 0.4)',
                        'rgba(255, 206, 86, 0.4)',
                        'rgba(75, 192, 192, 0.4)',
                        'rgba(153, 102, 255, 0.4)',
                        'rgba(255, 159, 64, 0.4)'
                    ]
                }
            ]
        },
        options: {
            legend: {
                position: 'right' // 범례를 오른쪽에 위치
            },
            tooltips: {
                callbacks: {
                    title: function (tooltipItem, data) {
                        return data['labels'][tooltipItem[0]['index']];
                    },
                    label: function (tooltipItem, data) {
                        return data['datasets'][0]['data'][tooltipItem['index']] + ' 회';
                    }
                }
            }
        }
    });
</script>
</body>
</html>