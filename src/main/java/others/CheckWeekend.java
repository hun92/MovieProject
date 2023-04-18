package others;

import java.util.Date;

public class CheckWeekend {
	public static boolean check() {
		Date date = new Date();
		
		long totalDate = date.getTime();
		
		totalDate = totalDate / (1000 * 60 * 60 * 24);
		//						1초 -> 1분 -> 1시간 -> 1일
		
		totalDate = totalDate % 7;
		if(1 < totalDate && totalDate < 4) {
			return true;
		} else {
			return false;
		}
	}
}
