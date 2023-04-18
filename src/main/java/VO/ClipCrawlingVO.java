package VO;

//핫클립데이터를 저장할 VO
public class ClipCrawlingVO {
	private String iframeSrc;
    private String strongText;
    private String pText;
	
    public ClipCrawlingVO() {
	}
    
    public ClipCrawlingVO(String iframeSrc, String strongText, String pText) {
		
		this.iframeSrc = iframeSrc;
		this.strongText = strongText;
		this.pText = pText;
	}

	public String getIframeSrc() {
		return iframeSrc;
	}

	public void setIframeSrc(String iframeSrc) {
		this.iframeSrc = iframeSrc;
	}

	public String getStrongText() {
		return strongText;
	}

	public void setStrongText(String strongText) {
		this.strongText = strongText;
	}

	public String getpText() {
		return pText;
	}

	public void setpText(String pText) {
		this.pText = pText;
	}

}
