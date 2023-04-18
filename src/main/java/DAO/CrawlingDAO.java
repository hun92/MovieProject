package DAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import VO.BoxCrawlingVO;
import VO.CrawlingVO;
import VO.ClipCrawlingVO;
import VO.VideoCrawlingVO;
import VO.YoutubeCrawlingVO;



public class CrawlingDAO {
	  //다음 영화 메인화면 데이터 수집
	  String daumRankUrl = "https://movie.daum.net/ranking/reservation";
	  	
	  	//다음 영화 메인화면에서 최신영화 top10 데이터 수집
	  	public List<CrawlingVO> getMainDatas() throws IOException{
			  List<CrawlingVO> mainList = new ArrayList<CrawlingVO>();
			  
			//다음 영화 실시간 예매 순위 1~10위까지 수집 후 각 변수에 저장
			Document daumDoc = Jsoup.connect(daumRankUrl).get();//Jsoup을 사용하여 다음영화 메인화면 데이터수집
			
			//요소별 선택자 사용해 수집한 데이터 변수에 저장
			Elements daumAge = daumDoc.select("div.poster_movie span.txt_tag");
			Elements daumImg = daumDoc.select(".item_poster .poster_movie img");
			Elements daumA = daumDoc.select(".poster_info a:nth-of-type(1)");
			Elements daumTitle = daumDoc.select("strong.tit_item a");
	     	Elements daumScore = daumDoc.select("span.txt_grade");
	     	Elements daumNum = daumDoc.select("span.info_txt span.txt_num");
			Elements daumDate = daumDoc.select("span.txt_info span.txt_num");
	 	      
		      //1~10위까지 이미지는 "src", 문자열은 text로 영화정보 추출 후 각 변수에 저장
		      for (int i = 0; i < 10; i++) {
		    	 CrawlingVO vo = new CrawlingVO();
		        
		    	 String age = daumAge.get(i).text(); // 영화 관람가
	 	         String imgSrc = daumImg.get(i).attr("src"); // 포스터 이미지
		         String dA = daumA.get(i).attr("href");//영화 상세정보링크 
	 	         String title = daumTitle.get(i).text(); // 영화 제목
			     String dScore = daumScore.get(i).text(); // 영화 평점
			     String dNum = daumNum.get(i).text(); //영화 예매율
			     String dDate = daumDate.get(i).text(); //영화 개봉일

			     vo.setAge(age);//vo에 변수저장
		         vo.setImgSrc(imgSrc);
		         vo.setTitle(title);
		         vo.setdScore(dScore);
		         vo.setdNum(dNum);
		         vo.setdDate(dDate);
		         vo.setdA(dA);
		         
		         mainList.add(vo);//List에 가져온 데이터(VO)저장
		      }   
		      return mainList;//크롤링데이터가 담긴 List반환 
	      }
		  
	  	  //박스오피스 2021, 2022, 2023 1,2,3月 데이터 수집
		  public List<BoxCrawlingVO> getBoxDatas(String menuNo) throws IOException{
			  String daumUrl = null;
			  
			  //月,年별로 각각 다른 링크에서 데이터 수집을 위해 if문 사용
			  if(menuNo.equals("2")) {
				  daumUrl = "https://movie.daum.net/ranking/boxoffice/monthly?date=202302";//2月 박스오피스 링크
			  }else if(menuNo.equals("1")) {
				  daumUrl = "https://movie.daum.net/ranking/boxoffice/monthly?date=202301";//1月 박스오피스 링크
			  }else if(menuNo.equals("22")) {
				  daumUrl = "https://movie.daum.net/ranking/boxoffice/yearly?date=2022";//22年 박스오피스 링크
			  }else if(menuNo.equals("21")) {
				  daumUrl = "https://movie.daum.net/ranking/boxoffice/yearly?date=2021";//21年 박스오피스 링크
			  }else if(menuNo.equals("3")) {
				  daumUrl = "https://movie.daum.net/ranking/boxoffice/monthly";//3月 박스오피스 링크
			  }
			  List<BoxCrawlingVO> BoxList = new ArrayList<BoxCrawlingVO>();
			  Document daumDoc = Jsoup.connect(daumUrl).get();//Jsoup을 사용하여 다음영화 박스오피스 데이터수집
			  
			  //요소별 선택자 사용해 수집한 데이터 변수에 저장
			  Elements daumImg = daumDoc.select("div.thumb_item div.poster_movie img");
			  Elements daumAge = daumDoc.select("div.poster_movie span.txt_tag");
			  Elements daumTitle = daumDoc.select("strong.tit_item a");
			  Elements daumDate = daumDoc.select("span.txt_info span.info_txt span.txt_num");
			  Elements daumPeople = daumDoc.select("span.txt_info span.info_txt:nth-of-type(2)");
		      
			  //1~25위까지 이미지는 "src", 문자열은 text로 영화정보 추출 후 각 변수에 저장
		      for (int i = 0; i < 25; i++) {
		    	 BoxCrawlingVO vo = new BoxCrawlingVO();
		         	String imgSrc = daumImg.get(i).attr("src"); // 포스터 이미지
		    		String age = daumAge.get(i).text(); // 영화 관람가
		    	 	String title = daumTitle.get(i).text(); // 영화 제목
		    	    String dDate = daumDate.get(i).text(); //영화 개봉일
		    		String people = daumPeople.get(i).text(); //영화 관객수

		    	 vo.setImgSrc(imgSrc);//vo에 변수저장
		         vo.setAge(age);
		    	 vo.setTitle(title);
		         vo.setdDate(dDate);
		         vo.setPeople(people);
		         
		         BoxList.add(vo);//List에 데이터(VO)저장
		      }   
		      return BoxList;//크롤링데이터가 담긴 List반환
	      }
		  
