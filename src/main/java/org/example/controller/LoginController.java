package org.example.controller;

import org.checkerframework.checker.units.qual.A;
import org.example.dao.*;
import org.example.domain.*;
import org.example.service.CustLoginHistService;
import org.example.service.CustService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.time.LocalDateTime;

@Controller
@RequestMapping("/login")
public class LoginController {
    CustDao custDao;
    CustService custService;
    CustLoginHistService custLoginHistService;
    @Autowired
    private JavaMailSender mailSender;
    public LoginController(CustDao custDao, CustService custService, CustLoginHistService custLoginHistService) {
        this.custDao = custDao;
        this.custService = custService;
        this.custLoginHistService = custLoginHistService;
    }

    @GetMapping("/findId")
    public String findidget() {
        return "findId";
        //아이디 찾기 화면을 불러온다.
    }

    @PostMapping("/findid")// id를찾을때
    public String findidpost(Model m, String name, String email,String mpNo) throws Exception {
        CustDto custDto = new CustDto();
        // 프론트에서 입력받은 내용을 custDto를 만들고 저장해준다.
        custDto.setName(name);
        custDto.setEmail(email);
        custDto.setMpNo(mpNo);

        //이름,이메일,전화번호를 주면 해당하는 id를 반환한다.
        String resultid = custService.findCustId(custDto);
        // 해당하는 id 찾아냈음

        m.addAttribute("findidresult", resultid); // 모델에 찾은 아이디 담음
        return "findidresult"; //현재는 찾은 아이디를 보여주지만 경로를 수정해야할듯.
    }

    @GetMapping("/findPwd")
    public String findPwd(String findid,Model m) {
        m.addAttribute("findid",findid);
        return "findPwd";
        // 회원의 비밀번호찾기 화면을 보여준다.
    }

    @PostMapping("/findPwd")
    public String findPwdReturn(String custId, String name, String email, String mpNo
                                ) throws Exception {
        //String toURL 추가

        CustDto custDto = new CustDto();
        custDto.setCustId(custId);
        custDto.setName(name);
        custDto.setEmail(email);
        custDto.setMpNo(mpNo);
        //아이디,이름,이메일,핸드폰번호 입력해주고 서비스 호출하면
        custDto = custService.temporaryPwd(custDto);
        //해당 정보를 가지고있는 dto 반환한다.

        SecureRandom random = new SecureRandom();
        String password = new BigInteger(50, random).toString(32);
        // 랜덤 문자열 생성
        password = password.substring(0, 5); // 문자열에서 앞쪽 5자만 잘라냄
        password += custDto.getMpNo().substring(custDto.getMpNo().length() - 2);
        // 핸드폰번호에서 2개 잘라냄
        password += custDto.getEmail().substring(0, 2);
        // 이메일에서 2개 잘라냄
        custDto.setPwd(password);
        // password dto에 저장

        custService.temporaryPwdReturn(custDto);// 보내기전에 비밀번호를 업데이트해준다.
        String subject = "비밀번호를 보내드립니다";

        String content = "비밀번호는 " + password + "입니다. "; //위에 패스워드 흰색떠도 괜찮음 여기서 사용함.
        String from = "hsm1020ss@naver.com";
        String to = " "+email; //실제이메일로 가자

        try {
            MimeMessage mail = mailSender.createMimeMessage();
            MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
            mailHelper.setFrom(from);
            mailHelper.setTo(to);
            mailHelper.setSubject(subject);
            mailHelper.setText(content, true);
            mailSender.send(mail);
        } catch (Exception e) {
            e.printStackTrace();
        }

//        String toURL = "/"; // localhost:8080으로 가기위해 toURL을 "/"로 설정
//        return "redirect:" + toURL;

        return "findPwdresult"; // 0802 수정완료
    }


    @GetMapping("/login")
    public String loginForm() {
        return "login";
        //로그인화면을 띄워준다.
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 종료
        return "redirect:/"; // 홈 이동
    }

