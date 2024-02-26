package org.example.controller;

import org.example.dao.CustLoginHistDao;
import org.example.domain.*;
import org.example.service.CustLoginHistService;
import org.example.service.CustStatsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CustHistController { // 이력통계작업 여기서
    CustLoginHistService custLoginHistService; //
    CustLoginHistDao custLoginHistDao; // 임시 테스트용
    @Autowired
    CustStatsService custStatsService;

    public CustHistController(CustLoginHistService custLoginHistService, CustLoginHistDao custLoginHistDao) {
        this.custLoginHistService = custLoginHistService;
        this.custLoginHistDao = custLoginHistDao;
    }

    // 이력작업
    @GetMapping("/loginHist")
    public String loginHist(LoginHistoryDTO loginHistoryDTO, Model m, HttpServletRequest request,
                            @RequestParam(defaultValue = "1") Integer page,
                            @RequestParam(defaultValue = "10") Integer pageSize) throws Exception {

        List<LoginHistoryDTO> loginlist = custLoginHistService.selectAllLoginHist();
        // 회원의 로그인이력 리스트들을 가져온다.
        m.addAttribute("loginlist",loginlist);
        //모델에 로그인이력 리스트 저장

        //---------
        int totalCnt = custLoginHistService.countAllHist();
        //페이지핸들러를 위한 이력 개수 카운트

        m.addAttribute("hist_totalCnt",totalCnt);

        CustPageHandler handler = new CustPageHandler(totalCnt,page,pageSize);

        // map에 offset,pageSize,회원아이디 입력

        Map map = new HashMap();
        map.put("offset", (page-1)*pageSize);
        map.put("pageSize",pageSize);
        List<LoginHistoryDTO> LoginHistoryList = custLoginHistService.selectLoginHistPage(map);
        m.addAttribute("LoginHistoryList",LoginHistoryList);
        m.addAttribute("hist_ph",handler);
        //--------


        return "loginlist"; // 바꿔야함 나중에
    }

    // 통계작업
    @GetMapping("/stats")
    public String selectAllStats(LoginHistoryDTO loginHistoryDTO, Model m) throws Exception {
        List<CustStatsDto> loginstats = custStatsService.selectAllLoginStats();
        // 모든 로그인 정보의 통계를 List로 가져온다. (특정회원아님)
        m.addAttribute("loginstats",loginstats);
        // 모델에 담는다.

        return "stats"; // 나중에 관리자페이지에서 바꿔야함.
    }
}
