package life.wewu.web.repository.impl;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
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
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.AmazonS3Exception;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import life.wewu.web.repository.S3Repository;

@Repository
public class S3RepositoryImpl implements S3Repository {
	
	//필드
	@Value("${storage.endPoint}")
	private String endPoint;
	
	private String regionName = "kr-stand";
	
	@Value("${storage.accessKey}")
	private String accessKey;
	
	@Value("${storage.secretKey}")
	private String secretKey;
	
	@Value("${storage.bucketName}")
	private String bucketName;
	
	@Value("${short.clientId}")
	private String clientId;
	
	@Value("${short.clientSecret}")
	private String clientSecret;
	
	//메소드
	//파일 업로드
	public String uplodaFile(Map<String, Object> map) {
		
		//파일 업로드 시작
		MultipartFile file = (MultipartFile)map.get("file");
		
		//File uploadFile = (File)map.get("uploadFile");
		
		//이미지 파일이 없다면 null return
		if(file == null) {
			return null;
		}
		
		String folderName = map.get("folderName").toString();
		
		final AmazonS3 s3 = AmazonS3ClientBuilder.standard()
			    .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(endPoint, regionName))
			    .withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
			    .build();
		
		ObjectMetadata objectMetadata = new ObjectMetadata();
		objectMetadata.setContentLength(0L);
		objectMetadata.setContentType("application/x-directory");
		PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, folderName, new ByteArrayInputStream(new byte[0]), objectMetadata);
		
		//폴더 생성(없으면)
		try {
		    s3.putObject(putObjectRequest);
		    //System.out.format("Folder %s has been created.\n", folderName);
		} catch (AmazonS3Exception e) {
		    e.printStackTrace();
		} catch(SdkClientException e) {
		    e.printStackTrace();
		}
		
		//파일 업로드 및 url 받기
		try {
			//파일 업로드
			//File uploadFile = new File(System.getProperty("java.io.tmpdir") + System.getProperty("file.separator") + file.getOriginalFilename());
			File uploadFile =  convert(file);
			
			UUID uuid = UUID.randomUUID();
			String keyName = folderName + "/" + uuid;
			s3.putObject(bucketName, keyName, uploadFile);
		    //System.out.format("Object %s has been created.\n", uploadFile.getName());
		    
		    // 파일에 대한 ACL 설정 (공개로 설정)
	        s3.setObjectAcl(bucketName, keyName, CannedAccessControlList.PublicRead);
		    
		    //url받기
		    return s3.getUrl(bucketName, keyName).toString();
	        
	        
		    
		} catch (AmazonS3Exception e) {
		    e.printStackTrace();
		} catch(SdkClientException e) {
		    e.printStackTrace();
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
		
	}
	
	@Override
	public String getShortUrl(String url) {
		// TODO Auto-generated method stub
		try 
		{
			
			String apiURL = "https://naveropenapi.apigw.ntruss.com/util/v1/shorturl";
            URL api = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)api.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json");
            con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
            con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);
            
            // Enable output stream
            con.setDoOutput(true);
            
            // post request
            JSONObject json = new JSONObject();
            json.put("url", url);
            String postParams = json.toString();
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(postParams);
            wr.flush();
            wr.close();
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 오류 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            //System.out.println(response.toString());
            
            JsonObject jsonObject = JsonParser.parseString(response.toString()).getAsJsonObject();
            if (jsonObject.has("result")) {
            	JsonObject resultObject = jsonObject.getAsJsonObject("result");
            	return resultObject.get("url").getAsString(); // 단축 URL 반환
            } else {
            	return null;
            }
            
        } catch (Exception e) {
            System.out.println(e);
            return null;
        }
		
	}
	
	public File convert(MultipartFile file) throws IOException
	{    
	    File convFile = new File(file.getOriginalFilename());
	    convFile.createNewFile(); 
	    FileOutputStream fos = new FileOutputStream(convFile); 
	    fos.write(file.getBytes());
	    fos.close(); 
	    return convFile;
	}

//	@Override
//	public String getShortUrl(String url) {
//		// TODO Auto-generated method stub
//		String encodedUrl = null;
//		
//		try {
//			encodedUrl = URLEncoder.encode(url, "UTF-8");
//		} catch (UnsupportedEncodingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		String apiURL = "https://openapi.naver.com/v1/util/shorturl?url=" + encodedUrl;
//		
//		Map<String, String> requestHeaders = new HashMap<>();
//        requestHeaders.put("X-NCP-APIGW-API-KEY-ID", clientId);
//        requestHeaders.put("X-NCP-APIGW-API-KEY", clientSecret);
//        String responseBody = get(apiURL,requestHeaders);
//        System.out.println(responseBody);
//		
//        // JSON 파싱
//        JsonObject jsonObject = JsonParser.parseString(responseBody).getAsJsonObject();
//        if (jsonObject.has("result")) {
//            JsonObject resultObject = jsonObject.getAsJsonObject("result");
//            return resultObject.get("url").getAsString(); // 단축 URL 반환
//        } else {
//            return null;
//        }
//	}
//	
//	//short url 얻는데 필요한 함수
//	private static String get(String apiUrl, Map<String, String> requestHeaders){
//        HttpURLConnection con = connect(apiUrl);
//        try {
//            con.setRequestMethod("GET");
//            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
//                con.setRequestProperty(header.getKey(), header.getValue());
//            }
//
//            int responseCode = con.getResponseCode();
//            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
//                return readBody(con.getInputStream());
//            } else { // 에러 발생
//                return readBody(con.getErrorStream());
//            }
//        } catch (IOException e) {
//            throw new RuntimeException("API 요청과 응답 실패", e);
//        } finally {
//            con.disconnect();
//        }
//    }
//
//    private static HttpURLConnection connect(String apiUrl){
//        try {
//            URL url = new URL(apiUrl);
//            return (HttpURLConnection)url.openConnection();
//        } catch (MalformedURLException e) {
//            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
//        } catch (IOException e) {
//            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
//        }
//    }
//
//    private static String readBody(InputStream body){
//        InputStreamReader streamReader = new InputStreamReader(body);
//
//        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
//            StringBuilder responseBody = new StringBuilder();
//
//            String line;
//            while ((line = lineReader.readLine()) != null) {
//                responseBody.append(line);
//            }
//
//            return responseBody.toString();
//        } catch (IOException e) {
//            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
//        }
//    }
	
}
