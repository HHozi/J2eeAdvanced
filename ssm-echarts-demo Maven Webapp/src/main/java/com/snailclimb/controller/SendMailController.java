package com.snailclimb.controller;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.snailclimb.utils.EmailUtils;

import freemarker.template.Configuration;

/**
 * 测试邮件发送controller
 * @author Snailclimb
 */
@RestController
@RequestMapping("mail")
public class SendMailController {
	@Autowired
	private JavaMailSender javaMailSender;// 在spring中配置的邮件发送的bean
	@Autowired
	private Configuration configuration;
	@Autowired
	private VelocityEngine velocityEngine;

	// text
	@RequestMapping("send")
	public String sendEmail() {
		EmailUtils emailUtils = new EmailUtils();
		return emailUtils.sendMail("大傻子大傻子大傻子，你好！！！", "发送给我家大傻子的~", "D:/picture/meizi.jpg", "1361583339@qq.com",
				javaMailSender, false);
	}

	// html
	@RequestMapping("send2")
	public String sendEmail2() {
		EmailUtils emailUtils = new EmailUtils();
		return emailUtils.sendMail(
				"<p>大傻子大傻子大傻子，你好！！！</p><br/>" + "<a href='https://github.com/Snailclimb'>点击打开我的Github!</a><br/>",
				"发送给我家大傻子的~", "D:/picture/meizi.jpg", "1361583339@qq.com", javaMailSender, true);
	}

	// freemarker
	@RequestMapping("send3")
	public String sendEmail3() {
		EmailUtils emailUtils = new EmailUtils();
		return emailUtils.sendMailFreeMarker("发送给我家大傻子的~", "D:/picture/meizi.jpg", "1361583339@qq.com", javaMailSender,
				configuration);

	}

	// velocity
	@RequestMapping("send4")
	public String sendEmail4() {
		EmailUtils emailUtils = new EmailUtils();
		return emailUtils.sendMailVelocity("发送给我家大傻子的~", "D:/picture/meizi.jpg", "1361583339@qq.com", javaMailSender,
				velocityEngine);

	}
}
