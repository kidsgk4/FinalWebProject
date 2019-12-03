package com.postoffice.web.dto;

public class BoardDTO {
	private int bid;
	private String btitle;
	private String bcontent;
	private String battachfile;
	private String bdate;
	private String vid;

	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public String getBtitle() {
		return btitle;
	}
	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}
	public String getBcontent() {
		return bcontent;
	}
	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}
	public String getBattachfile() {
		return battachfile;
	}
	public void setBattachfile(String battachfile) {
		this.battachfile = battachfile;
	}
	public String getBdate() {
		return bdate;
	}
	public void setBdate(String bdate) {
		this.bdate = bdate;
	}
	public String getVid() {
		return vid;
	}
	public void setVid(String vid) {
		this.vid = vid;
	}
}
