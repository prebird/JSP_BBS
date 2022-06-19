<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.io.PrintWriter" %>
 <%@ page import="bbs.Bbs" %>
 <%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-type" charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/bootstrap.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%@include file="nav.jsp"%>
	
	<%
		int bbsId = 0;
		if(request.getParameter("bbsId") != null){
			bbsId = Integer.parseInt(request.getParameter("bbsId"));
		}
		if (bbsId == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않는 글입니다?!')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		BbsDAO bbsDao = new BbsDAO();
		Bbs bbs = bbsDao.getBbs(bbsId);
	%>
	
	<!-- 게시판  -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border=1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width:20%">title</td>
						<td colspan="2"><%=bbs.getTitle() %></td>
					</tr>
					<tr>
						<td>writer</td>
						<td colspan="2"><%=bbs.getUserId() %></td>
					</tr>
					<tr>
						<td>date</td>
						<td colspan="2"><%=bbs.getRegDate() %></td>
					</tr>
					<tr>
						<td>content</td>
						<td colspan="2" style="min-height: 500px; text-align: left;"><%= bbs.getContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")%></td>
					</tr>
					
				</tbody>	
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(bbs.getUserId())){
			%>
				<a href="update.jsp?bbsId=<%=bbsId %>" class="btn btn-primary">수정</a>
				<a href="deleteAction.jsp?bbsId=<%=bbsId %>" class="btn btn-primary">삭제</a>
			<%
			}
			%>
		</div>
	
	</div>
	<script src="js/bootstrap.js"></script>
</body>
</html>