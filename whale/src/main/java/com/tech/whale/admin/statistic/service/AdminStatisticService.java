package com.tech.whale.admin.statistic.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.tech.whale.admin.dao.AdminStatisticIDao;
import com.tech.whale.admin.dto.AdminLVDataDto;
import com.tech.whale.admin.dto.AdminRRDataDto;
import com.tech.whale.admin.service.AdminServiceInter;

@Service
public class AdminStatisticService implements AdminServiceInter{

	@Autowired
    private AdminStatisticIDao adminStatisticIDao;
	
	@Override
	public void execute(Model model) {
		
	}
	
	public void reportStatistic1(Model model) {
		
		List<AdminLVDataDto> dataList = adminStatisticIDao.reportStatistic1();
		// 데이터 가공 후 x축 레이블과 y축 데이터로 분리
		List<String> labels = new ArrayList<>();
		List<Integer> values = new ArrayList<>();
		
		for (AdminLVDataDto data : dataList) {
			labels.add(data.getLabel());
			values.add(data.getValue());
		}
		
		model.addAttribute("reportLabels1", labels);
		model.addAttribute("reportValues1", values);
		
	}
	
	public void reportStatistic2(Model model) {
		
		List<AdminLVDataDto> dataList = adminStatisticIDao.reportStatistic2();
		// 데이터 가공 후 x축 레이블과 y축 데이터로 분리
		List<String> labels = new ArrayList<>();
		List<Integer> values = new ArrayList<>();
		
		for (AdminLVDataDto data : dataList) {
			labels.add(data.getLabel());
			values.add(data.getValue());
		}
		
		model.addAttribute("reportLabels2", labels);
		model.addAttribute("reportValues2", values);
		
	}
	
