package life.wewu.web.repository;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public interface S3Repository {

	//메소드
	//파일 업로드(네이버 스토리지)
	public String uplodaFile(Map<String, Object> map);
	
	//short url 얻기
	public String getShortUrl(String url);
	
}
