<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
<meta charset='utf-8' />
<title>Home</title>
<link rel='Stylesheet' href='/myweb/resources/css/default.css' />
<style>
	canvas {
	    padding-left: 0;
	    padding-right: 0;
	    margin-left: auto;
	    margin-right: auto;
	    display: block;
	    width: 800px;
	}
</style>
</head>
<body>

	<div id='pageContainer'>

		<jsp:include page="/WEB-INF/views/sidebar.jsp" />

		<div id='content'>
			<br /><br /><br />
			<h2 style='text-align:center'>Chart.js</h2>
			<br /><br /><br />
			<div id="chart-container">
				<canvas id="myChart"></canvas><br>
				<canvas id="myChart2"></canvas><br>
				<canvas id="myChart3"></canvas><br>
				<canvas id="myChart4"></canvas>
			</div>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
	<script>
		$(function() {

			function makeChart(ctx, type, labels, data) {
				var myChart = new Chart(ctx, {
				    type: type,
				    data: {
				        labels: labels,
				        datasets: [{
				            label: '날짜별 게시글 등록 수',
				            data: data,
				            backgroundColor: [
				                'rgba(255, 99, 132, 0.2)',
				                'rgba(54, 162, 235, 0.2)',
				                'rgba(255, 206, 86, 0.2)',
				                'rgba(75, 192, 192, 0.2)',
				                'rgba(153, 102, 255, 0.2)',
				                'rgba(255, 159, 64, 0.2)'
				            ],
				            borderColor: [
				                'rgba(255, 99, 132, 1)',
				                'rgba(54, 162, 235, 1)',
				                'rgba(255, 206, 86, 1)',
				                'rgba(75, 192, 192, 1)',
				                'rgba(153, 102, 255, 1)',
				                'rgba(255, 159, 64, 1)'
				            ],
				            borderWidth: 1
				        }]
				    },
				    options: {
					    responsive: false,
				        scales: {
				            yAxes: [{
				                ticks: {
				                    beginAtZero: true
				                }
				            }]
				        }
				    }
				});
			}
			
			$.ajax({
				type: "GET",
				url: "/myweb/chart/count",
				success: function(data, status, xhr) {

					// JSON 객체 배열 데이터를 Javascript 배열로 변환
					var labels = [];
					var myData = [];
					data.map(function(item) {
						labels.push(item.regDate);
					});
					data.map(function(item) {
						myData.push(item.dateCount);
					});

					// Chart.js 막대그래프 그리기
					var ctx = $('#myChart');
					makeChart(ctx, 'bar', labels, myData);
					// Chart.js 선그래프 그리기
					ctx = $('#myChart2');
					makeChart(ctx, 'line', labels, myData);
					// Chart.js 원그래프 그리기
					ctx = $('#myChart3');
					makeChart(ctx, 'pie', labels, myData);
				}
			});
			
		});
	</script>
</body>
</html>