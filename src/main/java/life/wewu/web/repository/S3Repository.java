package life.wewu.web.repository;

import java.io.ByteArrayInputStream;
import java.io.File;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.AmazonS3Exception;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

@Repository
public class S3Repository {
	
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
	
	//메소드
	public String uplodaFile(MultipartFile file) {
		
		//파일 업로드 시작
		final AmazonS3 s3 = AmazonS3ClientBuilder.standard()
			    .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(endPoint, regionName))
			    .withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
			    .build();
		
		String folderName = "active";
		
		ObjectMetadata objectMetadata = new ObjectMetadata();
		objectMetadata.setContentLength(0L);
		objectMetadata.setContentType("application/x-directory");
		PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, folderName, new ByteArrayInputStream(new byte[0]), objectMetadata);
		
		//폴더 생성(없으면)
		try {
		    s3.putObject(putObjectRequest);
		    System.out.format("Folder %s has been created.\n", folderName);
		} catch (AmazonS3Exception e) {
		    e.printStackTrace();
		} catch(SdkClientException e) {
		    e.printStackTrace();
		}
		
		//파일 업로드 및 url 받기
		try {
			//파일 업로드
			File uploadFile = new File(System.getProperty("java.io.tmpdir") + System.getProperty("file.separator") + file.getOriginalFilename());
			String keyName = folderName + "/" + uploadFile.getName();
			s3.putObject(bucketName, uploadFile.getName(), uploadFile);
		    System.out.format("Object %s has been created.\n", uploadFile.getName());
		    
		    //url받기
		    return s3.getUrl(bucketName, keyName).toString();
	        
	        
		    
		} catch (AmazonS3Exception e) {
		    e.printStackTrace();
		} catch(SdkClientException e) {
		    e.printStackTrace();
		}
		
		return null;
		
	}
	
}
