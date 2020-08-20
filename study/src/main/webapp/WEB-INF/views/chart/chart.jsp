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
	#chart-container {
		float: right;
		position: relative;
		left: -50%;
	}
	canvas {
	    float: left;
	    width: 40%;
	    position: relative;
	    left: 60%;
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
				<canvas id="myChart"></canvas>
				<canvas id="myChart2"></canvas>
				<canvas id="myChart3"></canvas>
				<canvas id="myChart4"></canvas>
			</div>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
	<script>
		$(function() {

			function randomColor(labels) {
				var colors = [];
				for (let i = 0; i < labels.length; i++) {
					colors.push("#" + Math.round(Math.random() * 0xffffff).toString(16));
				}
				return colors;
			}

			function makeChart(ctx, type, labels, data) {
				var myChart = new Chart(ctx, {
				    type: type,
				    data: {
				        labels: labels,
				        datasets: [{
				            label: '날짜별 게시글 등록 수',
				            data: data,
				            backgroundColor: randomColor(labels)
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
					console.log(data);
					var labels = [];
					var myData = [];
					data.map(function(item) {
						labels.push(item.regDate);
					});
					data.map(function(item) {
						myData.push(item.dateCount);
					});

					var newLabels = labels.slice(-5);
					var newMyData = myData.slice(-5);

					// Chart.js 막대그래프 그리기
					var ctx = $('#myChart');
					makeChart(ctx, 'bar', newLabels, newMyData);
					// Chart.js 선그래프 그리기
					ctx = $('#myChart2');
					makeChart(ctx, 'line', newLabels, newMyData);
					// Chart.js 원그래프 그리기
					ctx = $('#myChart3');
					makeChart(ctx, 'pie', newLabels, newMyData);
					ctx = $('#myChart4');
					makeChart(ctx, 'doughnut', newLabels, newMyData);
				}
			});
			
		});
	</script>
</body>
</html>