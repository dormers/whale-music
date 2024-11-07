package com.tech.whale.message.controller;

import com.tech.whale.message.dao.MessageDao;
import com.tech.whale.message.dto.AllChatListDto;
import com.tech.whale.message.dto.FollowListDto;
import com.tech.whale.message.dto.ReadChatDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MessageController2 {

	@Autowired
	private MessageDao messageDao;

	@RequestMapping("/message/home")
	public String messageHome(HttpServletRequest request, HttpSession session, Model model) {
		String now_id = (String) session.getAttribute("user_id");

		List<AllChatListDto> allChatList = messageDao.getAllChatList(now_id);
		List<ReadChatDto> readChatList = messageDao.getReadChatList(now_id);

		// ReadChatDto를 Map으로 변환하여 빠른 검색 가능
		Map<String, ReadChatDto> readChatMap = new HashMap<>();
		for (ReadChatDto readChatDto : readChatList) {
			readChatMap.put(readChatDto.getUser_id(), readChatDto);
		}

		// allChatList를 순회하면서 필요한 데이터 설정
		// allChatList를 순회하면서 필요한 데이터 설정
		for (AllChatListDto list : allChatList) {
			// 시간 차이 계산 (항상 수행)
			Timestamp lastMessageDate = list.getLast_message_create_date();
			long diffMillis = System.currentTimeMillis() - lastMessageDate.getTime();
			int seconds = (int) (diffMillis / 1000);
			String timeDifference = "";

			if (seconds < 60) {
				timeDifference = seconds + "초 전";
			} else if (seconds < 3600) {
				int minutes = seconds / 60;
				timeDifference = minutes + "분 전";
			} else if (seconds < 86400) {
				int hours = seconds / 3600;
				timeDifference = hours + "시간 전";
			} else {
				int days = seconds / 86400;
				timeDifference = days + "일 전";
			}
			list.setTime_difference(timeDifference);

			ReadChatDto readChatDto = readChatMap.get(list.getUser_id());
			if (readChatDto != null) {
				// 읽지 않은 메시지가 있는 경우
				list.setUnread_message_count(readChatDto.getUnread_message_count());
			} else {
				// 읽지 않은 메시지가 없는 경우
				list.setUnread_message_count(0);
			}
		}

		// debug
		for (AllChatListDto list : allChatList) {
			System.out.println("User_id: " + list.getUser_id());
			System.out.println("Last_message_sender_id: " + list.getLast_message_sender_id());
			System.out.println("Time_difference: " + list.getTime_difference());
			System.out.println("Unread_message_count: " + list.getUnread_message_count());
			System.out.println("--------------------------");
		}

		model.addAttribute("allChatList", allChatList);
		model.addAttribute("now_id", now_id);

		return "message/home";
	}

	@RequestMapping("/message/newChat")
	public String newChat(HttpServletRequest request, HttpSession session, Model model) {
		System.out.println("newChat() ctr");
		String now_id = (String) session.getAttribute("user_id");

		List<FollowListDto> followList = messageDao.getFollowList(now_id);

		//debug
		for (FollowListDto followListDto : followList) {
			System.out.println(followListDto.getFollow_user_id());
			System.out.println(followListDto.getFollow_user_nickname());
			System.out.println(followListDto.getFollow_user_image_url());
			System.out.println("--------------------");
		}

		model.addAttribute("now_id", now_id);
		model.addAttribute("followList", followList);

		return "/message/newChat";
	}
}
