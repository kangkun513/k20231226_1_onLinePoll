package com.tjoeun.onLinePoll;

import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;

public class PollWrite {

// 텍스트 파일의 이름과 파일에 저장할 ArrayList를 넘겨받아 텍스트 파일에 저장하는 메소드
	public static void pollWrite(String filepath, ArrayList<String> poll) {
		
//		ArrayList에 저장된 데이터를 텍스트 파일로 출력하기 위해 PrintWriter 클래스 객체를 선언
		PrintWriter printWriter = null;
		
		try {
//			ArrayList에 저장할 데이터를 텍스트 파일로 출력할 PrintWriter 객체를 생성함
			printWriter = new PrintWriter(filepath);
			
//			ArrayList에 저장된 데이터의 개수만큼 반복하며 텍스트 파일로 출력
			for (String str : poll) {
				printWriter.write(str + "\n");
			}
		} catch (FileNotFoundException e) {
			System.out.println("파일의 경로가 잘못되었거나 파일이 존재하지 않습니다");
		} finally {
//			파일로 출력하는 객체를 close() 메소드를 실행해서 닫지 않으면 파일에 데이터가 저장되지 않음
			if (printWriter != null) {
				printWriter.close();
			}
		}
		
	}
	
}