		  //네이버 영화 저장소에서 예고편 20편 수집
		  public List<VideoCrawlingVO> getVideoDatas() throws IOException{
			    //네이버 영화 저장소 메인화면 데이터 수집
				String videoUrl = "https://tv.naver.com/navermovie/clips";
					    List<VideoCrawlingVO> videoList = new ArrayList<VideoCrawlingVO>();
					  
					    Document videoDoc = Jsoup.connect(videoUrl).get();//Jsoup을 사용하여 예고편 데이터수집
					    
					    //요소별 선택자를 사용해 수집한 데이터 변수에 저장
						Elements videoImg = videoDoc.select("a.cds_thm img");
						Elements videoTitle = videoDoc.select("dt.title a");
						Elements videoPlayCnt = videoDoc.select("dd.meta span.hit");
						Elements videoLike = videoDoc.select("dd.meta span.like");
						Elements videoUpload = videoDoc.select("dd.meta span.time");
						Elements videoSrc = videoDoc.select("div.cds_type dl.cds_info a");//링크맞지않아수정 4.5 재봉
						
						//예고편 20편 이미지는 "src", 문자열은 text, 링크는 "href"로 영상정보 추출 후 각 변수에 저장
						for (int i = 0; i < 20; i++) {
							VideoCrawlingVO vo = new VideoCrawlingVO();
				    	 	String imgSrc = videoImg.get(i).attr("src");//포스터 이미지
				    		String title = videoTitle.get(i).text();//영화 제목
				    		String playCnt = videoPlayCnt.get(i).text();//재생 수
				    		String like = videoLike.get(i).text();//좋아요 수
				    		String upload = videoUpload.get(i).text();//업로드 날짜
				    	    String src = videoSrc.get(i).attr("href");//영상 시청 링크
				    	 
				    	 //vo에 변수저장   
				    	 vo.setImgSrc(imgSrc);
				         vo.setTitle(title);
				         vo.setPlayCnt(playCnt);
				         vo.setSrc(src);
				         vo.setLike(like);
				         vo.setUpload(upload);
				         
				         videoList.add(vo);//List에 데이터(VO)저장
						 }   
				      return videoList;//크롤링데이터가 담긴 List반환
			      }
		  
		  //다음 영화 검색창에서 장르별 영화 데이터 수집
		  public List<YoutubeCrawlingVO> getYoutubeDatas() throws IOException{
			  
			  			List<YoutubeCrawlingVO> youtubeList = new ArrayList<YoutubeCrawlingVO>();
			  			int i = 0;
			  			
			  			//장르별 영상을 가져오기 위해 배열에 담아 저장 
			  			String youtubeUrl[] =  {"https://search.daum.net/search?nil_suggest=btn&w=vclip&m=vclip&q=%EC%95%A1%EC%85%98+%EC%98%81%ED%99%94&play_time_ge=300&cp=youtube-video&play_time_le=600&DA=STC&p=1",
					 		 	  				"https://search.daum.net/search?nil_suggest=btn&w=vclip&m=vclip&q=%EA%B3%B5%ED%8F%AC+%EC%98%81%ED%99%94&play_time_ge=300&play_time_le=600&DA=STC&cp=youtube-video&p=1",
					 		 	  				"https://search.daum.net/search?nil_suggest=btn&w=vclip&m=vclip&q=%ED%8C%90%ED%83%80%EC%A7%80+%EC%98%81%ED%99%94&play_time_ge=600&DA=STC&cp=youtube-video&p=1",
					 		 	  				"https://search.daum.net/search?nil_suggest=btn&w=vclip&m=vclip&q=%EB%A1%9C%EB%A7%A8%EC%8A%A4+%EC%98%81%ED%99%94&play_time_ge=300&play_time_le=600&DA=STC&cp=youtube-video&p=1",
					 		 	  				"https://search.daum.net/search?nil_suggest=btn&w=vclip&q=%EC%8A%A4%EB%A6%B4%EB%9F%AC+%EC%98%81%ED%99%94+%EB%A6%AC%EB%B7%B0&period=m&sd=20230310160451&ed=20230410160451&play_time_ge=600&cp=youtube-video"
												};
			  			
			  			for(String s : youtubeUrl) {
			  			 	
			  			Document youtubeDoc = Jsoup.connect(s).get();//Jsoup을 사용해 장르별로 영상데이터 수집
			  					
			  			Elements youtubeImg = youtubeDoc.select("div.wrap_thumb img");
			  			Elements youtubeA = youtubeDoc.select("div.wrap_thumb a");
			  			Elements youtubeTitle = youtubeDoc.select("div.wrap_tit a");
			  			
						//장르별 영상 5편 이미지는 "src", 문자열은 text, 링크는 "href"로 영상정보 추출 후 각 변수에 저장
			  			for (i = 0; i < 5; i++) {
							YoutubeCrawlingVO vo = new YoutubeCrawlingVO();
							String imgSrc = youtubeImg.get(i).attr("src");//영화 이미지
							String href = youtubeA.get(i).attr("href");//유튜브 링크
							String title = youtubeTitle.get(i).text();//영상 제목
						
						 //vo에 변수저장	
				    	 vo.setImgSrc(imgSrc);
				         vo.setTitle(title);
				         vo.setHref(href);
				         
				         youtubeList.add(vo);//List에 데이터(VO)저장
						 } 
			  			}
				      return youtubeList;//크롤링데이터가 담긴 List반환
				      
			      }
		  
