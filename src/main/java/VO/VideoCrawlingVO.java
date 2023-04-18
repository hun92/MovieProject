package VO;

//예고편 크롤링데이터를 저장할 VO
public class VideoCrawlingVO {
	private String imgSrc; 
	private String title; 
	private String playCnt , src;
	private String like;
	private String upload;
	
	 public VideoCrawlingVO() {
	
	 }

	public VideoCrawlingVO(String imgSrc, String title) {
		this.imgSrc = imgSrc;
		this.title = title;
	}

	public VideoCrawlingVO(String imgSrc, String title, String playCnt) {
		this.imgSrc = imgSrc;
		this.title = title;
		this.playCnt = playCnt;
	}

	public VideoCrawlingVO(String imgSrc, String title, String playCnt, String src, String like, String upload) {
		this.imgSrc = imgSrc;
		this.title = title;
		this.playCnt = playCnt;
		this.src = src;
		this.like = like;
		this.upload = upload;
	}

	public String getUpload() {
		return upload;
	}

	public void setUpload(String upload) {
		this.upload = upload;
	}

	public String getImgSrc() {
		return imgSrc;
	}

	public void setImgSrc(String imgSrc) {
		this.imgSrc = imgSrc;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPlayCnt() {
		return playCnt;
	}

	public void setPlayCnt(String playCnt) {
		this.playCnt = playCnt;
	}

	public String getSrc() {
		return src;
	}

	public void setSrc(String src) {
		this.src = src;
	}

	public String getLike() {
		return like;
	}

	public void setLike(String like) {
		this.like = like;
	}
    
}