package com.huation.myweb.handler;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@RequestMapping(path = { "/echo" })
public class EchoHandler extends TextWebSocketHandler {

	// 세션 리스트
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	private static Logger logger = org.slf4j.LoggerFactory.getLogger(EchoHandler.class);
	
	// client가 연결되었을 때 실행
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		logger.info("{} connected", session.getId());
	}
	
	// client가 WebSocket server로 message를 전송했을 때 실행
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("from {}: {} received", session.getId(), message.getPayload());
		// 모든 유저에게 message 출력
		for (WebSocketSession ses : sessionList) {
			System.out.println(message.getPayload());
			if (message.getPayload().contains(":")) {
				ses.sendMessage(new TextMessage(message.getPayload()));
			}
		}
	}
	
	// client가 연결을 끊었을 때 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		logger.info("{} connection closed", session.getId());
	}
}
