package com.snailclimb.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.snailclimb.bean.User;
import com.snailclimb.dao.UserMapper;
import com.snailclimb.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserMapper userMapper;

	@Override
	public List<User> selecAgreesTop10() {
		return userMapper.selecAgreesTop10();
	}

}
