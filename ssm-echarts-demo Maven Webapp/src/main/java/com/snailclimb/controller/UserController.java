package com.snailclimb.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.snailclimb.bean.ScoreResult;
import com.snailclimb.bean.User;
import com.snailclimb.service.UserService;

@Controller
@RequestMapping(value = "/echarts")
public class UserController {

	@Autowired
	private UserService userService;

	/**
	 * 折线图和直方图
	 * 
	 * @return
	 */
	@RequestMapping(value = "/agreeLineAndBar")
	@ResponseBody
	public List<User> getAgreesTop10() {
		return userService.selecAgreesTop10();

	}

	/**
	 * 圆饼图
	 * 
	 * @return
	 */

	@RequestMapping(value = "/agreePie")
	@ResponseBody
	public List<ScoreResult> getAgreesTop10T() {
		List<User> list = userService.selecAgreesTop10();
		List<ScoreResult> results = new ArrayList<ScoreResult>();
		for (User user : list) {
			ScoreResult scoreResult = new ScoreResult(user.getAgrees(), user.getUsername());
			results.add(scoreResult);
		}
		return results;
	}

	// 跳转到圆饼图展示
	@RequestMapping(value = "/intoagreePie")
	public String intoagreePie() {
		return "agreePie";

	}

	// 跳转到折线图和直方图
	@RequestMapping(value = "/intoagreeLineAndBar")
	public String Index() {
		return "agreeLineAndBar";

	}
}
