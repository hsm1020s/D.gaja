# D.gaja MALL

## 목차
* [개요](#개요)
* [멤버구성](#멤버구성)
* [프로젝트 목적](#프로젝트-목적)
* [ERD](#ERD) 
* [구현 기능](#구현-기능)
* [프로젝트 회고](#프로젝트-회고)
* [Reference](#Reference)
* [구현 화면](#구현-화면)

## 개요
* 프로젝트 이름 : D.gaja (드가자) 쇼핑몰 프로젝트
* 프로젝트 기간(1차,2차) : 2023.05.30~2023.08.14 (기획,모델링,발표 포함) 77일 1000시간
* 프로젝트 진행 기관 : 남궁성의 정석코딩 (부트캠프) -> 개인비용(자비 지출) & 국비지원이 아닙니다.
* Back-End : Tomcat, Java11, Spring5, MySQL8.0, MyBatis, JSP, Maven, JUnit4
* Front-End : HTML, CSS3, JS ES6, Ajax, JQUERY
* 개발 TOOL : IntelliJ, VSCode, DataGrip, MySQL Workbench
* 협업 TOOL : git, Draw.io, Discord, Notion
* 외부 API : 카카오 결제 API, 다음 우편번호 API, 자바 메일 API

## 멤버구성

팀장<br>
* 문희석 <br>
  로그인, 회원가입,정보수정, ID와 PW찾기, 로그인이력, 로그인통계, 포인트적립,사용,포인트이력<br> 회원리스트, 상품등록, 메인페이지(백엔드와 프론트 일부)<br>
  일정관리, 프로젝트 방향성을 제시, 문제가 발생하면 방향성을 제시하고 해결을 도와줌.<br>

부팀장<br>
* 김현우 <br>
  장바구니, 주문서, 주문내역, 주문상세, 배송지관리, 발주, 배송, 주문통계, 상품상세<br>
  프로젝트 초반에 깃을 공부해서 팀원들에게 자료를 공유함. 팀장의 부족한 부분을 채워줌.<br>

팀원<br>
* 김유성 : 공지사항, 1:1문의, FAQ, 상품조회<br>
  프로젝트 마지막에 QA역할, ppt, 포토샵을 해서 발표에 기여를 함. 프로젝트 방향성을 이해하고 잘 따라줌.<br>

## 프로젝트 목적
다른 주제로 프로젝트를 할 수 있었으나, 업무를 배워서 기획,설계를 하기에는 시간이 부족했습니다.<br>
제일 자주 사용하는 쇼핑몰을 주제로 선정하였고,<br>
웹 개발을 어떻게 하는지 처음부터 끝까지 한 사이클 경험 해보는게 목적이었습니다.<br>

## ERD

#### 담당 회원모듈 (민트색) 문희석 
<br> 개발 초기에 개념/논리 모델링 사진 입니다 ( 한글 )
<br> <img width="626" alt="드가자 개념,논리" src="https://github.com/hsm1020s/D.gaja/assets/111288446/2c313648-7b82-43c8-89aa-3f064e452777">
<br><br> 아래는 프로젝트 종료 후 리버스엔지니어링을 한 물리 모델링 사진입니다 ( 영어 ) <br>
공동 설계한 부분은 각자 해당하는 색을 채워놨습니다.
![ERD_last](https://github.com/hsm1020s/D.gaja/assets/111288446/1907146f-a6fd-4dbf-85ca-cc89ff99dea8)



## 구현 기능
1. 로그인<br>
2. 회원가입<br>
3. 정보수정<br>
4. ID와 PW찾기<br>
5. 로그인이력<br>
6. 로그인통계<br>
7. 포인트(적립,사용,이력)<br>
8. 회원리스트<br>
10. 상품등록<br>
11. 메인페이지(백엔드)<br>

제가 했던 부분만 엑셀로 작성하였습니다! <br>
https://docs.google.com/spreadsheets/d/1WXLDmW3a44vHY5Zgf1sE63GcTYKvZk6dAML7gX1PrzI/edit?usp=sharing   <br><br>
9개의 컨트롤러에서 23개의 API, 7개의 메서드<br>
<br>
<img width="786" alt="image" src="https://github.com/hsm1020s/D.gaja/assets/111288446/066fec96-25b8-4071-b154-590be4aafdba">




## 프로젝트 회고
일정을 정해놓고 팀원들과 회의하고 협의해 가면서 프로젝트를 완성했습니다.<br>
처음에 5명이었고 중간에 2명이 빠지면서 어려움에 처했으나, 나머지 팀원들과 함께 차근차근 문제를 해결해나갔습니다.<br>
제일 익숙한 쇼핑몰의 ERD를 설계하는 것은 쉬울 줄 알았으나 막상 해보니 특정 부분에서 어려움이 있었고<br>
서로 의견을 나누는 과정에서 생각이 많이 확장되었습니다.<br>

프로젝트를 하면서 경험한 것들입니다.
1. 버전 관리와 깃허브 충돌 해결
2. ERD 설계 후 개발과정에서 ERD의 문제점을 발견하고 해결해 나가는 과정
3. 프론트엔드부터 백엔드까지 모두 경험해 보는 것
4. 다른 사람의 에러를 보고 코드를 분석해서 해결해 준 경험 <br>

처음 팀장으로 프로젝트를 해서 많은 부담감이 있었지만 원장님의 조언과 팀원들이 잘 따라준 덕에 무사히 마무리 할 수 있었습니다. <br>
프로젝트가 저 혼자 하는 게 아니라 모두가 함께 하는 것이라는 것을 알게 되었고 <br>
무엇보다 마지막까지 포기하지 않고 함께 해준 팀원분들께 매우 감사드립니다. <br>

이번 프로젝트로 개발 경험과 문제 해결, 의사소통 능력이 많이 향상되었으며
회사에 들어가서 일을 하는데 큰 도움이 될 것 같습니다. 

발표 영상을 첨부합니다.<br>
https://youtu.be/pg4bqkl2JkQ
<br><br>
![image](https://github.com/hsm1020s/D.gaja/assets/111288446/48e6a40d-0a65-4590-9552-c8d63160d363)



## Reference
* Rankingdak.com, Imdak, Moguchonmall, Cafe24
* 자바의 정석
* 스프링의 정석

## 구현 화면

<br>
메인페이지 프론트(보여지는 부분)는 팀원들과 같이 하였으며 상품을 백엔드에서 가져와서 JS로 처리는 제가 했습니다.<br><br>
<img width="909" alt="메인페이지1" src="https://github.com/hsm1020s/D.gaja/assets/111288446/ce2fd0d5-3569-42ac-8fcc-c9485b972547">
<br> 메인페이지 상단 ↑ <br>
<br>
<img width="865" alt="메인페이지2" src="https://github.com/hsm1020s/D.gaja/assets/111288446/fcdec8c2-8450-457f-abf6-08292c086387">
<br> 메인페이지 하단 ↑ <br>
<br>
<img width="919" alt="메인페이지3(관리자)" src="https://github.com/hsm1020s/D.gaja/assets/111288446/a01e1949-c49f-44a2-b55a-c7f0f98e6c35">
<br> 관리자 로그인시 관리자 화면 진입 버튼이 생깁니다. ↑ <br>
<br>
<img width="922" alt="로그인1" src="https://github.com/hsm1020s/D.gaja/assets/111288446/3b9251af-8a08-4e7a-9529-346c27f4901d">
<br> 로그인 화면 ↑ <br>
<br>
<img width="316" alt="회원가입1" src="https://github.com/hsm1020s/D.gaja/assets/111288446/2583207b-b4f0-4999-a214-676cedd87649">
<br> 회원가입 화면 ↑ <br>
<br>
<img width="288" alt="아이디찾기1" src="https://github.com/hsm1020s/D.gaja/assets/111288446/bee7ed57-a139-4102-8d4c-3c7d0345873c">
<br> 아이디찾기 화면 ↑ <br>
<br> 
<img width="253" alt="비번찾기1" src="https://github.com/hsm1020s/D.gaja/assets/111288446/e6c3adce-f1cc-4ec7-adc9-e5d4a9b459ee">
<br> 비밀번호 찾기 화면 ↑ <br>
<br>
<img width="437" alt="정보수정1" src="https://github.com/hsm1020s/D.gaja/assets/111288446/602bd397-feff-421c-826c-f745f5761ea5">
<br> 정보수정 화면 ↑ <br>
<br>
<img width="563" alt="마이페이지1" src="https://github.com/hsm1020s/D.gaja/assets/111288446/48c06307-fda7-4e5a-9439-764d38eb34e7">
<br> 마이페이지 프론트는 팀원이 도와줬습니다. ↑ <br>
<br>
<img width="441" alt="회원탈퇴1" src="https://github.com/hsm1020s/D.gaja/assets/111288446/94f264ff-59ae-4396-8f7e-ef1392cb9d3e">
<br> 회원탈퇴 기능 ↑ <br>
<br>
<img width="542" alt="포인트이력1" src="https://github.com/hsm1020s/D.gaja/assets/111288446/bd7e8e2e-dea2-4fdb-91f2-fcd05feaedab">
<br> 포인트이력 화면 ↑ <br>
<br> 
<img width="602" alt="회원리스트1" src="https://github.com/hsm1020s/D.gaja/assets/111288446/3c8b141a-f6d2-461d-bcb0-45aaa2e588ba">
<br> 회원리스트 화면 ↑ <br>
<br>
<img width="593" alt="회원로그인이력1" src="https://github.com/hsm1020s/D.gaja/assets/111288446/152755b3-eb06-48c0-a1ed-810be511b531">
<br> 회원 로그인 이력 화면 ↑ <br>
<br>
<img width="254" alt="로그인통계1" src="https://github.com/hsm1020s/D.gaja/assets/111288446/31c6dc67-1fcf-4d43-ac19-ef9c93fc46c3">
<br> 회원 로그인 통계 화면 ↑ ( 시간대별 로그인횟수가 DB에 쌓이고 그 정보를 가져와서 일정시간마다 업데이트 시킵니다.) <br>
<br>
<img width="307" alt="상품등록1" src="https://github.com/hsm1020s/D.gaja/assets/111288446/ae8d483a-a5fb-435a-a0e7-17a7fdde49d3">
<br> 상품 등록 화면 ↑ <br>


