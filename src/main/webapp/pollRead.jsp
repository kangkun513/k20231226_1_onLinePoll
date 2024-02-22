<%@page import="java.util.ArrayList"%>
<%@page import="com.tjoeun.onLinePoll.PollRead"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표하기</title>

<!-- favicon: 웹 브라우저의 title에 표시되는 웹 사이트를 대표하는 이미지이다. -->
<link rel="icon" href="./images/logo.png">

</head>
<body>

<!-- 투표 항목이 저장된 realpath의 텍스트 파일을 읽어서 브라우저에 출력한다. -->
<%
//	이클립스는 프로젝트를 실행하면 프로젝트를 이클립스가 내부적으로 사용하는 웹 서버에 복사하고 실행한다.
//	application.getRealPath("/") 메소드를 실행하면 프로젝트가 실행되는 실제(real) 경로(path)를 얻어온다.
//	out.println(application.getRealPath("/"));
//	C:\k_digital\kdigital\web\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\k20231226_1_onLinePoll\
//	out.println(application.getRealPath("/") + "poll.txt");
//	C:\k_digital\kdigital\web\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\k20231226_1_onLinePoll\poll.txt
//	투표 내용이 저장된 파일을 읽어올 실제 경로와 파일 이름을 연결한다.
	String filepath = application.getRealPath("/") + "poll.txt";
//	투표 내용이 저장된 텍스트 파일을 읽어오는 메소드를 실행한다.
	ArrayList<String> poll = PollRead.pollRead(filepath);
//	out.println(poll);
//	for (String str: poll){
//		out.println(str + "<br>");
//	}
// 투표 항목의 개수를 계산
	int itemCount = (poll.size() - 1) / 2;
//	out.println(itemCount + "<br>");
%>

<form action="pollWrite.jsp" method="post">
	<!-- 
		border: 선 두께
		width: 표 전체 너비
		align: 표 정렬 방식, 기본값은 left
		cellspacing: 셀과 셀 사이의 간격
		cellpadding: 셀 안 여백, 셀을 구성하는 선과 셀 내부 텍스트와의 간격
	-->
	<table border="1" width="500" align="center" cellspacing="0" cellpadding="5"> <!-- 표 -->
		<tr> <!-- 줄 -->
			<th> <!-- 칸, 표의 첫 줄 또는 첫 열을 구성하는 칸, 굵게 및 가운데 정렬되어 표시 -->
				<%=poll.get(0)%> <!-- 표현식, 간단한 출력에 사용 -->
			</th>
		</tr>
	<%
		for(int i=1; i<=itemCount; i++){
			
	%>
		<tr>
			<td> <!-- 칸, 표의 첫 줄 또는 첫 열을 제외한 나머지를 구성하는 칸 -->
				<input type="radio" name="poll" value="<%=i%>">
				<%=poll.get(i)%>
			</td>
		</tr>
	<%		
		}
	%>
		<!-- 투표하기 버튼과 결과보기 버튼을 만듬 -->
		<tr>
			<td align="center">
				<input type="submit" value="투표 하기">
				<input type="button" value="결과 보기" onclick="location.href='pollResult.jsp'">
			</td>
		</tr>
	</table>
</form>


</body>
</html>
























