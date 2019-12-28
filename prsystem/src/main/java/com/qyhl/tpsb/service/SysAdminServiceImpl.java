package com.qyhl.tpsb.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qyhl.tpsb.entity.SysAdminEntity;
import com.qyhl.tpsb.mapper.SysAdminMapper;

@Service
public class SysAdminServiceImpl implements SysAdminService {
	
	@Autowired
	private SysAdminMapper sysAdminMapper;

	
	@Override
	public SysAdminEntity login(String phone, String apassword) {
		
		return sysAdminMapper.login(phone, apassword);
	}
	

}