    @PostMapping("/login")
    public String login(Model m, String id, String pwd, String toURL, boolean rememberId,
                        HttpServletRequest request, HttpServletResponse response,
                        RedirectAttributes attr) throws Exception {
        LoginHistoryDTO loginHistoryDTO = new LoginHistoryDTO();

        // 로그인이력에 국가 넣을떄 ko,en-US;q=0.9,en;q=0.8,ko-KR;q=0.7
        // 이렇게 긴 코드가 들어가는데, 맨 앞자리 2개만 추출해서 저장하는 코드
        loginHistNationCodeSetting(request, loginHistoryDTO);

        //사용자기기 추출 메서드
        deviceExtract(m, request, loginHistoryDTO);

        loginHistoryDTO.setCustId(id); // 아이디
        loginHistoryDTO.setDttm(LocalDateTime.now()); // 발생시간
        loginHistoryDTO.setIp(request.getRemoteAddr()); //IP 로컬일때는 0 0 0 0 임


        // 이거 지우면 안됌
//        if (custLoginHistService.HistCountSelect(id).getFailCnt()>=3){
//            // 비밀번호가 3회이상 틀렸습니다. 창 나오게 하기
//            String histmsg = URLEncoder.encode("비밀번호가 3회이상 틀렸습니다.", "utf-8");
//
//            return "redirect:/login/login?msg=" + histmsg;
//        } // 이거 잘못하니까 널포인터익셉션

        try {
            if (!loginCheck(id, pwd)) {//  id와 pwd를 확인
                // 일치하지 않으면, loginForm으로 이동
                String msg = URLEncoder.encode("id 또는 pwd가 일치하지 않습니다.", "utf-8");
                loginHistoryDTO.setScssYn("N"); // 로그인여부

                // 기존의 아이디의 최신 날짜의 정보를 가져와서 카운트를 확인하고
                // 그 카운트를 증가시켜줘야한다.
                loginHistoryDTO.setFailCnt(custLoginHistService.HistCountSelect(id).getFailCnt()+1);
                // 틀리면서 예외터질때도 예외처리해야함.
                return "redirect:/login/login?msg=" + msg;
            }
            // id와 pwd가 일치하면
            HttpSession session = request.getSession();//  세션 객체를 얻기
            session.setAttribute("id", id);//  id 저장

            if (rememberId) {
                Cookie cookie = new Cookie("id", id); // 쿠키 생성
                response.addCookie(cookie); //응답에 저장
            } else {
                Cookie cookie = new Cookie("id", id); // 쿠키 삭제
                cookie.setMaxAge(0); // 쿠키 삭제
                response.addCookie(cookie); //응답에 저장
            }
            toURL = toURL == null || toURL.equals("") ? "/" : toURL;


            // 아이디 비번이 어드민이 맞는지 확인
            if (adminCHeck(id)) { // 어드민일경우
                //m.addAttribute("loginAdminTrue", true);
                attr.addFlashAttribute("loginAdminTrue", true);
                //리다이렉트여도 값이 유지된다.

                loginHistoryDTO.setScssYn("Y"); // 로그인 성공시 db에 성공여부 Y로 나옴
                toURL = "/"; // localhost:8080으로 가기위해 toURL을 "/"로 설정
                return "redirect:" + toURL;
                //어드민일경우 바로 리턴하면 이력에 Y가 쌓이지 않아서 그냥 return 주석처리 했으나
                // 그럴경우 관리자페이지가 등장하지 않는 에러 있음 - 0807해결
                //홈페이지 새로고침할때마다 관리자 체크해주는 기능 필요
            }
            loginHistoryDTO.setScssYn("Y"); // 로그인 성공시 db에 성공여부 Y로 나옴

            return "redirect:" + toURL;
        } catch (Exception e) {
            loginHistoryDTO.setScssYn("N"); // 로그인 실패로 N으로 나옴
            loginHistoryDTO.setFailCaus(e.getMessage()); // 메세지저장
            loginHistoryDTO.setFailCnt(custLoginHistService.HistCountSelect(id).getFailCnt()+1); // 실패카운트 +1
            e.printStackTrace();
            System.out.println("e.getMessage() = " + e.getMessage());
            return "error";
        }finally {
            custLoginHistService.LoginHistInsert(loginHistoryDTO); // 제일마지막에 이력 저장
        }
    }

    private static void deviceExtract(Model m, HttpServletRequest request, LoginHistoryDTO loginHistoryDTO) {
        String device = request.getHeader("User-Agent");
        String userDevice ="";
        if (device != null && !device.isEmpty()) {
            int startIndex = device.indexOf('(');
            int endIndex = device.indexOf(')');
            if (startIndex != -1 && endIndex != -1 && startIndex < endIndex) {
                userDevice = device.substring(startIndex + 1, endIndex);
                loginHistoryDTO.setMhrLS(userDevice); // 기기(기계) 추론
            }
            // 사용자 로그인기기가 윈도우 또는 맥일때 대비해서 모델에 저장 메서드
            deviceCheck(m, userDevice);

        }
    }

    private static void loginHistNationCodeSetting(HttpServletRequest request, LoginHistoryDTO loginHistoryDTO) {
        String acceptLanguage = request.getHeader("Accept-Language");
        if (acceptLanguage != null && !acceptLanguage.isEmpty()) {
            String[] languages = acceptLanguage.split(",");
            if (languages.length > 0) {
                String firstLanguage = languages[0];
                if (firstLanguage.length() >= 2) {
                    String firstTwoChars = firstLanguage.substring(0, 2);
                    loginHistoryDTO.setNatn(firstTwoChars);
                }
            }
        }
    }

    private static void deviceCheck(Model m, String userDevice) {
        if(userDevice.contains("Windows")){
            m.addAttribute("Windows","Windows");
        } else if (userDevice.contains("Macintosh")) {
            m.addAttribute("Macintosh","Macintosh");
        }
    }

    @GetMapping("/logoClick")
        public String handleLogoClick(Model m,HttpServletRequest request) throws Exception {
        //현재 아이디를 가져와서 서비스로 타입조회 맞을시 모델에 저장 해야함
            HttpSession session = request.getSession();
            if(adminCHeck((String) session.getAttribute("id")))
            m.addAttribute("loginAdminTrue", true);
            return "forward:/";
        }

    private boolean loginCheck(String id, String pwd) {
        CustDto user = null;
        try {
             user = custService.loginCust(id);  //user = custDao.selectUser(id);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        return user != null && user.getPwd().equals(pwd);
    }
    private boolean adminCHeck(String id) throws Exception {
        // db의 회원타입이 2일 경우에 관리자이다.
        String tp = "2";
        CustDto dto = custService.loginCust(id);
        System.out.println("dto.getCustTp() = " + dto.getCustTp());
        return dto.getCustTp().equals(tp);
    }
}