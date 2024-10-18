package com.tech.whale.admin.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminIDao {
	public void reply(String bid, String bname, String btitle,
			String bcontent, String bgroup,
			String bstep, String bindent);
	public int replyShape(String strgroup,String strstep);
//	public int selectBoardCount();
	public int selectBoardCount(String sk, String selNum);
}
