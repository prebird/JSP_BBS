<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.io.PrintWriter" %>
 <%@ page import="java.util.ArrayList" %>
 <%@ page import="bbs.Bbs" %>
 <%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-type" charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/bootstrap.css">
	<title>JSP 게시판 웹사이트</title>
	<style type="text/css">
	a, a:hover{
		color: #000000;
		text-decoration: none;	}
	</style>
</head>
<body>
	<%@include file="nav.jsp"%>
	<%
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		// 파라메터가 넘어왓다면
		if (request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		
	%>
	
	<!-- 게시판  -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border=1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++){
					%>
						<tr>
						<td><%= list.get(i).getId() %></td>
						<td><a href="view.jsp?bbsId=<%= list.get(i).getId() %>"><%= list.get(i).getTitle() %> </a></td>
						<td><%= list.get(i).getUserId() %></td>
						<td><%= list.get(i).getRegDate().substring(0, 11) + list.get(i).getRegDate().substring(11, 13) +"시" + list.get(i).getRegDate().substring(14, 16) +"분" %></td>
					</tr>
					<%
						}
					%>
					
				</tbody>
			</table>
			<%
				if(pageNumber != 1){
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber-1 %>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				}
				if(bbsDAO.nextPage(pageNumber + 1)){
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber+1 %>" class="btn btn-success btn-arrow-right">다음</a>
			<% 
				}
			%>

			
			
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>