package com.huation.myweb.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.huation.myweb.vo.MemberVO;

@RequestMapping(path = { "/echo" })
public class EchoHandler extends TextWebSocketHandler {

	// 세션 리스트
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	// Logger
	private static Logger logger = org.slf4j.LoggerFactory.getLogger(EchoHandler.class);
	
	// member 정보를 저장할 HashMap
	HashMap<String, String> chatMemberMap = new HashMap<String, String>();
	
	// member 정보를 저장할 JSON String
	String json = "";
	
	// JSON String 변환을 위한 jackson databind mapper 객체
	ObjectMapper mapper = new ObjectMapper();
	
	// client가 연결되었을 때 실행
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		
		Map<String, Object> attributeMap = session.getAttributes();
		MemberVO member = (MemberVO) attributeMap.get("loginuser");
		
		chatMemberMap.put(session.getId(), member.getMemberId());
		System.out.println(chatMemberMap);
		
		json = mapper.writeValueAsString(chatMemberMap);
		
		for (WebSocketSession ses : sessionList) {
			ses.sendMessage(new TextMessage(json));
		}
		
		logger.info("{} connected", session.getId());
	}
	
	// client가 WebSocket server로 message를 전송했을 때 실행
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("from {}: {} received", session.getId(), message.getPayload());
		// 모든 유저에게 message 출력
		for (WebSocketSession ses : sessionList) {
			System.out.println(message.getPayload());
			ses.sendMessage(new TextMessage(message.getPayload()));
		}
	}
	
	// client가 연결을 끊었을 때 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		chatMemberMap.remove(session.getId());
		
		json = mapper.writeValueAsString(chatMemberMap);
		
		for (WebSocketSession ses : sessionList) {
			ses.sendMessage(new TextMessage(json));
		}
		
		logger.info("{} connection closed", session.getId());
	}
}
