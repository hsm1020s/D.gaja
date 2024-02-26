package org.example.service;

import org.example.domain.CustDto;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Map;

public interface CustService {
    List<CustDto> getCustList() throws Exception;

    String findCustId(CustDto custDto) throws Exception; // 회원아이디 찾아주기

    CustDto loginCust(String id) throws Exception;
    int registerCust(CustDto custDto) throws Exception;

    CustDto modifyselect(String id) throws Exception;

    int withdrawal(String id) throws Exception; // 탈퇴

    CustDto temporaryPwd(CustDto custDto) throws Exception; //임시비밀번호 발급해주기

    int temporaryPwdReturn(CustDto custDto) throws Exception;
    //임시 비밀번호 발급시 db에 업데이트 쳐주는거
    int custSms(CustDto custDto)throws Exception;

    List<CustDto> CustPage(Map map) throws Exception;
}
