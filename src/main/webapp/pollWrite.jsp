<%@page import="com.tjoeun.onLinePoll.PollWrite"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="com.tjoeun.onLinePoll.PollRead"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.Format"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표에 참여해주셔서 감사합니다</title>
</head>
<body>

<!-- pollRead.jsp에서 넘어오는 투표한 항목을 받아서 득표수를 증가시켜 텍스트 파일에 저장 -->
<%
//	post 방식으로 데이터가 넘어올 때 한글 깨짐을 방지
	request.setCharacterEncoding("UTF-8");
//	pollRead.jsp에서 넘어오는 투표 데이터를 받음
	String temp = request.getParameter("poll");
//	out.println(temp);
	
//	에러 체크
//	투표 데이터가 넘어왔나(null 또는 공백이 아닌가) 검사 → 반드시 null 검사를 먼저 해야 함
	if(temp != null && temp.trim().length() != 0)  {
//		out.println(temp);
		
//		넘어온 투표 데이터가 숫자인가 검사
		try {
			int result = Integer.parseInt(temp);
			
			// 텍스트 파일을 읽어서 투표 항목의 개수를 계산
			String filepath = application.getRealPath("/") + "poll.txt";
			ArrayList<String> poll = PollRead.pollRead(filepath);
			int itemCount = (poll.size() - 1) / 2;

			
			// 넘어온 투표 데이터가 정상적인 투표 범위의 데이터인가 검사
			if (result >= 1 && result <= itemCount) {
				
	
				// 여기까지 왔다는 것은 정상적인 투표 데이터가 넘어왔다는 것이므로
				// 투표한 항목의 득표수를 1증가 시켜서 텍스트 파일에 저장	
				// 득표수를 1증가 시킬 ArrayList의 위치(index)를 계산
				int index = result + itemCount;
				// 득표수를 증가시킴
				result = Integer.parseInt(poll.get(index)) + 1;
				// 1증가된 득표수를 ArrayList의 index번째 위치에 넣어줌
				// poll.set(index, String.valueOf(result));
				// poll.set(index, String.format("%s", result));
				poll.set(index, result + "");
				// out.println(poll);
				// ArrayList에 저장된 데이터를 텍스트 파일에 저장하는 메소드 실행
				PollWrite.pollWrite(filepath,poll);
//				for(int i=0; i<poll.size(); i++){
//					printWriter.write(poll.get(i) + "\n");
//				}
					
				// 투표 결과보기 페이지로 넘겨줌
				response.sendRedirect("pollResult.jsp");
				
			} else {
				// 넘어온 투표 데이터가 정상 범위의 숫자가 아니므로 오류 메시지를 출력하고 pollRead.jsp로 돌려보냄
				out.println("<script>");
				out.println("alert('데이터가 올바른 범위가 아닙니다')");
				out.println("location.href='pollRead.jsp'");
				out.println("</script>");
			}
			
		} catch(NumberFormatException e) {
			// 넘어온 투표 데이터가 숫자가 아니므로 오류 메시지를 출력하고 pollRead.jsp로 돌려보냄
			out.println("<script>");
			out.println("alert('데이터가 올바르지 않습니다')");
			out.println("location.href='pollRead.jsp'");
			out.println("</script>");
		}
		
	} else {
//		투표 데이터가 넘어오지 않았으므로 오류 메세지를 출력하고 pollRead.jsp로 돌려보냄
		out.println("<script>");
		out.println("alert('투표할 팀을 선택해 주십시오')");
		out.println("location.href='pollRead.jsp'");
		out.println("</script>");
		
//		하나의 jsp 파일에 서버용 스크립트(jsp)와 클라이언트용 스크립트(javascript)를 모두 사용한 경우
//		코딩 순서와는 상관 없이 서버용 스크립트가 먼저 다  실행된 후 클라이언트용 스크립트가 실행됨
//		response.sendRedirect() 소드는 인수로 지정한 페이지로 넘겨줌
//		response.sendRedirect("pollRead.jsp");
	}

%>

</body>
</html>