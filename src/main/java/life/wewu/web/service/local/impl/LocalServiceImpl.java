package life.wewu.web.service.local.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import life.wewu.web.domain.active.Local;
import life.wewu.web.service.local.LocalService;

@Service
public class LocalServiceImpl implements LocalService {

	//필드
	@Value("${local.clientId}")
	private String clientId;
	
	@Value("${local.clientSecret}")
	private String clientSecret;
	
	@Value("${local.url}")
	private String url;
	
	@Override
	public Local getSearchLocal(String query) {
		// TODO Auto-generated method stub
		
		Local local = new Local();
		
		try {
			query = URLEncoder.encode(query);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        
        url = url + "?query=" + query;
        
        String responseBody = get(url,requestHeaders);
        
        System.out.println(responseBody);
        
        JsonObject jsonObject = JsonParser.parseString(responseBody.toString()).getAsJsonObject();
        
        System.out.println(":::: " + jsonObject);
        
        if (jsonObject.has("items")) {
        	
        	JsonArray itemsArray = jsonObject.getAsJsonArray("items");
        	JsonObject resultObject = itemsArray.get(0).getAsJsonObject();

        	local.setTitle(resultObject.get("title").getAsString());
        	local.setAddress(resultObject.get("address").getAsString());
        	local.setRoadAddress(resultObject.get("roadAddress").getAsString());
        	local.setMapX(resultObject.get("mapx").getAsString());
        	local.setMapY(resultObject.get("mapy").getAsString());
        	
        } else {
        	return local;
        }
        
        System.out.println("::::: " + local);
		
		return local;
	}
	
	private static String get(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }


            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 오류 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }


    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }


    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);


        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();


            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }


            return responseBody.toString();
            
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
        }
    }

}
