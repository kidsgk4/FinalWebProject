package com.postoffice.web.controller;

import org.json.JSONArray;
import org.json.JSONObject;

public class test {

	public static void main(String[] args) {
		JSONObject jsonObject = new JSONObject();
		JSONArray ja = new JSONArray();
		String te = "[{\"x\":37.5475233,\"y\":127.1199873,\"z\":0,\"param3\":0,\"param4\":0,\"seq\":0,\"command\":16,\"param1\":0,\"param2\":0},{\"x\":37.5479492,\"y\":127.120244,\"z\":10,\"param3\":0,\"param4\":0,\"seq\":1,\"command\":16,\"param1\":0,\"param2\":0}]";
		JSONArray jsonArray = new JSONArray(te);
		System.out.println(jsonArray);
		JSONObject jo = null;
		for(int i = 0; i < jsonArray.length(); i++) {
			jo = jsonArray.getJSONObject(i);
			System.out.println("trest : " +jo);
			
			String x = jo.get("x").toString();
			System.out.println("test : " + x);
			jsonObject.put("Ha", Double.parseDouble(jo.get("x").toString()));
			jsonObject.put("Ga", Double.parseDouble(jo.get("y").toString()));
			
			
			ja.put(jsonObject);
			
			System.out.println("tae : " + jsonObject);
		}
		
		System.out.println(ja.length());
		System.out.println(ja.get(0));
		System.out.println(ja.get(1));
		//na {Ga: x, Ha: y}

		for(int i = 0; i < ja.length(); i++) {
			System.out.println(ja.get(i));
		}
		
		
		JSONObject eo = ja.getJSONObject(0);
		System.out.println(eo);
	}

}
