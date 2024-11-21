<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<div class="content" name="content" id="content">
	<div class="container">
		<h1 id="statistic-name">1일 종합 태그 순위</h1>
	    <div id="postBtn" class="btnBox">
		    <button id="btnChart1">1일태그순위</button>
		    <button id="btnChart2">7일태그순위</button>
		    <button id="btnChart3">전체태그순위</button>
		    <button id="btnChart4">1일재생순위</button>
		    <button id="btnChart5">7일재생순위</button>
		    <button id="btnChart6">30일재생순위</button>
		    <button id="btnChart7">7일신규좋아요</button>
		    <button id="btnChart8">전체좋아요순위</button>
		    <button id="btnChart9">시간별이용량</button>
	    </div>
	    <div class="chartBox">
	        <canvas id="reportChart"></canvas>
	    </div>
	    <br/>
	</div>
</div>
<script>
	
    document.addEventListener("DOMContentLoaded", function () {
    	
    	var musicLabels1 = [];
    	<c:forEach var="label" items="${musicLabels1}">
    	musicLabels1.push(`${label}`);
    	</c:forEach>
    	var musicValues1 = [];
    	<c:forEach var="value" items="${musicValues1}">
    	musicValues1.push(Number(${value}));
    	</c:forEach>
    	
    	var musicLabels2 = [];
    	<c:forEach var="label" items="${musicLabels2}">
    	musicLabels2.push(`${label}`);
    	</c:forEach>
    	var musicValues2 = [];
    	<c:forEach var="value" items="${musicValues2}">
    	musicValues2.push(Number(${value}));
    	</c:forEach>
    	
    	var musicLabels3 = [];
    	<c:forEach var="label" items="${musicLabels3}">
    	musicLabels3.push(`${label}`);
    	</c:forEach>
    	var musicValues3 = [];
    	<c:forEach var="value" items="${musicValues3}">
    	musicValues3.push(Number(${value}));
    	</c:forEach>  
    	
    	var musicLabels4 = [];
    	<c:forEach var="label" items="${musicLabels4}">
    	musicLabels4.push(`${label}`);
    	</c:forEach>
    	var musicValues4 = [];
    	<c:forEach var="value" items="${musicValues4}">
    	musicValues4.push(Number(${value}));
    	</c:forEach>  
    	
    	var musicLabels5 = [];
    	<c:forEach var="label" items="${musicLabels5}">
    	musicLabels5.push(`${label}`);
    	</c:forEach>
    	var musicValues5 = [];
    	<c:forEach var="value" items="${musicValues5}">
    	musicValues5.push(Number(${value}));
    	</c:forEach>  
    	
    	var musicLabels6 = [];
    	<c:forEach var="label" items="${musicLabels6}">
    	musicLabels6.push(`${label}`);
    	</c:forEach>
    	var musicValues6 = [];
    	<c:forEach var="value" items="${musicValues6}">
    	musicValues6.push(Number(${value}));
    	</c:forEach>  
    	
    	var musicLabels7 = [];
    	<c:forEach var="label" items="${musicLabels7}">
    	musicLabels7.push(`${label}`);
    	</c:forEach>
    	var musicValues7 = [];
    	<c:forEach var="value" items="${musicValues7}">
    	musicValues7.push(Number(${value}));
    	</c:forEach>  
    	
    	var musicLabels8 = [];
    	<c:forEach var="label" items="${musicLabels8}">
    	musicLabels8.push(`${label}`);
    	</c:forEach>
    	var musicValues8 = [];
    	<c:forEach var="value" items="${musicValues8}">
    	musicValues8.push(Number(${value}));
    	</c:forEach>  
    	
    	var musicLabels9 = [];
    	<c:forEach var="label" items="${musicLabels9}">
    	musicLabels9.push(`${label}`);
    	</c:forEach>
    	var musicValues9 = [];
    	<c:forEach var="value" items="${musicValues9}">
    	musicValues9.push(Number(${value}));
    	</c:forEach>  
    	
    	
    	var backColors1 = [];
    	<c:forEach var="color" items="${backColors1}">
    	    backColors1.push('${color}');
    	</c:forEach>;
    	
    	var backColors2 = [];
    	<c:forEach var="color" items="${backColors2}">
    	    backColors2.push('${color}');
    	</c:forEach>;
    	
    	var backColors3 = [];
    	<c:forEach var="color" items="${backColors3}">
    	    backColors3.push('${color}');
    	</c:forEach>;
    	
    	var backColors4 = [];
    	<c:forEach var="color" items="${backColors4}">
    	    backColors4.push('${color}');
    	</c:forEach>;
    	
    	var backColors5 = [];
    	<c:forEach var="color" items="${backColors5}">
    	    backColors5.push('${color}');
    	</c:forEach>;
    	
    	var backColors6 = [];
    	<c:forEach var="color" items="${backColors6}">
    	    backColors6.push('${color}');
    	</c:forEach>;
    	
    	var backColors7 = [];
    	<c:forEach var="color" items="${backColors7}">
    	    backColors7.push('${color}');
    	</c:forEach>;
    	
    	var backColors8 = [];
    	<c:forEach var="color" items="${backColors8}">
    	    backColors8.push('${color}');
    	</c:forEach>;
    	
    	var backColors9 = [];
    	<c:forEach var="color" items="${backColors9}">
    	    backColors9.push('${color}');
    	</c:forEach>;
    	
    	    const chartConfigurations = [
    	        { btnId: 'btnChart1', type: 'bar', labels: musicLabels1, values: musicValues1, label: '개수', chartFunc: updateChart1, title: "1일 종합 태그 순위" },
    	        { btnId: 'btnChart2', type: 'bar', labels: musicLabels2, values: musicValues2, label: '개수', chartFunc: updateChart1, title: "7일 종합 태그 순위" },
    	        { btnId: 'btnChart3', type: 'bar', labels: musicLabels3, values: musicValues3, label: '개수', chartFunc: updateChart1, title: "30일 종합 태그 순위" },
    	        { btnId: 'btnChart4', type: 'bar', labels: musicLabels4, values: musicValues4, label: '횟수', chartFunc: updateChart1, title: "1일 재생" },
    	        { btnId: 'btnChart5', type: 'bar', labels: musicLabels5, values: musicValues5, label: '횟수', chartFunc: updateChart1, title: "7일 재생" },
    	        { btnId: 'btnChart6', type: 'bar', labels: musicLabels6, values: musicValues6, label: '횟수', chartFunc: updateChart1, title: "30일 재생" },
    	        { btnId: 'btnChart7', type: 'bar', labels: musicLabels7, values: musicValues7, label: '개수', chartFunc: updateChart1, title: "7일 신규 좋아요" },
    	        { btnId: 'btnChart8', type: 'bar', labels: musicLabels8, values: musicValues8, label: '개수', chartFunc: updateChart1, title: "전체 좋아요 순위" },
    	        { btnId: 'btnChart9', type: 'pie', labels: musicLabels9, values: musicValues9, label: '횟수', chartFunc: updateChart2, backColors: backColors1, title: "시간변 이용량" }
    	       
    	    ];

    	    chartConfigurations.forEach(config => {
    	        document.getElementById(config.btnId).addEventListener('click', function () {
    	            if (config.chartFunc === updateChart2) {
    	                config.chartFunc(config.type, config.labels, config.values, config.label, config.backColors);
    	            } else {
    	                config.chartFunc(config.type, config.labels, config.values, config.label);
    	            }
    	            document.getElementById('statistic-name').innerText = config.title; // 설정된 제목으로 텍스트 변경
    	        });
    	    });
    	
    	    console.log('musicLabels1:', musicLabels1);
    	    console.log('musicValues1:', musicValues1);

    	    
        const ctx = document.getElementById('reportChart').getContext('2d');
        let chartData = {
                labels: musicLabels1,
                datasets: [{
                    label: '개수',
                    data: musicValues1,
                    backgroundColor: 'rgba(162, 162, 235, 0.5)'
                }]
            };

            // 차트 생성
            let myChart = new Chart(ctx, {
                type: 'bar',
                data: chartData,
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    indexAxis: 'y',
                    scales: {
    		            x: {
    		            	position: 'top',
    		                grid: {
    		                    display: false
    		                },
	    		            ticks: {
	    	                    // 소수점 없이 정수로만 표시
	    	                    callback: function(value) {
	    	                        return Math.floor(value); // 소수점을 제거하고 정수로 표시
	    	                    },
	    	                    stepSize: 1 // 필요한 경우, 간격을 1로 설정하여 정수 값만 표시
	    	                }
    		            },
    		            y: {
    		            	
    		                grid: {
    		                    display: true
    		                }
    		            }
    		        }
                }
            });
            
            function updateChart1(type, labels, data, label) {
                myChart.destroy(); // 기존 차트 삭제
                myChart = new Chart(ctx, {
                    type: type,
                    data: {
                        labels: labels,
                        datasets: [{
                            label: label,
                            data: data,
                            backgroundColor: 'rgba(162, 162, 235, 0.5)',
                            /* borderColor: getBorderColors(data.length), */
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        indexAxis: 'y',
                        scales: {
        		            x: {
        		            	position: 'top',
        		                grid: {
        		                    display: false
        		                },
	        		            ticks: {
	        	                    // 소수점 없이 정수로만 표시
	        	                    callback: function(value) {
	        	                        return Math.floor(value); // 소수점을 제거하고 정수로 표시
	        	                    },
	        	                    stepSize: 1 // 필요한 경우, 간격을 1로 설정하여 정수 값만 표시
	        	                }
        		            },
        		            y: {
        		                grid: {
        		                    display: true
        		                }
        		            }
        		        }
                    }
                });
            }
            function updateChart2(type, labels, data, label,backColors) {
                myChart.destroy(); // 기존 차트 삭제
                myChart = new Chart(ctx, {
                    type: type,
                    data: {
                        labels: labels,
                        datasets: [{
                            data: data,
                            backgroundColor: backColors,
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: true,
                                position: 'left' // 범례를 왼쪽에 위치
                            }
                        }
                    }
                });
            }
            

        });
</script>
