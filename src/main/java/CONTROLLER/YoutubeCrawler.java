package CONTROLLER;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

public class YoutubeCrawler {
    public static void main(String[] args) {
    	System.setProperty("webdriver.chrome.driver", "C:\\selenium\\chromedriver.exe");
		   
        WebDriver driver = new ChromeDriver();
        
        try {
            driver.get("https://www.youtube.com/results?search_query=kpop");

            WebElement firstVideo = driver.findElement(By.cssSelector("a#video-title"));
            String title = firstVideo.getText();
            String url = firstVideo.getAttribute("href");

            System.out.println("Title: " + title);
            System.out.println("URL: " + url);
        } finally {
            driver.quit();
        }
    }
}






