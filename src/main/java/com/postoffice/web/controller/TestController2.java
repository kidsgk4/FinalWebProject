package com.postoffice.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController2 {

	
	@RequestMapping("/maps")
	public String maps() {
		return "maps";
	}
	
	@RequestMapping("/maps2")
	public String maps2() {
		return "maps2";
	}
	@RequestMapping("/maps3")
	public String maps3() {
		return "maps3";
	}
}
