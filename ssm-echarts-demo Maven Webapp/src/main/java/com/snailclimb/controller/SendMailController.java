package com.snailclimb.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import utils.EmailUtils;

/**
 * created by viking on 2018/07/17 测试邮件发送controller
 */
@RestController
@RequestMapping("mail")
public class SendMailController {
	@Autowired
	private JavaMailSender javaMailSender;// 在spring中配置的邮件发送的bean

	@RequestMapping("send")
	public void sendEmail() {
		EmailUtils emailUtils = new EmailUtils();
		emailUtils.sendMail("大傻子大傻子大傻子，你好！！！", "发送给我家大傻子的~", "D:/picture/meizi.jpg", "1361583339@qq.com",
				javaMailSender, false);
	}

	@RequestMapping("send2")
	public void sendEmail2() {
		EmailUtils emailUtils = new EmailUtils();
		emailUtils.sendMail(
				"<p>大傻子大傻子大傻子，你好！！！</p><br/>" + "<a href='https://github.com/Snailclimb'>点击打开我的Github!</a><br/>",
				"发送给我家大傻子的~", "D:/picture/meizi.jpg", "1361583339@qq.com", javaMailSender, true);
	}
}