	public void reportStatistic3(Model model) {
		
		List<AdminLVDataDto> dataList = adminStatisticIDao.reportStatistic3();
		// 데이터 가공 후 x축 레이블과 y축 데이터로 분리
		List<String> labels = new ArrayList<>();
		List<Integer> values = new ArrayList<>();
		
		for (AdminLVDataDto data : dataList) {
			labels.add(data.getLabel());
			values.add(data.getValue());
		}
		
		model.addAttribute("reportLabels3", labels);
		model.addAttribute("reportValues3", values);
		
	}
	public void userStatistic1(Model model) {
		
		List<AdminLVDataDto> dataList = adminStatisticIDao.userStatistic1();
		// 데이터 가공 후 x축 레이블과 y축 데이터로 분리
		List<String> labels = new ArrayList<>();
		List<Integer> values = new ArrayList<>();
		
		for (AdminLVDataDto data : dataList) {
			labels.add(data.getLabel());
			values.add(data.getValue());
		}
		
		model.addAttribute("userLabels1", labels);
		model.addAttribute("userValues1", values);
		
	}
	public void userStatistic2(Model model) {
		
		List<AdminLVDataDto> dataList = adminStatisticIDao.userStatistic2();
		// 데이터 가공 후 x축 레이블과 y축 데이터로 분리
		List<String> labels = new ArrayList<>();
		List<Integer> values = new ArrayList<>();
		
		for (AdminLVDataDto data : dataList) {
			labels.add(data.getLabel());
			values.add(data.getValue());
		}
		
		model.addAttribute("userLabels2", labels);
		model.addAttribute("userValues2", values);
		
	}
	public void cfStatistic1(Model model) {
		
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic1(),
				"cfLabels1", "cfValues1", null, false);
		
	}
	public void cfStatistic2(Model model) {
		
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic2(),
				"cfLabels2", "cfValues2", null, false);
		
	}
	public void cfStatistic3(Model model) {
		
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic3(),
				"cfLabels3", "cfValues3", "backColors1", true);
	}
	
	public void cfStatistic4(Model model) {
		
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic4(),
				"cfLabels4", "cfValues4", null, false);
		
	}
	
	public void cfStatistic5(Model model) {
		
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic5(),
				"cfLabels5", "cfValues5", null, false);
		
	}
	public void cfStatistic6(Model model) {
		
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic6(),
				"cfLabels6", "cfValues6", "backColors2", true);
		
	}
	
	public void cfStatistic7(Model model) {
		
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic7(),
				"cfLabels7", "cfValues7", null, false);
		
	}
	public void cfStatistic8(Model model) {
		
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic8(),
				"cfLabels8", "cfValues8", null, false);
		
	}
	public void cfStatistic9(Model model) {
		
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic9(),
				"cfLabels9", "cfValues9", null, false);
		
	}
	public void cfStatistic10(Model model) {
		
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic10(),
				"cfLabels10", "cfValues10", null, false);
		
	}
	public void cfStatistic11(Model model) {
		
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic11(),
				"cfLabels11", "cfValues11", "backColors3", true);
		
	}
	public void cfStatistic12(Model model) {
		
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic12(),
				"cfLabels12", "cfValues12", null, false);
		
	}
	public void cfStatistic13(Model model) {
		
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic13(),
				"cfLabels13", "cfValues13", null, false);
		
	}
	public void cfStatisticList(Model model) {
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic1(),
				"cfLabels1", "cfValues1", null, false);
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic2(),
				"cfLabels2", "cfValues2", null, false);
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic3(),
				"cfLabels3", "cfValues3", "backColors1", true);
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic4(),
				"cfLabels4", "cfValues4", null, false);
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic5(),
				"cfLabels5", "cfValues5", null, false);
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic6(),
				"cfLabels6", "cfValues6", "backColors2", true);
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic7(),
				"cfLabels7", "cfValues7", null, false);
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic8(),
				"cfLabels8", "cfValues8", null, false);
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic9(),
				"cfLabels9", "cfValues9", null, false);
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic10(),
				"cfLabels10", "cfValues10", null, false);
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic11(),
				"cfLabels11", "cfValues11", "backColors3", true);
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic12(),
				"cfLabels12", "cfValues12", null, false);
		fetchStatisticsData(model, adminStatisticIDao.cfStatistic13(),
				"cfLabels13", "cfValues13", null, false);
		
	}
	
	public void musicStatistic(Model model) {
		fetchStatisticsData(model, adminStatisticIDao.mugicStatistic1(),
				"musicLabels1", "musicValues1", null, false);
		fetchStatisticsData(model, adminStatisticIDao.mugicStatistic2(),
				"musicLabels2", "musicValues2", null, false);
		fetchStatisticsData(model, adminStatisticIDao.mugicStatistic3(),
				"musicLabels3", "musicValues3", null, false);
		fetchStatisticsData(model, adminStatisticIDao.mugicStatistic4(),
				"musicLabels4", "musicValues4", null, false);
		fetchStatisticsData(model, adminStatisticIDao.mugicStatistic5(),
				"musicLabels5", "musicValues5", null, false);
		fetchStatisticsData(model, adminStatisticIDao.mugicStatistic6(),
				"musicLabels6", "musicValues6", null, false);
		fetchStatisticsData(model, adminStatisticIDao.mugicStatistic7(),
				"musicLabels7", "musicValues7", null, false);
		fetchStatisticsData(model, adminStatisticIDao.mugicStatistic8(),
				"musicLabels8", "musicValues8", null, false);
		fetchStatisticsData(model, adminStatisticIDao.mugicStatistic9(),
				"musicLabels9", "musicValues9", "backColors1", true);
	}
	
	private void fetchStatisticsData(
			Model model, 
			List<AdminLVDataDto> dataList, 
			String labelKey, 
			String valueKey, 
			String colorKey, 
			boolean generateColors
			) {
        List<String> labels = new ArrayList<>();
        List<Integer> values = new ArrayList<>();
        List<String> backColors = new ArrayList<>();

        for (AdminLVDataDto data : dataList) {
            labels.add(data.getLabel());
            values.add(data.getValue());

            if (generateColors) {
                int r = (int) (Math.random() * 256);
                int g = (int) (Math.random() * 256);
                int b = (int) (Math.random() * 256);
                backColors.add("rgba(" + r + "," + g + "," + b + ",0.5)");
            }
        }

        model.addAttribute(labelKey, labels);
        model.addAttribute(valueKey, values);
        if (generateColors) {
            model.addAttribute(colorKey, backColors);
        }
    }

}
