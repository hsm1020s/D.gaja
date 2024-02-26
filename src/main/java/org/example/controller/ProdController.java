package org.example.controller;

import org.example.domain.NotcPageHandler;
import org.example.domain.NotcSearchCondition;
import org.example.domain.ProdDto;
import org.example.domain.*;

import org.example.service.ProdImgService;
import org.example.service.ProdOptService;

import org.example.service.ProdService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.*;

import java.util.List;

@Controller
@RequestMapping("/prod")
public class ProdController {
    ProdService prodService;
    ProdImgService prodImgService;
    ProdOptService prodOptService;
    public ProdController(ProdService prodService, ProdImgService prodImgService, ProdOptService prodOptService){
        this.prodService = prodService;
        this.prodImgService = prodImgService;
        this.prodOptService = prodOptService;
    }
    private static String CURR_IMAGE_REPO_PATH = "C:\\Users\\huis9\\D.gaja\\src\\main\\webapp\\resources\\img";

    @GetMapping("/register")
    public String prodregisterGET(Model m) throws Exception{
        return "prodRegister";
    }

    @PostMapping("/register")
    public String prodregisterPost(@ModelAttribute ProdDto prodDto, String cateName,
                                   MultipartHttpServletRequest multipartRequest,
                                   HttpServletResponse response,Model m ,String loginWin, String loginMac ) throws Exception{
        if(loginMac=="Macintosh"){
            // CURR_IMAGE_REPO_PATH = "C:\\Users\\huis9\\D.gaja\\src\\main\\webapp\\resources\\img";
            // 맥 경로 넣기 예시 (위에는 윈도우 예시) 주석 활성화해서 코딩
             CURR_IMAGE_REPO_PATH = "/Users/khw4465/myGit/D.gaja/src/main/webapp/resources/img";
        }
        //파일업로드
        multipartRequest.setCharacterEncoding("utf-8");
        Map map = new HashMap();
        Enumeration enu = multipartRequest.getParameterNames();
        while(enu.hasMoreElements()){
            String name=(String)enu.nextElement();
            String value=multipartRequest.getParameter(name);
            // System.out.println(name+", "+value);
            map.put(name,value);
        }
        ///prodDTO관련
        //파일이름이 저장된 리스트임
        List fileList = fileProcess((MultipartHttpServletRequest) multipartRequest);
        map.put("fileList", fileList);
        //fileList 첫번째꺼를 prodDto.set대표이미지 해주고
        prodDto.setProdImgName((String) fileList.get(0)); // githist.png
         // prod_cd 가져와서 set 대표이미지경로
        prodDto.setProdImg("img/"+prodDto.getProdCd()); // 대표이미지
        ///prodDTO관련

        //prod테이블에 insert 로직 작성 0806
        prodDto.setFstRegr("admin"); // 세션으로 아이디체크 나중에 바꿔야함
        prodService.productRegister(prodDto);

        //prodOpt테이블에 insert 로직 작성 0806
        //ProdOptDto prodOptDto = new ProdOptDto();
        //System.out.println(prodOptDto);

        // 확장자 자를 스트링
        // 나머지를 img서비스 호출해서 다 하나씩 넣어줄거임.
        for (int i = 1; i < fileList.size(); i++) {
            String filename = (String) fileList.get(i); // 파일이름 스트링 받을 변수
            String ext=""; //확장자 자를 코드

            //파일의 가로, 세로 크기를 가져옵니다.
            String width = multipartRequest.getParameter("imgWidth" + (i+1));
            String height = multipartRequest.getParameter("imgHeight" + (i+1));

            int j = filename.lastIndexOf('.');
            if(j>=0){
                ext=filename.substring(j+1);
            }

            ProdImgDto prodImgDto = new ProdImgDto();
            prodImgDto.setProdCd(prodDto.getProdCd()); //prod_cd 컬럼
            prodImgDto.setImgCd("0"+i);
            prodImgDto.setImgType("추");
            prodImgDto.setImgPath("/img/"+prodDto.getProdCd()+"_"+i);
            prodImgDto.setImgExtns(ext); //확장자 분리저장
            prodImgDto.setImgWidth(Integer.valueOf(width));
            prodImgDto.setImgHeight(Integer.valueOf(height));
            // 이미지의 가로, 세로 크기를 ProdImgDto에 저장하는 코드
            prodImgService.productImgRegister(prodImgDto);
        }

        m.addAttribute("map", map);  // ModelAndView에서 addObject를 사용한 것과 동일한 역할

        //return "result";  // 뷰 이름을 문자열로 직접 반환

        String a = cateName; //카테고리
        String b = prodDto.getProdName(); //그린맛
        StringBuilder sb = new StringBuilder(a);
        sb.append(" "+" ");
        sb.append(b);
        String c = sb.toString(); // "카테고리+입력한이름명 들어감"

        prodDto.setProdName(c);
        //prodService.productRegister(prodDto); //prod 테이블에는 들어감
        // 이미지테이블에 들어온 개수만큼 하나씩 쌓아야함.

        String toURL = "/admin";
        return "redirect:" + toURL;
    }
    @RequestMapping("/download")
    public void download(@RequestParam("imageFileName") String imageFileName,
                         HttpServletResponse response) throws Exception {
        OutputStream out = response.getOutputStream();
        String downFile = CURR_IMAGE_REPO_PATH + "\\" + imageFileName;
        File file = new File(downFile);

        response.setHeader("Cache-Control", "no-cache");
        response.addHeader("Content-disposition", "attachment; fileName=" + imageFileName);
        FileInputStream in = new FileInputStream(file);
        byte[] buffer = new byte[1024 * 8];
        while (true) {
            int count = in.read(buffer); // 버퍼에 읽어들인 문자개수
            if (count == -1) // 버퍼의 마지막에 도달했는지 체크
                break;
            out.write(buffer, 0, count);
        }
        in.close();
        out.close();
        //다운로드가 필요없긴할듯 아니면 나중에 파일 보여줄곳이 필요할떄 보여주면되겠다.
    }

