<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- Chart.js와 Bootstrap을 외부에서 가져오기 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"> -->
<div class="content" name="content" id="content">
	<div class="container">
		<h1 id="statistic-name">30일 신규 유저</h1>
	    <div class="btnBox">
		    <button id="btnChart1">30일신규유저</button>
		    <button id="btnChart2">전체유저</button>
	    </div>
	    <div class="chartBox">
	        <canvas id="reportChart"></canvas>
	    </div>
	</div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
    	
    	var userLabels1 = [];
    	<c:forEach var="label" items="${userLabels1}">
    	userLabels1.push(`${label}`);
    	</c:forEach>
    	var userValues1 = [];
    	<c:forEach var="value" items="${userValues1}">
    	userValues1.push(${value});
    	</c:forEach>
    	
    	
    	var userLabels2 = [];
    	<c:forEach var="label" items="${userLabels2}">
    	userLabels2.push(`${label}`);
    	</c:forEach>
    	var userValues2 = [];
    	<c:forEach var="value" items="${userValues2}">
    	userValues2.push(${value});
    	</c:forEach>
    	
    	
        const ctx = document.getElementById('reportChart').getContext('2d');
        let chartData = {
                labels: userLabels1,
                datasets: [{
                    label: '유저수',
                    data: userValues1,
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
                updateChart1('bar', userLabels1, userValues1, '유저수');
                document.getElementById('statistic-name').innerText ="30일신규유저";
            });

            document.getElementById('btnChart2').addEventListener('click', function () {
                updateChart1('line', userLabels2, userValues2, '유저수');
                document.getElementById('statistic-name').innerText ="전체 유저";
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
        });
</script>
