package VO;

//박스오피스 데이터를 저장할 VO
public class BoxCrawlingVO {
	private String imgSrc; // 포스터 이미지
	private String age; // 영화 관람가
	private String title; // 영화 제목
	private String dDate; //영화 개봉일
	private String people; //영화 관객수

	public BoxCrawlingVO() {
	
	}

	public BoxCrawlingVO(String imgSrc, String age, String title, String dDate, String people) {
		this.imgSrc = imgSrc;
		this.age = age;
		this.title = title;
		this.dDate = dDate;
		this.people = people;
	}
	
	public BoxCrawlingVO(String age, String title, String dDate, String people) {
		this.age = age;
		this.title = title;
		this.dDate = dDate;
		this.people = people;
	}

	public String getImgSrc() {
		return imgSrc;
	}

	public void setImgSrc(String imgSrc) {
		this.imgSrc = imgSrc;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getdDate() {
		return dDate;
	}

	public void setdDate(String dDate) {
		this.dDate = dDate;
	}

	public String getPeople() {
		return people;
	}

	public void setPeople(String people) {
		this.people = people;
	}
	
	
}