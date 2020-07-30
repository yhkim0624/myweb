<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="header">

	<div class="title">
		<a href="/myweb/">MY WEBSITE</a>
	</div>
	
	<div class="links">

		<c:choose>
			<c:when test="${ empty loginuser }">
				<a href="/myweb/login">Sign In</a>
				<a href="/myweb/register">Sign Up</a>
			</c:when>
			<c:otherwise>
				<a href="#"> ${ loginuser.memberId } </a>님 환영합니다.
			<a href="/myweb/logout">Logout</a>
			</c:otherwise>
		</c:choose>

	</div>
	
</div>

<div id="menu">
	<div>
		<ul>
			<li><a href="/myweb/">HOME</a></li>
			<li><a href="/myweb/nboard/list">Board1</a></li>
			<li><a href="#">Board2</a></li>
			<li><a href="#">Graph</a></li>
			<li><a href="#">Chat</a></li>
		</ul>
	</div>
</div>