    @GetMapping("/detail/{prodCd}")     //  테스트용 데이터는 P010202
    public String prodDetail(@PathVariable String prodCd, Model m) {
        try {
            ProdDto prodDto = prodService.getProdDetail(prodCd);            // 상품의 정보들을 담은 dto
            m.addAttribute("prodDto", prodDto);

            List<ProdImgDto> imgList = prodImgService.getAllImg(prodCd);    // 한 상품에 대한 이미지dto 리스트
            m.addAttribute("imgList", imgList);

            List<ProdOptDto> optList = prodOptService.getOptList(prodCd);   // 한 상품에 대한 옵션dto 리스트
            m.addAttribute("optList", optList);

            List<Integer> optListValue = new ArrayList<Integer>();
            for (ProdOptDto prodOptDto : optList) {
                optListValue.add(prodOptDto.getSalePrc());
            }
            m.addAttribute("optListValue",optListValue);


        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "prodDetail";
    }

    @GetMapping("/search")
    public String search(Model m, ProdSearchCondition psc) {

        try{
//            int totalCnt = prodService.getprodCount(psc);
//            m.addAttribute("totalCnt",totalCnt);
        ProdSearchHandler PageHandler = new ProdSearchHandler(psc);
            List<ProdDto> list = prodService.getprodSearchResult(psc);
            m.addAttribute("list",list);
        m.addAttribute("PageHandler",PageHandler);

        } catch (Exception e){
            e.printStackTrace();
            m.addAttribute("msg","SEARRCH_ERR");
            m.addAttribute("totalCnt",0);
        }


        return "prodsearch";
//        return "index";
    }

    private List<String> fileProcess(MultipartHttpServletRequest multipartRequest) throws Exception{
        List<String> fileList= new ArrayList<String>();
        Iterator<String> fileNames = multipartRequest.getFileNames();
        while(fileNames.hasNext()){
            String fileName = fileNames.next();
            MultipartFile mFile = multipartRequest.getFile(fileName);
            String originalFileName=mFile.getOriginalFilename();
            fileList.add(originalFileName);
            File file = new File(CURR_IMAGE_REPO_PATH +"\\"+ fileName);
            if(mFile.getSize()!=0){ //File Null Check
                if(! file.exists()){ //경로상에 파일이 존재하지 않을 경우
                    if(file.getParentFile().mkdirs()){ //경로에 해당하는 디렉토리들을 생성
                        file.createNewFile(); //이후 파일 생성
                    }
                }
                mFile.transferTo(new File(CURR_IMAGE_REPO_PATH +"\\"+ originalFileName)); //임시로 저장된 multipartFile을 실제 파일로 전송
            }
        }
        return fileList;
    }
}
