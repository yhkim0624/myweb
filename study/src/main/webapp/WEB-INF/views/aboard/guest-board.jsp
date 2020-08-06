<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

<head>
    <meta charset="utf-8" />
    <title>방명록</title>
    <link rel="Stylesheet" href="/myweb/resources/css/default.css" />
    
    <style>
    	table {
    		width:60%;
    		margin:0 auto;
    		border:1px solid;
    	}
    	thead tr {
    		background-color:black;
    		color:white;
    	}
    	tfoot td {
    		padding-right:5%;
    	}
    	th, td {
			padding:10px 1px 10px 1px;	
    	}
    	textarea {
    		width:90%;
    	}
    	#guestBookContainer {
    		padding-top:25px;
    		text-align:center;
    	}
    	input[type="button"] {
    		margin-left:5px;
    		float:right;
    	}
    	
    </style>
</head>

<body>

    <div id="pageContainer">

        <jsp:include page="/WEB-INF/views/sidebar.jsp" />
        
        <div id="guestBookContainer">
        	<h2>방명록 (AJAX)</h2>
            <br />
        	
        	<table>
        		<thead>
        			<tr>
        				<th colspan="4">방명록 작성</th>
        			</tr>
        		</thead>
        		<!-- <tbody>
	        		<tr>
	        			<td>작성자</td>
	        			<td>
	        				<input type="text" id="writer">
	        			</td>
	        			<td>이메일</td>
	        			<td>
	        				<input type="email" id="email">
	        			</td>
	        		</tr>
	        		<tr>
	        			<td>내용</td>
	        			<td colspan="3">
	        				<textarea id="content" rows="10"></textarea>
	        			</td>
	        		</tr>
	        		<tr>
	        			<td>비밀번호</td>
	        			<td colspan="3">
	        				<input type="password" id="passwd">
	        			</td>
	        		</tr>
        		</tbody> -->
        		
        		<tbody>
	        		<tr>
	        			<td>
	        				<label for="writer">작성자 : </label>
	        				<input type="text" id="writer">
	        			</td>
	        			<td>
	        				<label for="email">이메일 : </label>
	        				<input type="email" id="email">
	        			</td>
	        			<td>
	        				<label for="passwd">비밀번호 : </label>
	        				<input type="password" id="passwd">
	        			</td>
	        		</tr>
	        		<tr>
	        			<td colspan="3">
	        				<label for="content">내용 : </label><br><br>
	        				<textarea id="content" rows="10"></textarea>
	        			</td>
	        		</tr>
        		</tbody>
        		<tfoot>
        			<tr>
        				<td colspan="4">
        					<input type="button" id="cancelBtn" value="취소">
        					<input type="button" id="writeBtn" value="작성">
        				</td>
        			</tr>
        		</tfoot>
        		<tr>
        		</tr>
        	</table>
        </div>

    </div>

        <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
        <script type="text/javascript">
        	$(function () {
            	$("#writeBtn").on('click', function (event) {
                	var writer = $("#writer").val();
                	var email = $("#email").val();
                	var content = $("#content").val();

                	$.ajax({
                    	url: "/myweb/aboard/write",
                    	type: "post",
                    	data: {
                        	"writer": writer,
                        	"email": email,
                        	"content": content
                        },
                        dataType: "json",
                        success: function(data, status, xhr) {
                            
                        },
                        error: function(xhr, status, err) {
                            alert('방명록 쓰기 실패');
                        }
                    });
                });
            	
            });
        </script>

</body>

</html>