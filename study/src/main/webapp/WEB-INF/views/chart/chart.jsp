<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
<meta charset='utf-8' />
<title>Home</title>
<link rel='Stylesheet' href='/myweb/resources/css/default.css' />
</head>
<body>

	<div id='pageContainer'>

		<jsp:include page="/WEB-INF/views/sidebar.jsp" />

		<div id='content'>
			<br /><br /><br />
			<h2 style='text-align: center'>Chart.js</h2>
			<br /><br /><br />
			<div style="margin-left:250px">
				<canvas id="myChart" style="width:800px;height:400px"></canvas>
			</div>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
	<script>
		$(function() {
			
			$.ajax({
				type: "GET",
				url: "/myweb/chart/count",
				success: function(data, status, xhr) {

					// JSON 객체 배열 데이터를 Javascript 배열로 변환
					var labels = [];
					var datasets = [];
					data.map(function(item) {
						labels.push(item.regDate);
					});
					data.map(function(item) {
						datasets.push(item.dateCount);
					});

					// Chart.js 막대그래프 그리기
					var ctx = $('#myChart');
					var myChart = new Chart(ctx, {
					    type: 'bar',
					    data: {
					        labels: labels,
					        datasets: [{
					            label: '날짜별 게시글 등록 수',
					            data: datasets,
					            backgroundColor: [
					                'rgba(255, 99, 132, 0.2)',
					                'rgba(54, 162, 235, 0.2)',
					                'rgba(255, 206, 86, 0.2)',
					                'rgba(75, 192, 192, 0.2)',
					                'rgba(153, 102, 255, 0.2)'
					            ],
					            borderColor: [
					                'rgba(255, 99, 132, 1)',
					                'rgba(54, 162, 235, 1)',
					                'rgba(255, 206, 86, 1)',
					                'rgba(75, 192, 192, 1)',
					                'rgba(153, 102, 255, 1)'
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
			});			
			
		});
	</script>
</body>
</html>