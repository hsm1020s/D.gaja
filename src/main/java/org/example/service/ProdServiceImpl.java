package org.example.service;

import org.example.dao.*;
import org.example.domain.ProdDto;
import org.example.domain.ProdSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ProdServiceImpl implements ProdService {

    private final ProdDao prodDao;
    private final ProdCateDao prodCateDao;
    private final ProdDcDao prodDcDao;
    private final ProdOptDao prodOptDao;
    private final ProdImgDao prodImgDao;

    @Autowired
    public ProdServiceImpl(ProdDao prodDao, ProdCateDao prodCateDao, ProdDcDao prodDcDao, ProdOptDao prodOptDao, ProdImgDao prodImgDao) {
        this.prodDao = prodDao;
        this.prodCateDao = prodCateDao;
        this.prodDcDao = prodDcDao;
        this.prodOptDao = prodOptDao;
        this.prodImgDao = prodImgDao;
    }
    // 생성자주입
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int productRegister(ProdDto prodDto) throws Exception {
        // 각 DAO를 사용하여 ProdDto에 필요한 정보를 가져온 후 prodDto에 설정

        // prodDto.setCateCd(prodCateDao.select(1).getCateCd());
        // prodcate 테이블의 cate_cd 가져와서
        // prod 의 cate_cd에 저장


        // 모든 정보가 설정된 후 prodDao를 사용하여 DB에 저장
        return prodDao.insert(prodDto);
    }

    @Override
    public ProdDto getProdDetail(String prodCd) throws Exception {
        return prodDao.select(prodCd);
    }

    // 상품 검색에 사용 하는 메서드
    @Override
    public List<ProdDto> getprodSearchResult(ProdSearchCondition psc) throws Exception{
        return prodDao.prodSearch(psc);
    }


}
