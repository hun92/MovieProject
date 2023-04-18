package DAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import VO.BoxCrawlingVO;
import VO.CrawlingVO;



public class BoxCrawlingDAO {
	 			
	/*
	 * public List<BoxCrawlingVO> getBoxDatas(String menuNo) throws IOException{
	 * String daumUrl = null; if(menuNo.equals("2")) { daumUrl =
	 * "https://movie.daum.net/ranking/boxoffice/monthly?date=202302"; }else
	 * if(menuNo.equals("1")) { daumUrl =
	 * "https://movie.daum.net/ranking/boxoffice/monthly?date=202301"; }else
	 * if(menuNo.equals("22")) { daumUrl =
	 * "https://movie.daum.net/ranking/boxoffice/yearly?date=2022"; }else
	 * if(menuNo.equals("21")) { daumUrl =
	 * "https://movie.daum.net/ranking/boxoffice/yearly?date=2021"; }
	 * List<BoxCrawlingVO> BoxList = new ArrayList<BoxCrawlingVO>(); Document
	 * daumDoc = Jsoup.connect(daumUrl).get(); Elements daumImg =
	 * daumDoc.select("div.thumb_item div.poster_movie img"); Elements daumAge =
	 * daumDoc.select("div.poster_movie span.txt_tag"); Elements daumTitle =
	 * daumDoc.select("strong.tit_item a"); Elements daumDate =
	 * daumDoc.select("span.txt_info span.info_txt span.txt_num"); Elements
	 * daumPeople = daumDoc.select("span.txt_info span.info_txt:nth-of-type(2)");
	 * 
	 * for (int i = 0; i < 25; i++) { BoxCrawlingVO vo = new BoxCrawlingVO(); String
	 * imgSrc = daumImg.get(i).attr("src"); // 포스터 이미지 String age =
	 * daumAge.get(i).text(); // 영화 관람가 String title = daumTitle.get(i).text(); //
	 * 영화 제목 String dDate = daumDate.get(i).text(); //영화 개봉일 String people =
	 * daumPeople.get(i).text(); //영화 관객수
	 * 
	 * vo.setImgSrc(imgSrc); vo.setAge(age); vo.setTitle(title); vo.setdDate(dDate);
	 * vo.setPeople(people);
	 * 
	 * BoxList.add(vo); } return BoxList; }
	 */
		  
		 
		  
	}
	










