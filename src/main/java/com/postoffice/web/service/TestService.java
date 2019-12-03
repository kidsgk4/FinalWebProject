package com.postoffice.web.service;

import javax.annotation.PreDestroy;

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.postoffice.web.dao.VillageDAO;
import com.postoffice.web.dto.VillageDTO;

@Service
public class TestService {
private static final Logger logger = LoggerFactory.getLogger(TestService.class);
	
	private MqttClient client;
	private String path;
	
	@Autowired
	VillageDAO villageDao;
	
	public void setPath(String path) {
		this.path = path;
	}
	
	public String getPath() {
		return this.path;
	}
	
	public TestService() {
		mqttConnect();
	}
	
	private void mqttConnect() {
		try {
			client = new MqttClient("tcp://106.253.56.124:1883", MqttClient.generateClientId(), null);
			client.connect();
			receiveMessage();
			logger.debug("MQTT Broker 연결 성공: tcp://106.253.56.124:1883");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	private void mqttDisconnect() {
		try {
			client.disconnectForcibly(1); //즉시 연결 끊기(값 1)
			client.close(true);
			logger.debug("MQTT Broker 연결 끊김");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@PreDestroy //객체가 없어지기 직전에 실행
	public void destroy() {
		logger.debug("destroy실행");
		mqttDisconnect();
		logger.debug("나 죽어~");
	}
	
	private void receiveMessage() throws Exception {
		client.setCallback(new MqttCallback() {
			
			@Override
			public void messageArrived(String topic, MqttMessage message) throws Exception {
				byte[] bytes = message.getPayload();
				String json = new String(bytes);
				JSONObject jsonObject = new JSONObject(json);
				logger.debug(jsonObject.toString());
				System.out.println(jsonObject.getString("vid"));
				System.out.println(jsonObject.getString("vpathid"));
				System.out.println(jsonObject.getJSONArray("path").toString());
				String vid = jsonObject.getString("vid");
				String vpathid = jsonObject.getString("vpathid");
				String path = jsonObject.getJSONArray("path").toString();
				VillageDTO villageDto = new VillageDTO();
				villageDto.setVid(vid);
				if(vpathid.equals("sendPath")) {
					logger.debug("villageDao.updateSendPath 실행");
					villageDto.setSend_path(path);
					villageDao.updateSendPath(villageDto);
					logger.debug("villageDao.updateSendPath 실행");
				} else {
					logger.debug("villageDao.updateReturnPath 실행");
					villageDto.setReturn_path(path);
					villageDao.updateReturnPath(villageDto);
					logger.debug("villageDao.updateReturnPath 실행");
				}
				
				
			}
			
			@Override
			public void deliveryComplete(IMqttDeliveryToken token) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void connectionLost(Throwable cause) {
				// TODO Auto-generated method stub
				
			}
		});
		
		client.subscribe("/drone/web/sub");
	}

	public void sendMessage(String path) {
		try {
			if(path.equals("path")) {
				JSONObject jsonObject = new JSONObject(getPath());
				jsonObject.put("code", path);
				String json = jsonObject.toString();
				client.publish("/drone/web/pub", json.getBytes(), 0, false);
			} else {
				JSONObject jsonObject = new JSONObject(getPath());
				jsonObject.put("code", path);
				String json = jsonObject.toString();
				client.publish("/drone/web/pub", json.getBytes(), 0, false);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
}
