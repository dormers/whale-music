<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- Chart.js와 Bootstrap을 외부에서 가져오기 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"> -->
<div class="content" name="content" id="content">
	<div class="container">
		<h1 id="statistic-name">유형별</h1>
	    <div class="btnBox">
		    <button id="btnChart1">유형별</button>
		    <button id="btnChart2">일별 신고</button>
		    <button id="btnChart3">신고처리속도</button>
	    </div>
	    <div class="chartBox">
	        <canvas id="reportChart"></canvas>
	    </div>
	</div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
    	
    	var reportLabels1 = [];
    	<c:forEach var="label" items="${reportLabels1}">
    	reportLabels1.push(`${label}`);
    	</c:forEach>
    	var reportValues1 = [];
    	<c:forEach var="value" items="${reportValues1}">
    	reportValues1.push(${value});
    	</c:forEach>
    	
    	
    	var reportLabels2 = [];
    	<c:forEach var="label" items="${reportLabels2}">
    	reportLabels2.push(`${label}`);
    	</c:forEach>
    	var reportValues2 = [];
    	<c:forEach var="value" items="${reportValues2}">
    	reportValues2.push(${value});
    	</c:forEach>
    	
    	
    	var reportLabels3 = [];
    	<c:forEach var="label" items="${reportLabels3}">
    	reportLabels3.push(`${label}`);
    	</c:forEach>
    	var reportValues3 = [];
    	<c:forEach var="value" items="${reportValues3}">
    	reportValues3.push(${value});
    	</c:forEach>
    	
    	var targetTypes = [];
        var actionCounts = [];
        var resultActions = [];
        <c:forEach var="value" items="${action_count}">
        targetTypes.push(${value});
    	</c:forEach>
        <c:forEach var="value" items="${actionCounts}">
        actionCounts.push(${value});
    	</c:forEach>
        <c:forEach var="value" items="${resultActions}">
        resultActions.push(${value});
    	</c:forEach>
        
        
        
        const ctx = document.getElementById('reportChart').getContext('2d');
        let chartData = {
                labels: reportLabels1,
                datasets: [{
                    label: '신고건',
                    data: reportValues1,
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
                    scales: {
    		            x: {
    		                grid: {
    		                    display: false
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

            // 버튼 클릭 이벤트 핸들러
            document.getElementById('btnChart1').addEventListener('click', function () {
                updateChart1('bar', reportLabels1, reportValues1, '신고건');
                document.getElementById('statistic-name').innerText ="유형별";
            });

            document.getElementById('btnChart2').addEventListener('click', function () {
                updateChart1('bar', reportLabels2, reportValues2, '신고건');
                document.getElementById('statistic-name').innerText ="일별 신고";
            });

            document.getElementById('btnChart3').addEventListener('click', function () {
                updateChart2('pie', reportLabels3, reportValues3, '완료건');
                document.getElementById('statistic-name').innerText ="신고처리속도";
            });

            // 차트를 업데이트하는 함수
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
                        scales: {
        		            x: {
        		                grid: {
        		                    display: false
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
            function updateChart2(type, labels, data, label) {
                myChart.destroy(); // 기존 차트 삭제
                myChart = new Chart(ctx, {
                    type: type,
                    data: {
                        labels: labels,
                        datasets: [{
                            label: label,
                            data: data,
                            backgroundColor: [
                            	'rgba(162, 162, 235, 0.5)',
                            	'rgba(120, 120, 235, 0.5)',
                            	'rgba(80, 80, 235, 0.5)'],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
        		            x: {
        		                grid: {
        		                    display: false
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
        });
</script>