		  //셀레니움을 이용한 다음영화 메인화면 핫클립 데이터 수집
		  public List<ClipCrawlingVO> getMainClipDatas() throws IOException{
			  	List<ClipCrawlingVO> clipList = new ArrayList<ClipCrawlingVO>();
			  //Selenium과 Chrome 브라우저를 사용하여 웹 페이지를 엽니다
			   
			   //Web Driver 압축 해제 경로 입력
			   System.setProperty("webdriver.chrome.driver", "C:\\selenium\\chromedriver.exe");
			   
			   ChromeOptions options = new ChromeOptions();//크롤링 시 속도향상을 위해 옵션기능 사용
			  
			   options.addArguments("--headless");//브라우저 창 띄우지 않음
			   options.addArguments("--disable-gpu");//gpu 비활성화
			   options.addArguments("--no-sandbox");//리눅스 환경에서 권한 문제를 해결하기 위해 추가
			   options.addArguments("--disable-dev-shm-usage");//리눅스 환경에서 메모리 부족 문제를 해결하기 위해 추가
			   options.addArguments("--disable-popup-blocking");//팝업 창 띄우지 않음  
		       options.addArguments("--disable-defult-apps"); //기본앱 사용하지 않음
		       options.addArguments("--blink-settings=imagesEnabled=false");//이미지 다운받지 않음
		       options.addArguments("--disable-infobars");//경고 메세지 비활성화 
		       options.addArguments("--disable-extensions");//브라우저 확장기능 비활성화 
		       options.addArguments("--disable-notifications");//알림 비활성화
		       options.addArguments("--mute-audio");//브라우저 음소거  
		       options.addArguments("--start-maximized");//브라우저 창 최대화 
		       options.addArguments("--disable-plugins");//브라우저 플러그인 비활성화 
		       
		       WebDriver driver = new ChromeDriver(options);
			   
			   driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS); //암묵적 대기시간 10초 설정
			   driver.manage().timeouts().pageLoadTimeout(10, TimeUnit.SECONDS); //페이지로딩대기시간 10초 설정
			   driver.get("https://movie.daum.net/main");
			   
			   //요소별 선택자를 사용하여 핫클립 데이터 수집
		       WebElement playerContainer = driver.findElement(By.className("player_container"));
		       WebElement iframe = playerContainer.findElement(By.tagName("iframe"));
		       WebElement activeLi = driver.findElement(By.className("movie_visual"));
		       WebElement strongTag = activeLi.findElement(By.tagName("strong"));
		       WebElement pTag = activeLi.findElement(By.tagName("p"));

		       ClipCrawlingVO vo = new ClipCrawlingVO();
			
		       //핫클립데이터 iframe은 "src", 문자열은 text로 영상정보 추출 후 각 변수에 저장
		       String iframeSrc = iframe.getAttribute("src");//핫클립 영상 
		       String strongText = strongTag.getText();//핫클립 제목
		       String pText = pTag.getText();//영상소개
		       
		       //vo에 저장
		       vo.setIframeSrc(iframeSrc);
		       vo.setpText(pText);
		       vo.setStrongText(strongText);
		       
		       clipList.add(vo);//List에 데이터(VO)저장
		       driver.quit();//브라우저 종료
		       
		       return clipList;//크롤링데이터가 담긴 List반환
		  }
	}
	










