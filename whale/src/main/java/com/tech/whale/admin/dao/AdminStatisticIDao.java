package com.tech.whale.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.tech.whale.admin.dto.AdminLVDataDto;
import com.tech.whale.admin.dto.AdminRRDataDto;

@Mapper
public interface AdminStatisticIDao {
	public List<AdminLVDataDto> reportStatistic1();
	public List<AdminLVDataDto> reportStatistic2();
	public List<AdminLVDataDto> reportStatistic3();
	public List<AdminLVDataDto> userStatistic1();
	public List<AdminLVDataDto> userStatistic2();
	public List<AdminLVDataDto> cfStatistic1();
	public List<AdminLVDataDto> cfStatistic2();
	public List<AdminLVDataDto> cfStatistic3();
	public List<AdminLVDataDto> cfStatistic4();
	public List<AdminLVDataDto> cfStatistic5();
	public List<AdminLVDataDto> cfStatistic6();
	public List<AdminLVDataDto> cfStatistic7();
	public List<AdminLVDataDto> cfStatistic8();
	public List<AdminLVDataDto> cfStatistic9();
	public List<AdminLVDataDto> cfStatistic10();
	public List<AdminLVDataDto> cfStatistic11();
	public List<AdminLVDataDto> cfStatistic12();
	public List<AdminLVDataDto> cfStatistic13();
	
	public List<AdminLVDataDto> mugicStatistic1();
	public List<AdminLVDataDto> mugicStatistic2();
	public List<AdminLVDataDto> mugicStatistic3();
	public List<AdminLVDataDto> mugicStatistic4();
	public List<AdminLVDataDto> mugicStatistic5();
	public List<AdminLVDataDto> mugicStatistic6();
	public List<AdminLVDataDto> mugicStatistic7();
	public List<AdminLVDataDto> mugicStatistic8();
	public List<AdminLVDataDto> mugicStatistic9();
}
