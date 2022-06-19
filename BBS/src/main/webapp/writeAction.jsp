<%@page import="org.apache.tomcat.websocket.BackgroundProcess"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
<jsp:setProperty property="title" name="bbs"/>
<jsp:setProperty property="content" name="bbs"/>
<!DOCTYPE html>
<html>
<head>

</head>
<body>
	<%
			// 세션값으로 로그인 유무 체크하기
			//String userID = null;
			//if(session.getAttribute("userID") != null){
			//	userID = (String) session.getAttribute("userID");
			//}
			//if(userID == null){
			//	PrintWriter script = response.getWriter();
			//	script.println("<script>");
			//	script.println("alert('로그인을 하세요')");
			//	script.println("location.href = 'login.jsp'"); //로그인페이지로 돌려보내기
			//	script.println("</script>");
			//}
			
			String userID = (String) session.getAttribute("userID");
			
			if(bbs.getTitle() == null || bbs.getContent() == null){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안된 사항이 있습니다.')");
					script.println("history.back()"); //작성으로 돌려보내기
					script.println("</script>");
			}
			else{
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.write(bbs.getTitle(), bbs.getContent(), userID);
				if (result == -1){ // 동일한 아이디 입력 시 DB오류 반환
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()"); //로그인페이지로 돌려보내기
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
				}
				
			}
			
	
	%>
</body>
</html>